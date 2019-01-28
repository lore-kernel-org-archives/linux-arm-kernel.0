Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DAAC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:54:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58512214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e+o+pfBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58512214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2pJb6rNxuQ8+hynG/lJc+cb2aNNy+UGbYKntqSLZy2U=; b=e+o+pfBnF/zPaI
	XlgyrAB13UXLsaxBjM3HgFOdprADKPhmyvbIrVYAvfAfIzcSTVP5kh4YaxBUtoOv9SGcJTPBCQL9k
	/tuMH4ryfaGUmu5/4sYdf3OZQJGZ0t+Na+dDQCzA6OxT4OoVz3EIiIWncDOQIwhgWnkHZ6D1AC0bH
	jzHtO+Pt3zEYOFjzmjWMMT9QGB5Zf8bbXOrU/4A0QhE4FLBetkC53eds3QYVAYeK69EKBrWtsasmd
	2ym7bk+xogAvECgEIWFpUVkeL5pAqYjnj+CyFFrxFca4qZRmi1NfCCarjCrLy34iF6opV9x7OOq60
	RqvYUSiM37BOcxFdLakg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goC2n-0000DA-SE; Mon, 28 Jan 2019 18:54:05 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goC2k-0000CY-8l
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:54:03 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1goC2f-0002bf-T8; Mon, 28 Jan 2019 19:53:57 +0100
Message-ID: <f613ac78e0da048e2b9910cfc84b5f52607ec30f.camel@pengutronix.de>
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Add ECSPI support
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, shawnguo@kernel.org
Date: Mon, 28 Jan 2019 19:53:55 +0100
In-Reply-To: <20190128120813.23933-1-festevam@gmail.com>
References: <20190128120813.23933-1-festevam@gmail.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_105402_463364_B1522A2E 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: linux-arm-kernel@lists.infradead.org, andrew.smirnov@gmail.com,
 linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, den 28.01.2019, 10:08 -0200 schrieb Fabio Estevam:
> Add support for the three ECSPI ports present on i.MX8MQ.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes since v1:
> - Make reg a single address (Lucas)
> 
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 39 +++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 892063a7c26c..14949eec2d80 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -26,6 +26,9 @@
>  		serial1 = &uart2;
>  		serial2 = &uart3;
>  		serial3 = &uart4;
> +		spi0 = &ecspi1;
> +		spi1 = &ecspi2;
> +		spi2 = &ecspi3;
>  	};
>  
>  	ckil: clock-ckil {
> @@ -381,6 +384,42 @@
>  			#size-cells = <1>;
>  			ranges = <0x30800000 0x30800000 0x400000>;
>  
> +			ecspi1: spi@30820000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
> +				reg = <0x30820000 0x10000>;
> +				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_ECSPI1_ROOT>,
> +					 <&clk IMX8MQ_CLK_ECSPI1_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			ecspi2: spi@30830000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
> +				reg = <0x30830000 0x10000>;
> +				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_ECSPI2_ROOT>,
> +					 <&clk IMX8MQ_CLK_ECSPI2_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
> +			ecspi3: spi@30840000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx8mq-ecspi", "fsl,imx51-ecspi";
> +				reg = <0x30840000 0x10000>;
> +				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_ECSPI3_ROOT>,
> +					 <&clk IMX8MQ_CLK_ECSPI3_ROOT>;
> +				clock-names = "ipg", "per";
> +				status = "disabled";
> +			};
> +
>  			uart1: serial@30860000 {
>  				compatible = "fsl,imx8mq-uart",
>  				             "fsl,imx6q-uart";


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
