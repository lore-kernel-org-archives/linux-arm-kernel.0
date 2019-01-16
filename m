Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AE7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:17:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC1C20840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D4PCgaE/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvD7BmUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC1C20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=POLCKjDLvlObbJO04mBXSCkl8RE5Pcn7mJnsd3EO8A0=; b=D4PCgaE/Nq9ltv
	3mjeJQl6DYMunU/8od8JfxEBmKYmBfiltB5R27EPy+1mgJPVd67bFAg7NIBwzCclxdyKRvFT9fZdq
	jGO6c4oLycnBYjESaVKGJX+WYzzcOX5o4BeXJS3SCS1bJhq5Nfbj7Pk2hTiZA1PakpasOH3wzlVQm
	IQCA7Ib4aV1FZljWJ6ifVB7oTLLy5UcAxvfRnm2kCFOvIBDkR75HONnmPblysQbdDCor4JS/iYCEF
	Dse2KveluQBOJ2nCpXqefPF51w/6Fbng33famoRmZe6CPe0dZ53W+GAwg3xfBKut7RWQRROzLt0NZ
	hmMFmjce5f04DDgRj+1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjiG5-00073e-9L; Wed, 16 Jan 2019 10:17:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjiG2-00073G-8g
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 10:17:15 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5A70E20840;
 Wed, 16 Jan 2019 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547633833;
 bh=MzxfPw9WCh7oKM4WRswzYX76S3TlaNN33D1mSRSMeok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bvD7BmUD9NsQWQpLKF98zGZFd76qFJXW7Z4j2Yv0JH78Jy6J2LdOh3rTIhdSaUDWe
 GR+s/JvhN18wbbpr+IrbAwqiL/aTvLy/UhoUpHHceWzr6/S9j3lS6lSB67+8DG5Jri
 PKwdoLcuTqqtzjUg7tbv+8p7JidMrnEeU3DrGMNU=
Date: Wed, 16 Jan 2019 18:16:49 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] arm64: dts: fsl: imx8mq: add USB nodes
Message-ID: <20190116101648.GI15808@dragon>
References: <20190115110325.13236-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115110325.13236-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_021714_353414_759394B5 
X-CRM114-Status: GOOD (  13.24  )
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
 NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 12:03:24PM +0100, Lucas Stach wrote:
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 66 +++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 5bd1f106ed84..d25ab50d6b88 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -470,6 +470,72 @@
>  			};
>  		};
>  
> +		usb_dwc3_0: usb@38100000 {
> +			compatible = "fsl,imx8mq-dwc3", "snps,dwc3";

We should document the compatible even though it's not used by kernel
for now.

Shawn

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
> +			snps,power-down-scale = <2>;
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
> +			snps,power-down-scale = <2>;
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
