Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125DAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BB02070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j7OWsGTq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bnZ00ESd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BB02070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VP6dfbLGAOdIAIMgtJ/yR/TN5P4NI57Lc83NzHl/huw=; b=j7OWsGTqK8jbeA
	W2xDuaW/OG1TqS4uVCiRnw/Me1JKqc2niyK1Q+1QQnxdMEMvHUbNB7seDsfEob+8xNm6NDvMdf/jy
	TYCSA2GEqWlQQKyxzch1Q8UbpgLHvwnOi+2mfPfOA6J5V4mvcPeavgZn9M/lcnpP74FWFLM4aWt5f
	D9zvlupioPdzDOK84h5M4Vb/d+l9/gl/KHFJSWPHAVwvszKBLICQJ20IiUrIpD7myjbSqOQMV+Msr
	Zth0Yj8JNwj6yjSZn1fOuEncFTX3/e0e0xfOyNAnqd69M6nb3ysHuQXu9RmSIoqNMSqHkFrQ1CW3p
	qncBfKAYTfAuXO6hjjDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxADU-0004ph-HX; Fri, 22 Feb 2019 12:46:12 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxADS-0004pY-Ae
 for linux-arm-kernel@bombadil.infradead.org; Fri, 22 Feb 2019 12:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N8SckLN4Ri5gGHmxZSovgsJJj8Up60DXK9vFN0jnjo8=; b=bnZ00ESdP6qNtOohrsv2wGXlAQ
 1rKP3s2DcEXNDF/tuZZeBelonTdjG5EwbPX5N5s+joAzpvu4iiVm/P3HNQTFJ0FC7Vw2pSMJsdw9P
 Do1TimkfDp2r03UY6HeP90WcI20OPgM4z84Ao6coQHrS/Dg4yjQwYRXzTs2sPHzELKi2fBmkllOjB
 9amBpGQeOcYqJgwuEsLAyoVDCMYsogibE4uHP4RH72n04zTm0MAvAVDomGLObyWhSFlbc8xecIzAX
 op4a0Jl4ZKo+EJ+Rlx8N70/zDYax//t3KGYrRr8c5aWy/YC95jGWVDNoRpp6xIFGFG/chYBwLlor4
 6IzCjkjQ==;
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxADP-0002RX-2i
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:46:08 +0000
X-Originating-IP: 90.88.23.190
Received: from windsurf (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 94FC71BF212;
 Fri, 22 Feb 2019 12:45:29 +0000 (UTC)
Date: Fri, 22 Feb 2019 13:45:28 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 0/2] PCI: fix pci-mvebu after conversion to common
 bridge emul code
Message-ID: <20190222134528.138099c1@windsurf>
In-Reply-To: <20190222110450.GA32670@e107981-ln.cambridge.arm.com>
References: <20190220094841.11129-1-thomas.petazzoni@bootlin.com>
 <20190221232317.GB219879@google.com>
 <20190222093554.367e3c91@windsurf>
 <20190222110450.GA32670@e107981-ln.cambridge.arm.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_074607_236393_DF9A63F2 
X-CRM114-Status: UNSURE (   8.90  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Leigh Brown <leigh@solinno.co.uk>,
 Lu??s Mendes <luis.p.mendes@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Lorenzo,

On Fri, 22 Feb 2019 11:05:12 +0000
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> > Isn't that sufficient ?  
> 
> Adding a CC: stable won't hurt so that it is certain it will get
> stable kernels attention, that's what I will do.

Ah, yes, indeed. Sorry for forgetting about these, and thanks for
applying with those Cc: stable added!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
