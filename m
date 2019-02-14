Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09230C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:41:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1612229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CEAoqfpp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dysk0PCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1612229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kl7iHd5E+QM3DE8eubYUV7lSQXQZ7MmrKlAxrklSxA8=; b=CEAoqfppM1Tlgr
	gm3b2AVFKiEaekCFQFIM+WTP2TNLajp4c9jp5GjqWie7TmbGhz85gdxEcW8JLshiZmJrpp0T+YJNB
	MuZksBpgWK6VnX/inqXVMQ0w4LYsfxj7q8T+u3eK4QqSklY1p1rbpO3Jwh4PITLuB4bECDV8WQL4N
	Tgx+CZGwrZaFuge1on6VeNBBlpaRnT28BzgbwrL798Cl+Xm0HbdDFS3WGKq285ZqmS5hjyjn1CSVr
	pATgAmyrevcSzKIg3YClzrJrvb0lU7uTRUCBPht7+ckujVqJWKcuC+3GpUmGekT42HxRc1uADHBgM
	S2C2ssii6pPYI3tC3WfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGKZ-00049s-Jg; Thu, 14 Feb 2019 12:41:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGKW-00049Y-Cv
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 12:41:30 +0000
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5140222A1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550148087;
 bh=QY1X1OOvnEEnbT2Y/13UGbYvaoiRPXsZimPdi0FRZeg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Dysk0PCoQkGfY4o5tD0ip/9wp1ZNLt9FYDtb/Q/qrZ21c1TBUVjcpcC1c/9W6HxRm
 Q1bDiINf+CK2uY11SLXROFdk4AAmIlnswlEuJ+U6U37ZBPuS2ExaOVz2hQLwtfHGUO
 rNyHeZ44MCpSei6HTaL2Wxc1H7tCMvEkKcaopaRs=
Received: by mail-lf1-f54.google.com with SMTP id v7so4449278lfd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 04:41:26 -0800 (PST)
X-Gm-Message-State: AHQUAubf0WT9im9UqtINNTywPLt3f4An+CBYbQ5iFvVTPSgl34QYzJ/A
 0ScZ5bS0RC6nCBb19AvNmeo3nTA2S+rovZb8EVM=
X-Google-Smtp-Source: AHgI3IZYRsRvCBToP0DgGz3LfU5FaREqsVnWo7Z2Q9QXqUlQzO9OLOz0Aq3e80y616JKJSSgbK2jLg3I75FT9hhI1ig=
X-Received: by 2002:a19:f013:: with SMTP id p19mr2275017lfc.154.1550148084945; 
 Thu, 14 Feb 2019 04:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20190213214052.2427-1-linux.amoon@gmail.com>
 <20190213214052.2427-2-linux.amoon@gmail.com>
In-Reply-To: <20190213214052.2427-2-linux.amoon@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 14 Feb 2019 13:41:13 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeyFmKUGwqS1sgf_k2WSx9i0AETjpOLXtsmLFupTpgqnw@mail.gmail.com>
Message-ID: <CAJKOXPeyFmKUGwqS1sgf_k2WSx9i0AETjpOLXtsmLFupTpgqnw@mail.gmail.com>
Subject: Re: [RFC 1/2] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To: Anand Moon <linux.amoon@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_044128_528729_43C90134 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Pankaj Dubey <pankaj.dubey@samsung.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Anand,

Thanks for the patch. See comments below.

On Wed, 13 Feb 2019 at 22:41, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add suspend-to-mem node to regulator core to be enabled or disabled
> during system suspend and also support changing the regulator operating
> mode during runtime and when the system enter sleep mode.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>
> Changes from previos patch
> [0] https://patchwork.kernel.org/patch/10712549/
>
> Set all the WAKEUP source regulator in suspend-on state.
> LD04, LD012, LD015, LD020, LD022
> Set all the non used regulator in suspend-odd state
> LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016
>
> BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator
>
> Tested on microSD card and it resumes correcly after suspend.
> eMMC is not able to resume after entering into suspend state,
> which need to be investigated and how to debug more.
> ---
>  .../boot/dts/exynos4412-odroid-common.dtsi    | 63 +++++++++++++++++++
>  arch/arm/boot/dts/exynos4412-odroidu3.dts     |  3 +
>  2 files changed, 66 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 08d3a0a7b4eb..e984461c37d9 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -288,6 +288,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };

I see my comment from previous patch was not addressed.

>                         };
>
>                         ldo3_reg: LDO3 {
> @@ -295,6 +298,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };

The same...

>                         };
>
>                         ldo4_reg: LDO4 {
> @@ -302,6 +308,9 @@
>                                 regulator-min-microvolt = <2800000>;
>                                 regulator-max-microvolt = <2800000>;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo5_reg: LDO5 {
> @@ -310,6 +319,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo6_reg: LDO6 {
> @@ -317,6 +329,9 @@
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo7_reg: LDO7 {
> @@ -324,18 +339,27 @@
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo8_reg: LDO8 {
>                                 regulator-name = "VDD10_HDMI_1.0V";
>                                 regulator-min-microvolt = <1000000>;
>                                 regulator-max-microvolt = <1000000>;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo10_reg: LDO10 {
>                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo11_reg: LDO11 {
> @@ -343,6 +367,9 @@
>                                 regulator-min-microvolt = <1800000>;
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo12_reg: LDO12 {
> @@ -351,6 +378,9 @@
>                                 regulator-max-microvolt = <3300000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo13_reg: LDO13 {
> @@ -359,6 +389,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo14_reg: LDO14 {
> @@ -367,6 +400,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo15_reg: LDO15 {
> @@ -375,6 +411,9 @@
>                                 regulator-max-microvolt = <1000000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo16_reg: LDO16 {
> @@ -383,6 +422,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         ldo20_reg: LDO20 {
> @@ -396,6 +438,9 @@
>                                 regulator-min-microvolt = <2800000>;
>                                 regulator-max-microvolt = <2800000>;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };


The same... any comments?

>                         };
>
>                         ldo22_reg: LDO22 {
> @@ -405,6 +450,9 @@
>                                  */
>                                 regulator-name = "LDO22";
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         ldo25_reg: LDO25 {
> @@ -413,6 +461,9 @@
>                                 regulator-max-microvolt = <1800000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck1_reg: BUCK1 {
> @@ -421,6 +472,9 @@
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;

Again, you did not address my comments.

> +                               };
>                         };
>
>                         buck2_reg: BUCK2 {
> @@ -429,6 +483,9 @@
>                                 regulator-max-microvolt = <1350000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
>                         };
>
>                         buck3_reg: BUCK3 {
> @@ -437,6 +494,9 @@
>                                 regulator-max-microvolt = <1050000>;
>                                 regulator-always-on;
>                                 regulator-boot-on;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };

The same...

>                         };
>
>                         buck4_reg: BUCK4 {
> @@ -444,6 +504,9 @@
>                                 regulator-min-microvolt = <900000>;
>                                 regulator-max-microvolt = <1100000>;
>                                 regulator-microvolt-offset = <50000>;
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
>                         };
>
>                         buck5_reg: BUCK5 {
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> index 2bdf899df436..4ebde09fc51d 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> @@ -82,6 +82,9 @@
>         regulator-name = "LDO22_VDDQ_MMC4_2.8V";
>         regulator-min-microvolt = <2800000>;
>         regulator-max-microvolt = <2800000>;
> +       regulator-state-mem {
> +               regulator-on-in-suspend;

Why?

Best regards,
Krzysztof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
