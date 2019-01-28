Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C9C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:37:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB7B214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NaLzsMJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB7B214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NljqXznjMHNjoEWfl0C9Uaj2cxrhkPZ5LrOJ+fxbm3c=; b=NaLzsMJpSL4tCf
	1oCwvloFE1H7vXKBSeI3WiHVrbziwEkjBhe/tnkNYCgxAPh6REHdfPQqDFusC/eqGf+7n1f5qC1Q8
	tTKJOj6S3/49eA5XCztogl5dLbUmqLgPQ3hQJpNgrJhsvXxyTivQmSSsw2Nnd4+ivs8XhXuoYA3O+
	IZhM5equJHJvKGK3PLz9KAvMWXkCXgDnW7yLaXKeHe/czdueLFv68mC3m10bGXQiZ8IQtQAid0ZZp
	WFEVME822wIEFe1M+OgSJrAoB5KQN1iXILTlrtYPmJPp7MDHaaoAlDj6WYwwS7aOxV1+LxCeRA63b
	y/9zf0IkVH4A8vGfdgsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4Hj-0001Nf-PO; Mon, 28 Jan 2019 10:36:59 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4Hg-0001NJ-Di
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:36:57 +0000
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1go4He-00072W-7O; Mon, 28 Jan 2019 11:36:54 +0100
Message-ID: <beb8399529e3e37d9b0b2e2764de28e9aec832c3.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add ECSPI support
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, shawnguo@kernel.org
Date: Mon, 28 Jan 2019 11:36:52 +0100
In-Reply-To: <20190126212824.15641-1-festevam@gmail.com>
References: <20190126212824.15641-1-festevam@gmail.com>
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_023656_614435_25776791 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: kernel@pengutronix.de, linux-imx@nxp.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Fabio,

Am Samstag, den 26.01.2019, 19:28 -0200 schrieb Fabio Estevam:
> Add support for the three ECSPI ports present on i.MX8MQ.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 39 +++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 892063a7c26c..45b9d4a8b0da 100644
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
> +				reg = <0x0 0x30820000 0x0 0x10000>;

reg is a single address and size cell in the upstream DT, as all
peripherals are below the 4GB mark, so we just expand the addresses by
using a DT range in the soc node.

Regards,
Lucas

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
> +				reg = <0x0 0x30830000 0x0 0x10000>;
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
> +				reg = <0x0 0x30840000 0x0 0x10000>;
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
