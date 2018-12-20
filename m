Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230E0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:08:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C1E21741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mtQ9RK1a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="kWeiIsNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C1E21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TRulJOwRpcgnjXiaka73jjppL6K7Zbec7OXYCSaqtO4=; b=mtQ9RK1aFQe8Ni
	SfFltoCyePQ3KcPUt9kYco8Pb5B3x1khF1LUIomp5gnQ/gIFRURjwpI2BXXuqIi1HL9pexNFmSQ02
	+gIfmuoM6c1FloWef8X3zJRWr0bii+rzAAfjKsUGpHPPn++YyasxCY5dmq3tY6/bQ+r9rb5Hm4OwL
	rPhgOfNVfKgdZvjKnRHfpmB5rbUFXqyb6X12dwDN6noZwzpeuROibsC69Ea0AvnEQuJOWUht5puvg
	POtNiHToEVoPLkB1nyOwBiYutKrXvkey5cs7sAYJEn0b53ezPIutpo2ScrK3DvNsO5pqz6bQK/icj
	bX1GjvrQLg/G5NZ7E7kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga6Um-0003Dr-U9; Thu, 20 Dec 2018 22:08:44 +0000
Received: from mail.nic.cz ([217.31.204.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga6Uj-0003Cy-0j
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 22:08:42 +0000
Received: from localhost (unknown [172.20.6.218])
 by mail.nic.cz (Postfix) with ESMTPS id 88B88600F5;
 Thu, 20 Dec 2018 23:08:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1545343706; bh=H4JBnC6QW8uHkZCkoqXa+jUY2pFfD5NM0SL1fQgu6uw=;
 h=Date:From:To;
 b=kWeiIsNwWUi8F/MCZz6L1h9S1KiFkZn6ORW/gw7Pce6B0RU8HO12KHHGKDr9vHfXx
 Txh6+4IWBNJ5D5u3X76dKBHOY3qpOA9UHm4545MIaEGcfYn48kwkxrOcIKj8pQ/bNa
 cTKjUdGQlyABB6Abn2KRWmtzWmDr3UyBJ8+0BLLo=
Date: Thu, 20 Dec 2018 23:08:21 +0100
From: Marek Behun <marek.behun@nic.cz>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: mailbox: Document
 armada-37xx-rwtm-mailbox binding
Message-ID: <20181220230821.3f21163a@nic.cz>
In-Reply-To: <20181220214447.GA18008@bogus>
References: <20181217153706.25873-1-marek.behun@nic.cz>
 <20181217153706.25873-2-marek.behun@nic.cz>
 <20181220214447.GA18008@bogus>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_140841_222883_955BB5B7 
X-CRM114-Status: UNSURE (   6.27  )
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
Cc: devicetree@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > +- compatible :	must be "marvell,armada-37xx-rwtm-mailbox"  
> 
> Don't use wildcards in compatible strings.
> 

You mean that "mailbox" shouldn't be there?

Marek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
