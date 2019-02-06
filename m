Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC2BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3E02184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TrxXVnGK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tn/zoZBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3E02184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=edm2o3O5mb1uosPAc3i9f0XYa3JiwMr5TP3CxExzyL8=; b=TrxXVnGKsGCwM/
	1ql1WXIceByZVHKFKKihd+ohO2OH1s5DY6Xmq5tKEVOXkFrWBQiXVO3JBpyafcodBZbRAkmUZ9/Ko
	Bn5x2Oo1zJBFwqpBItqodSv5NvLBQ6Pirch6ua0vog6Y+UiYTtGCdtgpIPufixMYVVbXeockw+Mis
	yfJqe0ysFXpDslcnZYFRBQZcI1j7yx0XyCnXdFzb2WFwNGmGjywtdyhoPbsqHGpX4dDc4tru8mA6W
	uLobpFtLYJC/aAK4h0K9ZQ3zKAY9taHEFKNwygSIOrd/5iRmz/kwYpOJyXu8ku7lHRn6K1fRGyxb4
	+mrm1/uaNY+tixQTlNMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grL5n-0006aI-9G; Wed, 06 Feb 2019 11:10:11 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grL5l-0006Ai-Hb
 for linux-arm-kernel@bombadil.infradead.org; Wed, 06 Feb 2019 11:10:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
 Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Oh2Mwu5MB2EY3UCcLaf7ooqTrxsNH7VWKFroWZ2WENY=; b=Tn/zoZBZK0ZZukTYpxUq2+C+U
 RaNjiLPHfzdv5mDQBlkgq4dm+yjOvUztTpvpPtBF1lQyvXunH5OE0fwpUssh/tuJdWF1RPlFcIHRq
 LrsAXDfmUQhiwy1SPUan/9zIK7niRu5F70CDjt7lxfJsIhxGuEleFvtLSP+aVAnJgmHbmKU2fkCwT
 do26ebpp54K+MnpbdXjTHdG1qqug5jmiF8yKUmu0IsLqyMQYKhd7JUYRtnx0MwNqYWEKzvqFEtaau
 Jr++jLHO3klOYXuYeuh35+JDpp8mvrLD9UgGT8i0YMcXbYuY6nmGetDBp0RqOGlycVaMH/goxUCZA
 yIxrrWwWQ==;
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grL5i-0002bT-4s
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 11:10:07 +0000
X-Originating-IP: 109.213.164.40
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr
 [109.213.164.40]) (Authenticated sender: gregory.clement@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E0A6E4000F;
 Wed,  6 Feb 2019 11:09:28 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 4/6] ARM64: dts: marvell: armada-37xx: fix USB2 memory
 region
In-Reply-To: <20190129093635.4321-5-miquel.raynal@bootlin.com>
References: <20190129093635.4321-1-miquel.raynal@bootlin.com>
 <20190129093635.4321-5-miquel.raynal@bootlin.com>
Date: Wed, 06 Feb 2019 12:09:28 +0100
Message-ID: <87zhr96umv.fsf@FE-laptop>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_061006_290061_AF040521 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Miquel,
 
 On mar., janv. 29 2019, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The specification splits the USB2 memory region into three sections:
> 1/ 0xD005E000-0xD005EFFF: USB2 Host Controller Registers
> 2/ 0xD005F000-0xD005F7FF: USB2 UTMI PHY Registers
> 3/ 0xD005F800-0xD005FFFF: USB2 Host Miscellaneous Registers
>
> Section 1/ belongs to the USB2 node but section 2/ belongs to the UTMI
> PHY node. Section 3/ can be accessed by both the USB controller and
> the PHY because of the miscaellaneous nature of the registers inside
> so a specific node will be created to cover the area and a handle to
> it will be added in both the USB controller and the PHY node.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index d6e548618a95..5cfd1b920f31 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -351,7 +351,7 @@
>  
>  			usb2: usb@5e000 {
>  				compatible = "marvell,armada-3700-ehci";
> -				reg = <0x5e000 0x2000>;
> +				reg = <0x5e000 0x1000>;
>  				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>  				status = "disabled";
>  			};
> -- 
> 2.19.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
