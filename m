Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5651CC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:56:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2567F2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mgr3vpqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2567F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DA45Jv1cfmPaoPLiasYMvuABVfM2zvK+pfKxPGEL23A=; b=Mgr3vpqPClFPP6
	ddncfn43LPULOKlXDkumeXpZOFlcGjqHjY5VXPXhXCjAZMQC9T08lNvUj8usTVQHtBsE+qrTIaf42
	Z9w6iVhTwfruunnoiUQp76T1JG91+Rauos6LPQQLB4oonJMbavTGT3eRI0ThaDp9hlDdYVsf1hYGZ
	6ZsKBUx36KxiqlKtW8d4UCBcCWiudPxRz2eF5WTAMfg0JZCD+w5vn84YwAn4TBbrVWfoLCUaCPYST
	HN/ewZYgFMPqQgqy2qPUIAd/s1BEvTKkrvjXlSYaVV/9BQPzSoPSFHxSNlGrP+HGTnLsqfOYuPycb
	pcm0sX0wuRNPSxmFZsmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKMX-00048k-TE; Fri, 07 Dec 2018 17:56:29 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKMS-00046i-7n; Fri, 07 Dec 2018 17:56:27 +0000
Received: by mail-ot1-f68.google.com with SMTP id i20so4608840otl.0;
 Fri, 07 Dec 2018 09:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=t9wmbAvlXjHON22J+EQi8YGvSBDoYj1CZ7kyykLOaTo=;
 b=IA4+8VT3JvhEhsxmkALRfEJW9IH27xuoXLUcfUr8wslqaH2jr9tS1pYA9VsyQ7oj54
 XXc1VNLYvZM4IYK3rXmomNLz5gZ86YwZ+z/CFdOOEJnjsWMPCKfMq/YMrxvcoSSrayxq
 tE/vSFVZQ3qh7QKODTKeRu3olbDIFqnfzPO3yk431XUUIstw53Us4IzAXl0ZnKcfkQNo
 lW5FUZJ41H88IqVwrrZhSLyhw86iGBUI0xLRcSb4m/8Mi/eFZ5ig53bHNhZdOZLEi7jo
 j1/JDg0S5rDw0j+rAm+LT4LQGAH+bMS6ZcOcnTL0cjnnt2ddn/teIrXapjrYI9gg9jpS
 hL7g==
X-Gm-Message-State: AA+aEWZaZATiijx+SHx5wetXXLbmrmQ64kEXwkVFWY+tgpiUAwCOWwKA
 C44yj+tOW1ERER2sTOYamvpeu4I=
X-Google-Smtp-Source: AFSGD/Wbv6R9qC5q3+7mU0o9TMBPzPxWh3pSlv0gxrLJy77nOgll/AAPi/8oYCxACzjALEUsK5PaTA==
X-Received: by 2002:a9d:7141:: with SMTP id y1mr1967499otj.177.1544205373259; 
 Fri, 07 Dec 2018 09:56:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t21sm1582581otq.67.2018.12.07.09.56.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 09:56:12 -0800 (PST)
Date: Fri, 7 Dec 2018 11:56:11 -0600
From: Rob Herring <robh@kernel.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4] arm64: dts: rockchip: Add DT for nanopc-t4
Message-ID: <20181207175611.GA25227@bogus>
References: <20181123073120.6250-1-tomeu.vizoso@collabora.com>
 <20181127091235.50351-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181127091235.50351-1-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_095624_274395_649278AC 
X-CRM114-Status: GOOD (  23.21  )
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
 heiko@sntech.de, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Ezequiel Garcia <ezequiel@collabora.com>, Liang Chen <cl@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Nov 27, 2018 at 10:07:03AM +0100, Tomeu Vizoso wrote:
> This adds a device tree for the NanoPC-T4 SBC, which is based on the
> Rockchip RK3399 SoC and marketed by FriendlyELEC.
> 
> Known working:
> 
> - Serial
> - Ethernet
> - HDMI
> - USB 2.0
> 
> All of the interesting stuff is in a .dtsi because there are at least
> two other boards that share most of it: NanoPi M4 and NanoPi NEO4.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> ---
> 
> v2: - Rename compatible from friendlyelec to friendlyarm, to match
>       existing bindings
>     - Remove superfluous node spi1
> 
> v3: - Rewrite regulator tree to match the schematics (Heiko)
>     - Sort top-level nodes alphabetically (Heiko)
>     - Used defines for GPIO numbers (Heiko)
>     - Enabled rga (Heiko)
>     - Removed cdn_dp node (Heiko)
>     - Removed dependencies to fusb0 as extcon (Heiko)
>     - Removed superfluous properties (Heiko)
> 
> v4: - Replace underscores in node names (Heiko)
>     - Reorder entry in makefile (Heiko)
>     - Remove superfluous properties and nodes (Heiko and Shawn)
>     - Use xin32k as one of the clock outputs of the RK808 (Heiko)
> ---
>  .../devicetree/bindings/arm/rockchip.txt      |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-nanopc-t4.dts    |  18 +
>  .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 732 ++++++++++++++++++
>  4 files changed, 755 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index 0cc71236d639..e907d309486e 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -71,6 +71,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
>  
> +- FriendlyElec NanoPC-T4 board:
> +    Required root node properties:
> +      - compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";
> +
>  - ChipSPARK PopMetal-RK3288 board:
>      Required root node properties:
>        - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 49042c477870..19c129702e06 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-ficus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> new file mode 100644
> index 000000000000..0965712b4464
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * FriendlyElec NanoPC-T4 board device tree source
> + *
> + * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * Copyright (c) 2018 Collabora Ltd.
> + */
> +
> +/dts-v1/;
> +#include "rk3399-nanopi4.dtsi"
> +
> +/ {
> +	model = "FriendlyElec NanoPC-T4";
> +	compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";
> +};
> +
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> new file mode 100644
> index 000000000000..e10b98d637d3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -0,0 +1,732 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * RK3399-based FriendlyElec boards device tree source
> + *
> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
> + * (http://www.friendlyarm.com)
> + *
> + * Copyright (c) 2018 Collabora Ltd.
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};
> +
> +	vdd_5v: vdd-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_5v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc5v0_core: vcc5v0-core {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_core";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_core>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	vcc5v0_usb1: vcc5v0-usb1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb1";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb2: vcc5v0-usb2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_usb2";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	/* switched by pmic_sleep */
> +	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v8_s3";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_1v8>;
> +	};
> +
> +	vcc3v0_sd: vcc3v0-sd {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdmmc0_pwr_h>;
> +		regulator-always-on;
> +		regulator-max-microvolt = <3000000>;
> +		regulator-min-microvolt = <3000000>;
> +		regulator-name = "vcc3v0_sd";
> +		vin-supply = <&vcc3v3_sys>;
> +	};
> +
> +	vbus_typec: vbus-typec {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "vbus_typec";
> +		regulator-always-on;
> +		vin-supply = <&vdd_5v>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&power_key>;
> +
> +		button@0 {

Build your dtb with W=1 and fix any warnings at least not in the SoC 
dtsi file. This line will warn about a unit-address without a reg 
property. Just use 'power' for the node name.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
