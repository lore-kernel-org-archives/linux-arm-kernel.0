Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F489C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:28:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7C420652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KMcGXJqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7C420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A1XePV6yr5XNZO3QLbEN2+epAZsnx73EqOCB4UPFXIo=; b=KMcGXJqkJknpdO
	gg+anJdVWU791vKygQX0B4UwhK1Mo2pKOFx3ke/eAgzG2WE1H1kih5lmTqFrALEySbjAbwCVaL5e4
	+M02potDYpzL8m48Pl43Eyp2FzLF+ywz1b/MP4qZAq9u6JPXnwJqf337NUTkUIxLEAwwU+JrA6Ooz
	8BhjMWLWe5EQFy/7N3f88GRZ1DiDTCCSopR4mFjIFcLd21vk54zohPWH+vo0OBCXyef505iXw75qY
	gYlvBzJMz41RbdjvtnYQCmgmt/KlCRO7CQ/ICkjCH1n3/yaO89peWopmzpx9xxIOZZUg/mw5YtoGr
	1+7/3gUtDvcLQwGm2Ufw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxeqh-0007OY-Cn; Sat, 23 Feb 2019 21:28:43 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxeqe-0007NX-4l
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 21:28:41 +0000
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id D5A6414BEE20F;
 Sat, 23 Feb 2019 13:28:34 -0800 (PST)
Date: Sat, 23 Feb 2019 13:28:34 -0800 (PST)
Message-Id: <20190223.132834.658153280215105502.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Subject: Re: [PATCH net] net: phy: marvell10g: Fix Multi-G advertisement to
 only advertise 10G
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190221165411.9739-1-maxime.chevallier@bootlin.com>
References: <20190221165411.9739-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Sat, 23 Feb 2019 13:28:35 -0800 (PST)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_132840_182286_863447E6 
X-CRM114-Status: GOOD (  11.56  )
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
Cc: andrew@lunn.ch, f.fainelli@gmail.com, antoine.tenart@bootlin.com,
 netdev@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 hkallweit1@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Thu, 21 Feb 2019 17:54:11 +0100

> Some Marvell Alaska PHYs support 2.5G, 5G and 10G BaseT links. Their
> default behaviour is to advertise all of these modes, but at the moment,
> only 10GBaseT is supported. To prevent link partners from establishing
> link at that speed, clear these modes upon configuring aneg parameters.
> 
> Fixes: 20b2af32ff3f ("net: phy: add Marvell Alaska X 88X3310 10Gigabit PHY support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reported-by: Russell King <linux@armlinux.org.uk>
> ---
> 
> Dave,
> 
> This patch will conflict when merging net into net-next, and is actually
> not needed there. In net-next, this issue is fixed by the recent work
> done by Andrew and Heiner, that introduce more generic ways to handle aneg
> configuration for C45 PHYs.
> 
> The commit fixing this would be :
> 3de97f3c6308 ("net: phy: marvell10g: use genphy_c45_an_config_aneg")
> 
> However this fix should be backported, hence why it was implemented in a
> small standalone patch here.
> 
> Please tell me if you have any issue with this.

Understood, this is fine.

Applied and queued up for -stable.

Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
