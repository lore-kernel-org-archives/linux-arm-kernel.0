Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:34:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A10D2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="buQ2yWDI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcHqgxIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A10D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NUfXb4ulhw8c/ucH9nKq4/dUlYBboSGYYAatXXRBNmo=; b=buQ2yWDI65j3CK
	rnXNF/d0zy1VQg7QOCLaH89/wPBpQEK0V79te/GkoBgHp0L/4C2u9E7P1ZQB6IL6GD3mFLId4Ba57
	mhM6XV32FTWpyLFtFBxljCNjuNL8gHQziWjBcwh+VC1N6W192dbe47VYm5YHXdzGYc2+x4IGhm3B5
	YVA4Njoo51up0pwd8qRkLAgBFWPqBhRdhvoVAwUH1Pnuv6EoehpzySKL4KfnVywyo/+lQCSQBML5Y
	gly90YhLWvjVZTajBxKNKgCq7bocyjQRAKGc/3nwW84YysIy4FGltiYKMPgH7OtDXIvzAOm4DgOez
	5VAC2msKShr+GsLgwI/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghnaJ-0002Hd-GW; Fri, 11 Jan 2019 03:34:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghnaG-0002HI-VC
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 03:34:14 +0000
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3AE52084C;
 Fri, 11 Jan 2019 03:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547177652;
 bh=CgzcbVNkQGAIkiVbY1DPSDXxqXd+ThsZlV0Ae5yrIn8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IcHqgxIlLhednDOweec3JU+ZDH/pydJDkq7u6NA74KFmRWFIfESOkpGlCRvy1tOPJ
 FCQzo9u3xh29L84/SNDbdynIuoOVXX1G2El124nTmqY8zPWBbTvSahxNM8/xh0Z9g3
 B9QfOseiHrs8vm7FVL+xI4u+VjzCG9fLzVMBFtvI=
Date: Fri, 11 Jan 2019 11:33:57 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mq: add GPC power domains
Message-ID: <20190111033355.GA32341@dragon>
References: <20181214105510.1174-1-l.stach@pengutronix.de>
 <20181214105510.1174-2-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214105510.1174-2-l.stach@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_193413_040823_9D69974D 
X-CRM114-Status: GOOD (  14.33  )
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
Cc: devicetree@vger.kernel.org, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 11:55:10AM +0100, Lucas Stach wrote:
> This adds support for the power domain controller found on the
> i.MX8MQ SoC.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 66 +++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index a55b9329376b..c521cd1b6820 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <dt-bindings/clock/imx8mq-clock.h>
> +#include <dt-bindings/power/imx8mq-power.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include "imx8mq-pinfunc.h"
> @@ -252,6 +253,71 @@
>  				              "clk_ext1", "clk_ext2",
>  				              "clk_ext3", "clk_ext4";
>  			};
> +
> +			gpc: gpc@303a0000 {
> +				compatible = "fsl,imx8mq-gpc";
> +				reg = <0x303a0000 0x10000>;
> +
> +				pgc {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					pgc_mipi: pgc-power-domain@0 {

We generally want to keep node name as generic as possible, so dropping
'pgc-' prefix might be sensible.

Shawn

> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_MIPI>;
> +					};
> +
> +					pgc_pcie1: pgc-power-domain@1 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
> +					};
> +
> +					pgc_otg1: pgc-power-domain@2 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_USB_OTG1>;
> +					};
> +
> +					pgc_otg2: pgc-power-domain@3 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_USB_OTG2>;
> +					};
> +
> +					pgc_ddr1: pgc-power-domain@4 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_DDR1>;
> +					};
> +
> +					pgc_gpu: pgc-power-domain@5 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_GPU>;
> +					};
> +
> +					pgc_vpu: pgc-power-domain@6 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_VPU>;
> +					};
> +
> +					pgc_disp: pgc-power-domain@7 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_DISP>;
> +					};
> +
> +					pgc_mipi_csi1: pgc-power-domain@8 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_MIPI_CSI1>;
> +					};
> +
> +					pgc_mipi_csi2: pgc-power-domain@9 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_MIPI_CSI2>;
> +					};
> +
> +					pgc_pcie2: pgc-power-domain@10 {
> +						#power-domain-cells = <0>;
> +						reg = <IMX8M_POWER_DOMAIN_PCIE2>;
> +					};
> +				};
> +			};
>  		};
>  
>  		bus@30400000 { /* AIPS2 */
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
