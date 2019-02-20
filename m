Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:18:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6797C2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NqVeCN7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6797C2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c36BWkImdmJN7KMiEYOm0Al4nXlHCykIx71sfYfY3oA=; b=NqVeCN7HMBgb/a
	K0GwEyM8d03ppsOjiX2KV+8evQAYF3yoIeWuDENEcoUl5zhEs63alazbB7glQ3DGPHxTl8RaOsuT5
	LSu5P4xFpTEld783CCwTZB+Ho++KZz7jeuD2FknW9uDYnALJqB1LRYM7mqKjGXfYMPPN2uzoHQ4Sd
	fU/8TOBSRIwwcr41YUHIeTmZcV8LKgl0Qbbc5R3REV8j/hqSJe7Gl9abpa/lUuci6Qx3blAn9dX91
	AN3etGy/py6N8lkpa9JE6Hm+7XUvx9Ais1XzzISGymc8ElRp/76W8/30UozFb+MDxFHcT3cYpQQQI
	/AVFJip3sNVaoIyRrdYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwN5e-00021T-JZ; Wed, 20 Feb 2019 08:18:50 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwN5a-00020r-Ag
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 08:18:47 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gwN5U-0005bz-1F; Wed, 20 Feb 2019 09:18:40 +0100
Message-ID: <c514dea5d45f6796120fd6b5a8a3c42803e8aabb.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Date: Wed, 20 Feb 2019 09:18:36 +0100
In-Reply-To: <20190220015857.7136-6-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
 <20190220015857.7136-6-andrew.smirnov@gmail.com>
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_001846_524464_1C8F9D90 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Dienstag, den 19.02.2019, 17:58 -0800 schrieb Andrey Smirnov:
> Enable PCIE0 interface connected to BCM4356 WiFi/Bluetooth module.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 64acccc4bfcb..226aeb9791a5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -31,6 +31,12 @@
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
>  };
>  
>  &fec1 {
> @@ -40,6 +46,17 @@
>  	status = "okay";
>  };
>  
> +&gpio5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wifi_reset>;
> +
> + 	wl-reg-on {
> +		gpio-hog;
> +		gpios = <29 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -131,6 +148,18 @@
>  	};
>  };
>  
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
> +	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> +		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
> +		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
> +		 <&pcie0_refclk>;
> +	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> @@ -195,6 +224,13 @@
>  		>;
>  	};
>  
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
> +			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
> +		>;
> +	};
> +
>  	pinctrl_reg_usdhc2: regusdhc2grpgpio {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
> @@ -300,4 +336,10 @@
>  			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
>  		>;
>  	};
> +
> +	pinctrl_wifi_reset: wifiresetgrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
> +		>;
> +	};
>  };


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
