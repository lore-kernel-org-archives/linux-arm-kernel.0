Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAB5C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA113214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oFlcex7d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFfvJuBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA113214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LkcLw6nBO1+w0Jc2azllSyai233O6TYhACsXR6lPYPM=; b=oFlcex7dUAga5T
	jczEGGLubRLVbV37apNBMjyaElFSuSb3IwDUt5Trrwxoyyvn552JK1TaFj7YkWPUjTHRpzJuiqYi6
	81ZX+jiIfRe1gKKpZZCNj7ZD6tP0yMXA/HV0thhPP7qRdOt8fJNbIi7b1Kfe4q4PiiHb+yeRA5Mh2
	xhOjC6B37+tJHQdnxl+hhzYFsINKnui3pN/vvUC9YH48aMQrzQSVS1NcTEcCJMGIVYm8BKD8Zgz8D
	yprRMs7jS3YbJwaI+bnFtKHLsOlJCgQDYnAR+PIXzvOQwS6XnMrtqUExk1TASvuE+PFFmc/F4wAfV
	Iy6n8q4I33+Kbd0Jieeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goV5z-0001Wu-BB; Tue, 29 Jan 2019 15:14:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goV5Q-00012T-G1
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:14:09 +0000
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 298BA21871
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548774843;
 bh=qlHSCtwc7CZA3lrjJGWS5xngOSzHuOiH244mYsIbt80=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DFfvJuBA+/NxylKGdMVIShV15qaC6hXW6yZIN0fVoWYef4ZAUXbLLiNIwxREi6W1o
 6LfRJsZwJ6EUWmir1IjOM0WwC4UFmlYRVg4BBMkCZyfy6syHpsQ7jER8HnM+mNbRpM
 o873b6+xMj5PrmKxiGfGFMw1tyPS6IacEy1R7JPo=
Received: by mail-lj1-f170.google.com with SMTP id x85-v6so17820600ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 07:14:03 -0800 (PST)
X-Gm-Message-State: AJcUukevfTZlG0kTotJ17kR8qfjRUfEBo2c5fQY32hPYlgeovuGfd/lu
 oGBj5LDKLKrlXPWhZ+gHU+4OuMJuKXpGa27ZSnE=
X-Google-Smtp-Source: ALg8bN5SddqFDnQ12cd2+9JeO+tBIl6WXCSpKA4VlBPmtTIjEQOWTwYRGmX4YrbExzUdKhfacYkTF5AbTCLQ0JVraqY=
X-Received: by 2002:a2e:4a19:: with SMTP id
 x25-v6mr18632864lja.19.1548774841270; 
 Tue, 29 Jan 2019 07:14:01 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9@eucas1p2.samsung.com>
 <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <1548703299-15806-7-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1548703299-15806-7-git-send-email-l.luba@partner.samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 29 Jan 2019 16:13:49 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfHzspKWxHcf=DGf73v0sdnG=oDAa-9QLv2eRCHoC9RwQ@mail.gmail.com>
Message-ID: <CAJKOXPfHzspKWxHcf=DGf73v0sdnG=oDAa-9QLv2eRCHoC9RwQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] DT: arm: exynos: add DMC device for exynos5422
To: Lukasz Luba <l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_071404_987408_57CFDEAD 
X-CRM114-Status: GOOD (  18.33  )
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
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
 <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, myungjoo.ham@samsung.com,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Add description of Dynamic Memory Controller and PPMU counters.
> They are used by exynos5-dmc driver.
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: devicetree@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 81 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index aaff158..6880d13 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -1337,6 +1337,87 @@
>                                 opp-hz = /bits/ 64 <400000000>;
>                         };
>                 };
> +
> +               ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d00000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                                       event-name = "ppmu-event3-dmc0_0";
> +                               };
> +                       };
> +               };
> +
> +

No need for double line.

> +               ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d10000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +                                       event-name = "ppmu-event3-dmc0_1";
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d60000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +                                       event-name = "ppmu-event3-dmc1_0";
> +                               };
> +                       };
> +               };
> +
> +               ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {

1. Generic node name, e.g. "ppmu".
2. Please put all ppmu nodes after nocp nodes to group everything logically.

> +                       compatible = "samsung,exynos-ppmu";
> +                       reg = <0x10d70000 0x2000>;
> +                       clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> +                       clock-names = "ppmu";
> +                       events {
> +                               ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +                                       event-name = "ppmu-event3-dmc1_1";
> +                               };
> +                       };
> +               };
> +
> +               dmc: dmc@10c20000 {

1. Node name: memory-controller.
2. Put it before nocp nodes.

> +                       compatible = "samsung,exynos5422-dmc";
> +                       reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                               <0x10030000 0x1000>, <0x10000000 0x1000>;
> +                       clocks =        <&clock CLK_FOUT_SPLL>,

Weird indentation.

> +                                       <&clock CLK_MOUT_SCLK_SPLL>,
> +                                       <&clock CLK_FF_DOUT_SPLL2>,

Indent all continued lines with first entry (like in other places in this file).

> +                                       <&clock CLK_FOUT_BPLL>,
> +                                       <&clock CLK_MOUT_BPLL>,
> +                                       <&clock CLK_SCLK_BPLL>,
> +                                       <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                                       <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                                       <&clock CLK_MOUT_MCLK_CDREX>,
> +                                       <&clock CLK_DOUT_CLK2X_PHY0>,
> +                                       <&clock CLK_CLKM_PHY0>,
> +                                       <&clock CLK_CLKM_PHY1>
> +                                       ;

Join the trailing semicolon with previous lines.

> +                       clock-names =   "fout_spll",
> +                                       "mout_sclk_spll",

Indent all continued lines with first entry (like in other places in this file).

> +                                       "ff_dout_spll2",
> +                                       "fout_bpll",
> +                                       "mout_bpll",
> +                                       "sclk_bpll",
> +                                       "mout_mx_mspll_ccore",
> +                                       "mout_mx_mspll_ccore_phy",
> +                                       "mout_mclk_cdrex",
> +                                       "dout_clk2x_phy0",
> +                                       "clkm_phy0",
> +                                       "clkm_phy1"
> +                                       ;

Join the trailing semicolon with previous lines.
> +               };
>         };
>
>         thermal-zones {
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index bf09eab..54ee8b2 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -119,6 +119,28 @@
>         status = "okay";
>  };
>
> +&ppmu_dmc0_0 {
> +       status = "okay";
> +};
> +
> +&ppmu_dmc0_1 {
> +       status = "okay";
> +};
> +
> +&ppmu_dmc1_0 {
> +       status = "okay";
> +};
> +
> +&ppmu_dmc1_1 {
> +       status = "okay";
> +};

Put the new entries respecting alphabetical order (order of label name).

> +
> +&dmc {

The same.

Best regards,
Krzysztof

> +       devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +                       <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +       status = "okay";
> +};
> +
>  &cpu0 {
>         cpu-supply = <&buck6_reg>;
>  };
> --
> 2.7.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
