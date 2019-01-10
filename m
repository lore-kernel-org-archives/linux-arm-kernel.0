Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D74C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:51:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC08206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EO8yBnhT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hiq+dqNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC08206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ECHa9EUPhx+L0rHO8v56HHRrLjcKvWGKmUw695RqfOo=; b=EO8yBnhTfu2L52
	ErTOGU7nvKswUIidx4z7NzgNhRmINYCOmXbddzxlGfH9MP+TJdda+reSOrnjego/Xc7RIr94B4wS5
	k4Nqtp0JVjWTLEgtsmnWxL57zKedzweJgrVmGl4mL3dKkPFhGE1Hi/v+JPvXObbdx/IKe5iemKyVF
	qrLQLjms/GpdYEaApwRElCI1Lo30U3BzuXFZL/uvN4RK/SbDMwp2JtCYMH+zIGjc+Flym7UjbTE6t
	qqFGEAThxFGpv9/8SJA0rWx6JLmKLGCdap8kQq4cJU6OkE7NEMUKNQ7qWQRyG0kz4wU2DVIo5t4dK
	fXjgAfeLwix/1MaJx7fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdYH-0002NX-VS; Thu, 10 Jan 2019 16:51:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdYE-0002NA-DJ
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:51:28 +0000
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F411F217F9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547139086;
 bh=UCzZipSGL4rPfoPvtiVXh5c4Jyg3yXqRifk4LJwX3Yk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Hiq+dqNNe7wfnau1jOI9lMetzqNVmmd9CBnA9E5tSdjEaVmmwkx/rg6JaVDc/gobX
 +G/fwcjW9xR4xHzHegf1WcTWz36fip8ySDtMHF4bN+mqeAUjMLORm4VLUDyzpbZScF
 iT/GzFtU3TltYScLpxywMFXDwcgG9CEj/4Xe0QxM=
Received: by mail-qt1-f173.google.com with SMTP id l12so13869964qtf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 08:51:25 -0800 (PST)
X-Gm-Message-State: AJcUukeVz6VikGHCvb6MGbhTZMjmNkeS0TrZL6XridPhNia0zh/cvXMD
 s2FaKbvzPHH6qQ0CvWwHUbtCJjb4oppeHl/jHw==
X-Google-Smtp-Source: ALg8bN6LG9B3+RiLsvtijLZr3wFF+a0s7yo67cOrm+gwffNkwUyUaFQMA/ru2l+3xnr1uTdgZgq8VCflW2GtzLpr/BU=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr10433777qve.246.1547139085119; 
 Thu, 10 Jan 2019 08:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org>
 <20190110080821.30280-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190110080821.30280-4-manivannan.sadhasivam@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 10 Jan 2019 10:51:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL9iRbSss5nDq5OAoo-_OsZJf8KS9KGOgxQL1Xfk6f3dg@mail.gmail.com>
Message-ID: <CAL_JsqL9iRbSss5nDq5OAoo-_OsZJf8KS9KGOgxQL1Xfk6f3dg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add devicetree for Oxalis
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_085126_486903_467E78BE 
X-CRM114-Status: GOOD (  20.79  )
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
Cc: devicetree@vger.kernel.org, a.tropschug@ebs-systart.com,
 m.bittner@ebs-systart.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, Yang-Leo Li <leoyang.li@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 2:08 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add devicetree support for Oxalis SoM board from EBS-SYSTART. This
> board is one of the 96Boards Enterprise Edition platform. Below are some
> of the key features of this board:
>
> * SoC: NXP Layerscape LS1012A
> * RAM: 1GB DDR3L
> * PMU: NXP VR5100
> * Storage: 64MByte SPI Flash for bootloader and RCW, MicroSD Card, SATA
> * Connectivity: 2x Ethernet
> * USB: 2x USB3.0
>
> More information about this board can be found in 96Boards product
> page: https://www.96boards.org/product/oxalis/
>
> Ethernet and SPI flash are not supported yet!
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../boot/dts/freescale/fsl-ls1012a-oxalis.dts | 96 +++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index f9be2426f83c..d8152cc06b3f 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-oxalis.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
> new file mode 100644
> index 000000000000..760a3e258c96
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree file for Oxalis
> + *
> + * Copyright (c) 2019 Manivannan Sadhasivam
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "fsl-ls1012a.dtsi"
> +
> +/ {
> +       model = "Oxalis";
> +       compatible = "ebs-systart,oxalis", "fsl,ls1012a";
> +
> +       sys_mclk: clock-mclk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <25000000>;
> +       };
> +
> +       reg_1p8v: regulator-1p8v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "1P8V";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-always-on;
> +       };
> +
> +       sound {
> +               compatible = "simple-audio-card";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,widgets =
> +                       "Microphone", "Microphone Jack",
> +                       "Headphone", "Headphone Jack",
> +                       "Speaker", "Speaker Ext",
> +                       "Line", "Line In Jack";
> +               simple-audio-card,routing =
> +                       "MIC_IN", "Microphone Jack",
> +                       "Microphone Jack", "Mic Bias",
> +                       "LINE_IN", "Line In Jack",
> +                       "Headphone Jack", "HP_OUT",
> +                       "Speaker Ext", "LINE_OUT";
> +
> +               simple-audio-card,cpu {
> +                       sound-dai = <&sai2>;
> +                       frame-master;
> +                       bitclock-master;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&codec>;
> +                       frame-master;
> +                       bitclock-master;
> +                       system-clock-frequency = <25000000>;
> +               };
> +       };
> +};
> +
> +&duart0 {
> +       status = "okay";
> +};
> +
> +&duart1 {
> +       status = "okay";
> +};
> +
> +&esdhc1 {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +
> +       codec: sgtl5000@a {

Use generic node names:

audio-codec@a

> +               #sound-dai-cells = <0>;
> +               compatible = "fsl,sgtl5000";
> +               reg = <0xa>;
> +               VDDA-supply = <&reg_1p8v>;
> +               VDDIO-supply = <&reg_1p8v>;
> +               clocks = <&sys_mclk>;
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +};
> +
> +&sai2 {
> +       status = "okay";
> +};
> +
> +&sata {
> +       status = "okay";
> +};
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
