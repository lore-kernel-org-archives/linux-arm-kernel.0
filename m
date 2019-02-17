Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF941C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:43:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B8E21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 20:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ND8aZ4ZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B8E21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C035uGDiEQTUUoT4iVJoa7Xff10jpkcXDlpBAh2zRQ0=; b=ND8aZ4ZD8Kknij
	aIKmNwQhUGbChJH7XtgRzEuOsH+Rg1RfFrRrPQNhogKV0zSL/3Dumv6l+TflK4M70rFKWHOvHneMH
	dzddMJ7NAFzHzkco7vZBv8rU3p1XvcpnGFUNKIlauM4kpF6wzGWMEFEV9qDE2GuIqOwg8i5/wCUlL
	IiBCkE1p5RhMCOueLW7QfAn5/lAsPp2RmRTM6TYAZU6d4Q1uniSoNCmrz/kh2CH7+KaIvvmhds+IQ
	QTpqIRIRWmYWPrPZrl9hc3LiTT8dJs+1dWkYXCrgaZX+LuygQSDOkVUJzrt/oYYlbE3dkEbVN7BRa
	AQ7duVEA89221Wr4JWtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvTHn-0002Cc-N4; Sun, 17 Feb 2019 20:43:39 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvTHi-0002CD-Aw; Sun, 17 Feb 2019 20:43:36 +0000
Received: from oxbaltgw66.schlund.de ([172.19.246.153]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mq2vU-1hQjQ31es6-00n6BT; Sun, 17 Feb 2019 21:43:29 +0100
Date: Sun, 17 Feb 2019 21:43:28 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
Message-ID: <1528638260.343699.1550436208775@email.ionos.de>
In-Reply-To: <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:Kv71qhg3qq00NiKOxApl7Xj4bKZysXb8ssyHXDJdDE4k9yMBsi4
 iX4BWVT4AEwPJtC1d2VF9FHchNtFj9a/LZXj8PKTiZHBKgVRiO3cjoegG17SLP0L5AP/WQc
 rETvnllPiprH5FdDBvWmv3o7oiAHV456quF+XJe3g2ul9aY+tFTnRU6XfbG3k6jkoeiKB8f
 UY0rXP/5A9VhtQYbrgJwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XrkTfTM56dM=:o1ZUQ4OWy4pdsdZOJ/SuKJ
 aOyuZEcw4yCD9vh7Z17Y3QGWOr8vQwV3I7Pfxb4f8i/nchb9R87GSpzm2ZumOb/wX40OgR8et
 uV/p9uriFxvx4rtq37+8o7WfENITeXhLlt/u0wJyH4Q7+NbzjYhJJZjK/737pjaIgyrBzS5SO
 HL4oykpMYBC61VFhivqp+s5Afpd4gWkvvbwXGJNJfirdnIHOtngOGorJ/dT3Kmr/M6OHihuY6
 L4yRRzvVlHI2uOIgj8IyspqKUTuAkKRqrWwB5wKd7Fe1rAXegZwPGr9/oTkXb4zR1uzAm3Kg7
 sbIF6tMXFRB/719uYMYaFN+nklDsxPEq16YRfQxZrCym++K/kujMcmdUX+v/A8xT36KNY3RH5
 XykCYfHfU1CbryMf+ibVVLgrxScCQk0YUvRoQokQgCjzN/wpD7LRokwZzXm8XS9/xa3IEhU8R
 rtPLJcTiG8BSzxwC8IQ95iYp1vqlAVfaagMCIuPO+3GNLfx7RYqkx4GlGCZd/fXcnavAgOjc+
 tfOKbXd9sJUgZJJLA7MXnogJheUBnIjIL5G8cT0kYe1wcAh010Mp1xpraxhwLpYRZcoKAzpr+
 aAH0/6DjP3fv6itNX/0vH6v9eC0FzvhPilLqY4Rq9Zx7beZ51tE5tVXiGEcLaoHTbAd3LesCS
 2z1kIiE7P20kyU42bBOXcGPfUH3wdHOMm38doz+9hVXV7nnrtXNCiK45g3igjS9fDlmCdHliR
 NrDsLbbV/lbgKiTYzkncix2lwpCMBty8TfVoc6j4l1W+KF6W7tjB3VmU7Kc=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_124334_683149_C7EDE335 
X-CRM114-Status: GOOD (  25.99  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi David,

> David Summers <beagleboard@davidjohnsummers.uk> hat am 17. Februar 2019 um 13:15 geschrieben:
> 
> 
> This patch adds the wifi to the ASUS Tinker Board (S) machines.
> 
> Unfortunatly neither the Tinker Board nor the Tinker Board S schematic
> indicate how the WiFi is wired up on these devices. The WiFi is
> provided by the RTL8723BS device, that has sdio WiFi and UART
> Bluetooth. This patch just adds the WiFi interface.
> 
> With no schematic, most of the wiring has been derived from the ASUS
> patch to Debian:
> 
> https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678
> 
> In conjunction with the pin out of the RTL8723BS device:
> 
> http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf
> http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf
> 
> The only unusual part is that to bring the card up, both the pins
> RK_PD3 and RK_PD4 need to be pulled. Why this needs to be done is not
> clear, best explaination is that they are connected to the RTL8723BS
> pins WL_DIS# and BT_DIS#, which the data sheet vaguely says:
> 
> Shared with GPIO9 This Pin Can Externally Shutdown the RTL8723BS WLAN
> function when BT_DISn is Pulled Low. When this pin deasserted, SDIO
> interface will be disabled. This pin can also support the WLAN Ra
> dio-off function with host interface remaining connected.
> 
> Anyway extensive testing the TheSaint on ArchLinux Arm Forum 
> 
> https://archlinuxarm.org/forum/viewtopic.php?f=44&t=13064&start=120#p60548
> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/rk3288-tinker.dtsi | 39 +++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
> index fceaeed44e34..e1796f340eef 100644
> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
> @@ -3,8 +3,9 @@
>   * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
>   */
>  
>  #include "rk3288.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/clock/rockchip,rk808.h>
>  
>  / {
>  	chosen {
> @@ -98,6 +97,15 @@
>  		startup-delay-us = <100000>;
>  		vin-supply = <&vcc_io>;
>  	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk808 RK808_CLKOUT1>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable>;

As i wrote at the Arch board it would be nice to keep the Asus comment here:

/*
 * On the module itself this is one of these (depending
 * on the actual card populated):
 * - SDIO_RESET_L_WL_REG_ON
 * - PDN (power down when low)
 */

> +		reset-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_LOW>, <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &cpu0 {
> @@ -337,8 +345,8 @@
>  
>  &io_domains {
>  	status = "okay";
> -

Please drop this whitespace change

>  	sdcard-supply = <&vccio_sd>;
> +	wifi-supply = <&vcc_18>;
>  };
>  
>  &pinctrl {
> @@ -417,6 +425,12 @@
>  			rockchip,pins = <7 8 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
> +
> +	sdio {
> +		wifi_enable: wifi-enable {
> +			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>, <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;

Please make a line break after the first pin definition

> +		};
> +	};
>  };
>  
>  &pwm0 {
> @@ -440,6 +454,25 @@
>  	vqmmc-supply = <&vccio_sd>;
>  };
>  
> +&sdio0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
> +	max-frequency = <50000000>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-ddr50;

I'm okay with Tony's suggestion to remove sd-ush-ddr50.

> +	vmmc-supply = <&vcc_io>;
> +	vqmmc-supply = <&vcc_18>;
> +	status = "okay";
> +};
> +
>  &tsadc {
>  	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
>  	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
> -- 
> beagleboard@davidjohnsummers.uk
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
