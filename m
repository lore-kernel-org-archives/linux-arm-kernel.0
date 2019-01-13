Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DB0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:33:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF75520872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NGGx892S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKCO4f8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF75520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rZaniGwB0zkd0CgPJyhoDSsrWE1xYZD5DzZfYM+JcMo=; b=NGGx892Son1OOY
	muqGRZsPTMvSKUk8coyxzcu8tNp8iStPQ6wm2gVTt9lEVNNANhcJZwQOeYQnwN1MAs2AA1UQWm3Q7
	oLRXhHmNOin9PxuBnuk6MoZolCHr05iELDtBtwiKh1c5QJHtzgyAzPclDT72FpHR24N11wPPm/ALm
	WHvx8Q76MB4XnT4NGI6HRCtXoTnWJuCZsT7UT+l9gKecTmT9iVKtcdDfGDxMyUD0v8t2HXRnK6l+T
	fyb7PIinnUgt7or7qi5PnD1HaPTmJAfaYYcNFH76hQbK70JXXO+dLzosvdisfwxZV2xeuOBfSMuPH
	4bSD9vVGxw8aP0n8zLtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giVaH-00065A-9y; Sun, 13 Jan 2019 02:33:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giVaD-00064h-FJ
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 02:33:07 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 20C3A2063F;
 Sun, 13 Jan 2019 02:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547346784;
 bh=7d2U8g10qpU35XWIBb8Ri3pN/wd9NU3xsSuToj3UciE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IKCO4f8Jq5O1K0T7/v8m9MUUMRWGMpB24DZugllK7tp8MFpkuoyuQGZwIcaL0Hj64
 Q0UYxM1DHReM/GdXiQFbVMAu1hPFIn38uAxcgayHeyiiW6d7DoaU090H6uHRL1xrxZ
 oAvXb50+HeG+iulgVKnR1A1H2JFFghBO0kEzDJto=
Date: Sun, 13 Jan 2019 10:32:45 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: BOUGH CHEN <haibo.chen@nxp.com>
Subject: Re: [PATCH 1/2] arm: dts: imx7d-sdb: add SD3.0 support for usdhc1
Message-ID: <20190113023243.GC11426@dragon>
References: <20181228093558.18434-1-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228093558.18434-1-haibo.chen@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_183305_550827_A8277B2C 
X-CRM114-Status: GOOD (  15.58  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 09:28:30AM +0000, BOUGH CHEN wrote:
> Add usdhc1 support SD3.0.
> 
> Besides, add fsl,tuning-start-tap for all usdhc, imx usdhc IP
> logic require the tuning-start-tap larger than 10, to make
> sure the tuning logical can work normal.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

For i.MX arm32 dts, please use prefix 'ARM: dts: ...'.

> ---
>  arch/arm/boot/dts/imx7d-sdb.dts | 55 +++++++++++++++++++++++++++------
>  arch/arm/boot/dts/imx7s.dtsi    |  6 ++++
>  2 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 202922ed3754..ded43decf46c 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -87,6 +87,16 @@
>  		regulator-max-microvolt = <1800000>;
>  	};
>  
> +	reg_sd1_vmmc: regulator-sd1-vmmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_SD1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <200000>;
> +		enable-active-high;
> +	};
> +
>  	reg_brcm: regulator-brcm {
>  		compatible = "regulator-fixed";
>  		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
> @@ -408,12 +418,13 @@
>  };
>  
>  &usdhc1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
>  	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
>  	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
> -	wakeup-source;
> -	keep-power-in-suspend;

Why these changes?

> +	vmmc-supply = <&reg_sd1_vmmc>;
>  	status = "okay";
>  };
>  
> @@ -426,7 +437,6 @@
>  	keep-power-in-suspend;
>  	non-removable;
>  	vmmc-supply = <&reg_brcm>;
> -	fsl,tuning-step = <2>;
>  	status = "okay";
>  };
>  
> @@ -438,7 +448,6 @@
>  	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
>  	assigned-clock-rates = <400000000>;
>  	bus-width = <8>;
> -	fsl,tuning-step = <2>;
>  	non-removable;
>  	status = "okay";
>  };
> @@ -638,6 +647,15 @@
>  			>;
>  		};
>  
> +		pinctrl_usdhc1_gpio: usdhc1_gpiogrp {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
> +				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
> +				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59 /* vmmc */
> +				MX7D_PAD_GPIO1_IO08__SD1_VSELECT	0x59 /* VSELECT */
> +			>;
> +		};
> +
>  		pinctrl_usdhc1: usdhc1grp {
>  			fsl,pins = <
>  				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
> @@ -646,9 +664,28 @@
>  				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
>  				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
>  				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
> -				MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
> -				MX7D_PAD_SD1_WP__GPIO5_IO1		0x59 /* WP */
> -				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59 /* vmmc */
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CMD__SD1_CMD		0x5a
> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x1a
> +				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5a
> +				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5a
> +				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5a
> +				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5a
> +			>;
> +		};
> +
> +		pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CMD__SD1_CMD		0x5b
> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x1b
> +				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x5b
> +				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x5b
> +				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x5b
> +				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x5b
>  			>;
>  		};
>  
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index e88f53a4c7f4..bee8dc2f614b 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -1036,6 +1036,8 @@
>  					<&clks IMX7D_USDHC1_ROOT_CLK>;
>  				clock-names = "ipg", "ahb", "per";
>  				bus-width = <4>;
> +				fsl,tuning-step = <2>;

The commit log should mention the move of fsl,tuning-step from board
level dts to SoC level.

Shawn

> +				fsl,tuning-start-tap = <20>;
>  				status = "disabled";
>  			};
>  
> @@ -1048,6 +1050,8 @@
>  					<&clks IMX7D_USDHC2_ROOT_CLK>;
>  				clock-names = "ipg", "ahb", "per";
>  				bus-width = <4>;
> +				fsl,tuning-step = <2>;
> +				fsl,tuning-start-tap = <20>;
>  				status = "disabled";
>  			};
>  
> @@ -1060,6 +1064,8 @@
>  					<&clks IMX7D_USDHC3_ROOT_CLK>;
>  				clock-names = "ipg", "ahb", "per";
>  				bus-width = <4>;
> +				fsl,tuning-step = <2>;
> +				fsl,tuning-start-tap = <20>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
