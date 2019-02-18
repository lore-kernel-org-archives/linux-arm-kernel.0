Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6D0C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59BA2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kO9ktwGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59BA2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3FJEgbJBmj9i8fEJKjDlq2pyJ2RLeKApQnWAab6t2X0=; b=kO9ktwGLlTVQhn
	Uo1u0s80Vnbvtgs5nPKqosMcXDkb+QzlrpGVxdj1wsNtEUWJ+W93XfZ9GSvg7SGSVb4Gfhvw6f72E
	HugyK1SVl34nS+E2fcFEf0HAzl7lfIhOjmZoydjV5wIteL/Gt1kb6fAQJfslQcMUoAqTX5lrQbn07
	0lpGs7oGdrlrXf1JCxmYJ/wByp+TSiXm+JbLE4rk4NZt5PpS/tmXoPG2OYowKVsqeCBcNVd/SGRYh
	AOnBC1QjUTCCGWGTh4XEmmwUjS1xVFCCXMmRtUTEsZOcqgS5GSHxrLrgupl/CnMNnLq0q2fjr7zs0
	u7qNYGrIzbMp+rkxNAzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjyd-0005A2-5s; Mon, 18 Feb 2019 14:32:59 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjyZ-00058h-Gz
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:32:57 +0000
Received: from atomide.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 251B280E4;
 Mon, 18 Feb 2019 14:32:59 +0000 (UTC)
Date: Mon, 18 Feb 2019 06:32:45 -0800
From: Tony Lindgren <tony@atomide.com>
To: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190218143245.GC15711@atomide.com>
References: <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
 <20190213152620.GS5720@atomide.com>
 <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_063255_602391_ECB50958 
X-CRM114-Status: UNSURE (   9.44  )
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
Cc: Nishanth Menon <nm@ti.com>,
 Device Tree Mailing List <devicetree@vger.kernel.org>, jason@lakedaemon.net,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, marc.zyngier@arm.com,
 Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [190216 03:30]:
> On 2/15/2019 9:46 PM, Tony Lindgren wrote:
> > The dts node for the interrupt controller should describe a
> > proper Linux device, that is with reg entries and so on.
> 
> You are asking to just keep the compatible property :)

Right, and then I realized this node is missing the standard
reg entry too. And you're saying the registers are not even
accissible from Linux.

So based on that IMO you should not even have a device tree
node for it at all. You should just have the interrupt
controller driver do the muxing on request_irq() using tisci
calls.

If that's not true, and these mux registers are accessible
from Linux, then set up proper dts node with reg entries.
And have the driver deal with the firmware based on the
compatible node.

Regards,

Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
