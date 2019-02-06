Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3F3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:09:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94942175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h/VoXLfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94942175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=etmGGWvhqcPytDLj2xtAN8Eg1UYUajHfe79XBwRmuOk=; b=h/VoXLfijUmyLd
	8Qd3xTNGdt4lWh9lIbBHUj1zPmAiTjdMNt3b/rrFe0MTxI+ou/ZEeE4fcwlO7tjCj8yQEPZEHSgBA
	NMQ16IHggPxiDL98Aqb7Zxivl6szlRhN4EyW1fzVn7MiRGEn/NcfHgrU1EHdIRRI6XVut2XopTjJX
	9D/LXF4pigFlO+tR3NtssE+zUaLAw5z7BuhgZaaIXSr50ONLC9NRRkTfwfU5h5alJ1Yw5enA1NXe8
	fQvBdCkv6pj/hpBzj88R3iJgBWxWDIDjSwewi1YrMq0g3vLxtGVQGu0fqdKISuA62gmtzsbE/S5Nr
	tGj5Lq+ZcNAfsppjql7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grOpb-0001C7-He; Wed, 06 Feb 2019 15:09:43 +0000
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grOpX-0001BW-Rc
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 15:09:41 +0000
X-Originating-IP: 90.88.22.177
Received: from bootlin.com (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 96B291BF208;
 Wed,  6 Feb 2019 15:09:29 +0000 (UTC)
Date: Wed, 6 Feb 2019 16:09:28 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next 5/6] net: marvell: neta: add comphy support
Message-ID: <20190206160928.56fb4808@bootlin.com>
In-Reply-To: <E1grLTv-00061v-Tw@rmk-PC.armlinux.org.uk>
References: <20190206113409.ko7lwuv5kb7l7rjo@shell.armlinux.org.uk>
 <E1grLTv-00061v-Tw@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_070940_543555_61E75393 
X-CRM114-Status: UNSURE (   7.38  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, "David S.
 Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Russell,

On Wed, 06 Feb 2019 11:35:07 +0000
Russell King <rmk+kernel@armlinux.org.uk> wrote:


>+	if (pp->comphy) {
>+		enum phy_mode mode = PHY_MODE_INVALID;
>+
>+		switch (state->interface) {
>+		case PHY_INTERFACE_MODE_SGMII:
>+		case PHY_INTERFACE_MODE_1000BASEX:
>+			mode = PHY_MODE_SGMII;

PHY_MODE_SGMII no longer exists, the new PHY_MODE_ETHERNET must be used
with the correct submode now, so this doesn't build unfortunately.

>+			break;
>+		case PHY_INTERFACE_MODE_2500BASEX:
>+			mode = PHY_MODE_2500SGMII;

Same here.

Thanks,

Maxime

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
