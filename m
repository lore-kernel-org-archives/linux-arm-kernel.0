Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32F5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:38:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744A7217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gdze8m39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744A7217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6bIJNflka4UipVwb1IQxwJX6PjqQyzyiSWioTsXxmdQ=; b=Gdze8m39b9z98g
	qZGy6ykOdHyHPSoep0PrRv68miNrE4n1+w1t6EGD9PRuSp7/1FWsvDwzkru/7Kr0KAJX3hHaslgur
	O3YNQAQOX1dBS2azCUJWSYZLWEnQHky2LKMNGrpRPfF69d75hZpZN/iQ+a0qzlOwdNDGPa0y/LDal
	vGS7NRLcr31INWbLi/zWNtPIpwA53lvYVLGVND6Z9sKjyQYzQm6P+WE4QhStA8e9ZqrubyEfNLhq3
	QfmJSILVHTntNVUsdS11E0eW0mEhpetvFWVbS53IHIZAO6V/BH8bzerJ+KmDzKdFBUthW6Xn0QyN8
	UkK9GYeQoCBQ9CUZLDFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJea-0001wg-KT; Wed, 06 Feb 2019 09:38:00 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJeX-0001wH-7K
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:37:59 +0000
Received: from localhost (alyon-652-1-30-254.w109-213.abo.wanadoo.fr
 [109.213.13.254]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5B439240008;
 Wed,  6 Feb 2019 09:37:43 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 6/7] ARM64: dts: marvell: armada-37xx: fix SATA node
 scope
In-Reply-To: <20190108163124.6409-7-miquel.raynal@bootlin.com>
References: <20190108163124.6409-1-miquel.raynal@bootlin.com>
 <20190108163124.6409-7-miquel.raynal@bootlin.com>
Date: Wed, 06 Feb 2019 10:37:42 +0100
Message-ID: <878syt8dg9.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_013757_428376_7D1D52B0 
X-CRM114-Status: GOOD (  15.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,
 
 On mar., janv. 08 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Fix the SATA IP memory area which is only 0x178 bytes long (from
> Marvell A3700 specification). Actually, starting from the offset
> 0xe0178, there is an area dedicated to the COMPHY driver.
>
> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

As this one don't depend of the other part of the series I applied thi
patches to mvebu/dt64.

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 4472bcd8f9fb..e7405931f381 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -358,7 +358,7 @@
>  
>  			sata: sata@e0000 {
>  				compatible = "marvell,armada-3700-ahci";
> -				reg = <0xe0000 0x2000>;
> +				reg = <0xe0000 0x178>;
>  				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>  				status = "disabled";
>  			};
> -- 
> 2.19.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
