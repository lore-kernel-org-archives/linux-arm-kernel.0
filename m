Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC1C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:47:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD76B20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rHXL9a27";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZd01Ozo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD76B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ONlsCxISgT7QkusGkN9h1iUyulm1dfhDtBxet7OJcCk=; b=rHXL9a27HL3K+2
	uBKTSKXcQ9QT8smQK3ezss95vscp8MHqad2P7YtcfFnEG9M/s5URWCPbVuKFtrwX0PPTuMXk15R8L
	3mqMbTq1wZnuWyOnUrPlWf/jnM2pcaL7vuSOAwxPvsQwVNA01CYjYKXTz1XhQViiEmCK7zh8LKCk3
	LYjj2YhUVbVnOIougGVkqvyuokLTRLKJgozWUp8wbJUDzcPsu0xsIpsIlCv5MP7DOrFtFUaXyeI3u
	j5gfav0PA3/+MEvH5/j/lfK+MtIUQhwJ62NV+zbw4Ia3XzolWSdz+XDgdPtA76pPFzNvJAPCPoigl
	bpr+1wxuXB72ty7Pb8Gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUg2-00040O-Sp; Tue, 29 Jan 2019 14:47:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUfy-0003zt-U8
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:47:48 +0000
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B93F21841
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548773266;
 bh=QitBmytgsNk6KWfUHxJabPFz5DzqUD5Gs0i5jFGp6rA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IZd01OzoSzAMYeeam4quQj1oqFBJU2U0+26+4M+DvkHdXWaI4k9q5AEL7SqC7lZNj
 5U+GjjkGLcpvVQDCWHgNEyt0VNoMS8G2kF+7PtMPaEPuljPuk8KmHi0Wn79YvHZzWc
 Gt0l3qIQTf5EbkxjDsiLTyYZT0InbsP6PVveT/+w=
Received: by mail-lf1-f52.google.com with SMTP id n18so14805590lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 06:47:45 -0800 (PST)
X-Gm-Message-State: AJcUukfrezYQdgepH7EkWfjJ6JK5ytR9PpFSi46sE4OA4AjadRq7jMAU
 ftU4H24kT6wj+waZL5bxq2Z0CfkVhcspWld1+bE=
X-Google-Smtp-Source: ALg8bN52Hv9YWIeD+mgFecYuEVG3F4XHUKQq1/YgDzmoPcWrIF1UWngT+pkgnQYXGnj2pSUcdLny3WvgdEO3ZA0zwdA=
X-Received: by 2002:a19:9b50:: with SMTP id d77mr19897787lfe.137.1548773263699; 
 Tue, 29 Jan 2019 06:47:43 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190128192153eucas1p2d7a796cb89e68c1789069562e91296be@eucas1p2.samsung.com>
 <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <1548703299-15806-5-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1548703299-15806-5-git-send-email-l.luba@partner.samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 29 Jan 2019 15:47:32 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd2g6rtZpK20emJ0tqHhq0D01=BWbU_9MP30313XHvPHg@mail.gmail.com>
Message-ID: <CAJKOXPd2g6rtZpK20emJ0tqHhq0D01=BWbU_9MP30313XHvPHg@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: devfreq: add DMC device description
To: Lukasz Luba <l.luba@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_064747_006398_F9ED9BBD 
X-CRM114-Status: GOOD (  24.62  )
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
 <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, myungjoo.ham@samsung.com,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The patch adds description for DT binding for a new Exynos5 Dynamic Memory
> Controller device.
> It also contains needed MAINTAINERS file updates.
>
> CC: MyungJoo Ham <myungjoo.ham@samsung.com>
> CC: Kyungmin Park <kyungmin.park@samsung.com>
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: linux-pm@vger.kernel.org
> CC: linux-samsung-soc@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/devfreq/exynos5-dmc.txt    | 108 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 ++
>  2 files changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
>
> diff --git a/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
> new file mode 100644
> index 0000000..914bd85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
> @@ -0,0 +1,108 @@
> +* Exynos5 frequency and voltage scaling for Dynamic Memory Controller device
> +
> +The Samsung Exynos5 SoC has DMC (Dynamic Memory Controller) to which the DRAM
> +memory chips are connected. The driver is to monitor the controller in runtime
> +and switch frequency and voltage. To monitor the usage of the controller in
> +runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
> +is able to measure the current load of the memory.
> +When 'userspace' governor is used for the driver, an application is able to
> +switch the DMC frequency.
> +
> +Required properties for DMC device for Exynos5422:
> +- compatible: Should be "samsung,exynos5422-bus".
> +- clock-names : the name of clock used by the bus, "bus".
> +- clocks : phandles for clock specified in "clock-names" property.
> +- devfreq-events : phandles for PPMU devices connected to this DMC.
> +
> +The example definition of a DMC and PPMU devices declared in DT is shown below:
> +
> +       ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d00000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
> +               clock-names = "ppmu";
> +               status = "okay";
> +               events {
> +                       ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
> +                               event-name = "ppmu-event3-dmc0_0";
> +                       };
> +               };
> +       };
> +
> +
> +       ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d10000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
> +               clock-names = "ppmu";
> +               status = "okay";
> +               events {
> +                       ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
> +                               event-name = "ppmu-event3-dmc0_1";
> +                       };
> +               };
> +       };
> +
> +       ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d60000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
> +               clock-names = "ppmu";
> +               status = "okay";
> +               events {
> +                       ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
> +                               event-name = "ppmu-event3-dmc1_0";
> +                       };
> +               };
> +       };
> +
> +       ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {
> +               compatible = "samsung,exynos-ppmu";
> +               reg = <0x10d70000 0x2000>;
> +               clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
> +               clock-names = "ppmu";
> +               status = "okay";
> +               events {
> +                       ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
> +                               event-name = "ppmu-event3-dmc1_1";
> +                       };
> +               };
> +       };
> +
> +       dmc: dmc@10c20000 {
> +               compatible = "samsung,exynos5422-dmc";
> +               reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
> +                       <0x10030000 0x1000>, <0x10000000 0x1000>;
> +               clocks =        <&clock CLK_FOUT_SPLL>,
> +                               <&clock CLK_MOUT_SCLK_SPLL>,
> +                               <&clock CLK_FF_DOUT_SPLL2>,
> +                               <&clock CLK_FOUT_BPLL>,
> +                               <&clock CLK_MOUT_BPLL>,
> +                               <&clock CLK_SCLK_BPLL>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE>,
> +                               <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
> +                               <&clock CLK_MOUT_MCLK_CDREX>,
> +                               <&clock CLK_DOUT_CLK2X_PHY0>,
> +                               <&clock CLK_CLKM_PHY0>,
> +                               <&clock CLK_CLKM_PHY1>
> +                       ;

Join with previous line.

> +               clock-names =   "fout_spll",
> +                               "mout_sclk_spll",
> +                               "ff_dout_spll2",
> +                               "fout_bpll",
> +                               "mout_bpll",
> +                               "sclk_bpll",
> +                               "mout_mx_mspll_ccore",
> +                               "mout_mx_mspll_ccore_phy",
> +                               "mout_mclk_cdrex",
> +                               "dout_clk2x_phy0",
> +                               "clkm_phy0",
> +                               "clkm_phy1"
> +                               ;

Ditto.

> +
> +               status = "okay";
> +               devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
> +                               <&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
> +       };
> +
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9f64f8d..3581807 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3310,6 +3310,13 @@ S:       Maintained
>  F:     drivers/devfreq/exynos-bus.c
>  F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>
> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5
> +M:     Lukasz Luba <l.luba@partner.samsung.com>
> +L:     linux-pm@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt

Maintainers change should go with the next change, I think. It looks
unusual to add an entry for driver... without the driver.

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
