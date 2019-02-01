Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8239C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:10:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A713F20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C8R0nG2y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xppMNb8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A713F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=azKU8HiUs0WKvZPKEcCYgwBdjwGkXzaJyJroaP2CzKs=; b=C8R0nG2ygAzZZT
	mew4xjh5Ymj604eaYAxKNdB0JRax4FFtHbvhgpYQp0FNCOGnmKtveBkXmURNDJhwjmA3nUiFfJ7t/
	Q+o6rQOrM5trwM7e82j41UWxrjRKjuQECa4xh1Vv5SC4y5OCJnIJw/dGKdbW2m7xIYOoVJjkYm1cR
	7Om4iHx+SyVjL+4OnXgmFd6zLlQqWUWypFjGd/SxUpV7tsJI2WissMyMIHm5o3TfDnYdy1c3Gz7Rx
	sauR3hf7QS8cbfT4Zjw0E5FrdVnZ6rXl/OWigu7WhkeDKHUv0q3bavS+Q/2sHyIt58fpvV1CXv5PL
	W0XehWWNbAyIoi0pNBMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpSyA-00055j-C7; Fri, 01 Feb 2019 07:10:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpSy7-00055I-34
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 07:10:32 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 59A4A20869;
 Fri,  1 Feb 2019 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549005030;
 bh=IY0uqADHLW36uB3BVutP/LFzXDeW48dCwHEOHLyoUyI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xppMNb8k/kzQeVdBlfoXlYRV/mlgQyphfySTeTL7MUrI2hNWWDx7Xedm8jMkNHF4I
 J6cHeHLZ5zoKeVD5Zn082GWI+Jbn2OMG88ozUvSJVwaL6DAo5RiyPi5DfPkQSAKA84
 r0gZcishiMTHG8czMNNC9mCt6rDvVga5EDNWCzZk=
Date: Fri, 1 Feb 2019 15:10:20 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 1/2] arm64: dts: fsl: imx8mq: add USB nodes
Message-ID: <20190201071018.GP19882@dragon>
References: <20190125162559.15101-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125162559.15101-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_231031_178195_4612A168 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 05:25:58PM +0100, Lucas Stach wrote:
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Please put something into the commit log for the future patches.  And
it's clear enough for 'arm64: dts: imx8mq: ...' to be the prefix.

Applied both, thanks.

Shawn

> ---
> v2: Drop snps,power-down-scale, which isn't supported by upstream
>     driver, yet.
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 64 +++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index af2584d51fa2..51c9e899c35d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -472,6 +472,70 @@
>  			};
>  		};
>  
> +		usb_dwc3_0: usb@38100000 {
> +			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
> +			reg = <0x38100000 0x10000>;
> +			clocks = <&clk IMX8MQ_CLK_USB_BUS>,
> +			         <&clk IMX8MQ_CLK_USB_CORE_REF>,
> +			         <&clk IMX8MQ_CLK_USB1_CTRL_ROOT>;
> +			clock-names = "bus_early", "ref", "suspend";
> +			assigned-clocks = <&clk IMX8MQ_CLK_USB_BUS>,
> +			                  <&clk IMX8MQ_CLK_USB_CORE_REF>;
> +			assigned-clock-parents = <&clk IMX8MQ_SYS2_PLL_500M>,
> +			                         <&clk IMX8MQ_SYS1_PLL_100M>;
> +			assigned-clock-rates = <500000000>, <100000000>;
> +			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&usb3_phy0>, <&usb3_phy0>;
> +			phy-names = "usb2-phy", "usb3-phy";
> +			power-domains = <&pgc_otg1>;
> +			usb3-resume-missing-cas;
> +			status = "disabled";
> +		};
> +
> +		usb3_phy0: phy@381f0040 {
> +			compatible = "fsl,imx8mq-usb-phy";
> +			reg = <0x381f0040 0x40>;
> +			clocks = <&clk IMX8MQ_CLK_USB1_PHY_ROOT>;
> +			clock-names = "phy";
> +			assigned-clocks = <&clk IMX8MQ_CLK_USB_PHY_REF>;
> +			assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_100M>;
> +			assigned-clock-rates = <100000000>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		usb_dwc3_1: usb@38200000 {
> +			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
> +			reg = <0x38200000 0x10000>;
> +			clocks = <&clk IMX8MQ_CLK_USB_BUS>,
> +			         <&clk IMX8MQ_CLK_USB_CORE_REF>,
> +			         <&clk IMX8MQ_CLK_USB2_CTRL_ROOT>;
> +			clock-names = "bus_early", "ref", "suspend";
> +			assigned-clocks = <&clk IMX8MQ_CLK_USB_BUS>,
> +			                  <&clk IMX8MQ_CLK_USB_CORE_REF>;
> +			assigned-clock-parents = <&clk IMX8MQ_SYS2_PLL_500M>,
> +			                         <&clk IMX8MQ_SYS1_PLL_100M>;
> +			assigned-clock-rates = <500000000>, <100000000>;
> +			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&usb3_phy1>, <&usb3_phy1>;
> +			phy-names = "usb2-phy", "usb3-phy";
> +			power-domains = <&pgc_otg2>;
> +			usb3-resume-missing-cas;
> +			status = "disabled";
> +		};
> +
> +		usb3_phy1: phy@382f0040 {
> +			compatible = "fsl,imx8mq-usb-phy";
> +			reg = <0x382f0040 0x40>;
> +			clocks = <&clk IMX8MQ_CLK_USB2_PHY_ROOT>;
> +			clock-names = "phy";
> +			assigned-clocks = <&clk IMX8MQ_CLK_USB_PHY_REF>;
> +			assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_100M>;
> +			assigned-clock-rates = <100000000>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		gic: interrupt-controller@38800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x38800000 0x10000>,	/* GIC Dist */
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
