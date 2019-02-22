Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFA7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:14:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA512070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q6D2Y75a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FU+ES15K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA512070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AvW8jZrXyKNMWIpxeiej+LMeEsJ+trHtb0x62nbeKaM=; b=q6D2Y75a3Zctrj
	x6YLlrpbhCe38Rop1fc0MMyEX7go93Hdao9LvTmpeH6cmzCkoqSX2E05Y/z0kwxU50RS5hXKdiCRU
	qXKymGYzoQt8C7Fd240eazK1C3HCV/Sdsuq0l571EtiLBidhq7E+FmP0r0VkQOzV0kFyA32lnp4Rh
	+CE5yUwGocCVrYplwt+KXE17xhpFH/4syDH+Pf+z9xAinrM+TcUm7uu6ABBiz8HDU0awIaQTg9PkV
	/G1sE3S9rBmmbj1O99L8aWXtX93x1TDY1cH+JpBJtXrU1pC8aKuqylilmMtFtMIGRzny7Nxonm2nu
	vhcZivD3/U390iSJsFUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCWb-000449-6r; Fri, 22 Feb 2019 15:14:05 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCWX-00043m-2I
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:14:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=klVEye0wFqmNyhO07dpdionhZo/NFgdLL7dYU6FSe5I=; b=FU+ES15KXUflwpZ732pqnoedj
 lgOer7RVovgT42DCshZy+DmJAEOVnecNUvKDD3dDQ8UNp8eIkeCOnMH8nH0GSGy8Gp8v5AedXB5oC
 3ojLotXF9UNGFGoTnMfTLcBYWVIyzktrZ0eX3N8FbIf55/stl4qF0QJzsKMj07+op18g3KFt/U7Mn
 O2H+0vCDZ/FUm53DVRflHWDAisftDoLbYxqheqicbqAYfbV/I7GuRR/jBNmk9n5gJNkxwrYdYpZc1
 Y0jlbkOHNkSe/z00JZpsMwBeed4uDHIXnvLcycPBwqRsrFPPw1wIxN/ORe+mmPrGja3EIIAqvcVLl
 zgmfi1K6Q==;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36996)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gxCWC-0002fw-Q7; Fri, 22 Feb 2019 15:13:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gxCW7-0002Ht-AW; Fri, 22 Feb 2019 15:13:35 +0000
Date: Fri, 22 Feb 2019 15:13:35 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 5/5] arm64: dts: marvell: armada-cp110: Switch to
 per-port SATA interrupts
Message-ID: <20190222151335.r27yreym5bhaoqaw@shell.armlinux.org.uk>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222145356.23072-6-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_071401_720860_8F868690 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 03:53:56PM +0100, Miquel Raynal wrote:
> From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> 
> There are two SATA ports per CP110. Each of them has a dedicated
> interrupt. Describe the real hardware by adding two SATA ports to the
> CP110 SATA node and enabling them in all the DTs including it
> (7040-db/8040-db/8040-clearfog).
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts |  7 ++++++-
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts | 14 ++++++++++++--
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi  | 16 ++++++++++++++--
>  3 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 412efdb46e7c..54c1c0ddc813 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -194,7 +194,12 @@
>  };
>  
>  &cp0_sata0 {
> -	status = "okay";
> +	sata-port@0 {

Don't these all need a reg = <N> to correspond with @N in the node name?

> +		status = "okay";
> +	};
> +	sata-port@1 {
> +		status = "okay";
> +	};
>  };
>  
>  &cp0_usb3_0 {
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 1bac437369a1..988cc7dc15d9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -147,7 +147,12 @@
>  
>  /* CON4 on CP0 expansion */
>  &cp0_sata0 {
> -	status = "okay";
> +	sata-port@0 {
> +		status = "okay";
> +	};
> +	sata-port@1 {
> +		status = "okay";
> +	};
>  };
>  
>  /* CON9 on CP0 expansion */
> @@ -279,7 +284,12 @@
>  
>  /* CON4 on CP1 expansion */
>  &cp1_sata0 {
> -	status = "okay";
> +	sata-port@0 {
> +		status = "okay";
> +	};
> +	sata-port@1 {
> +		status = "okay";
> +	};
>  };
>  
>  /* CON9 on CP1 expansion */
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index b9d9f31e3ba1..f27edddcacd1 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -292,10 +292,22 @@
>  			"generic-ahci";
>  			reg = <0x540000 0x30000>;
>  			dma-coherent;
> -			interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&CP110_LABEL(clk) 1 15>,
>  				 <&CP110_LABEL(clk) 1 16>;
> -			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			sata-port@0 {
> +				reg = <0>;
> +				interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			sata-port@1 {
> +				reg = <1>;
> +				interrupts = <107 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		CP110_LABEL(xor0): xor@6a0000 {
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
