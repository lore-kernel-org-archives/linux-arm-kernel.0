Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2409DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:44:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F412054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pmum5X1H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXqO2Niu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F412054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HnZTDap0BwDDe7ODnz1TMbJutf/3uywjKSn/wJ1cdmU=; b=Pmum5X1HCS0oA4
	E0/R+0q6d1bc/oKr/6P9HtFl55lMFhuzJ0dkHjfWkHO9uf0Dn5+MJOXhZlomj2eEAkyghYVCE5yK6
	aBHUf//8uKwJLFp+7YyAWnkv0f+EpgxFHGBHBhKwMbEUVEt4Y5ro0XU+j1jNx/VEKLAk0hpyJRDBy
	MbrFXknq4fN27KORYgsxSMZ4ELGRKo16Gc+qewqilb3A+N93TLE0u6rbsNSgARA8U9913YHIQ+B3J
	nx+c1OSXgQ/ucMkjQ6PpeWgbglZcPggNlDb634/kn1V4MjxGMjgjHN0lzGjbFOPE9rYLRB0bMCFcZ
	erE6jclLR+xCTAvmIMVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guZ6U-0001uq-Or; Fri, 15 Feb 2019 08:44:14 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guZ6R-0001uO-8m
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:44:13 +0000
Received: by mail-ot1-x344.google.com with SMTP id i5so15248938oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9FAKN/BEQu3ANfpK3k6qS74j2VR/opY09GB2IejS2PM=;
 b=iXqO2NiuAHscWN9GZ+B09fBiHQLgp/90ZdVDmn9SDqUIoooy+wo/YVF9fFiNOnM+Iv
 OzQjLBVDBU8D1AJb1ZcmCpe9BLAsievmp35ZcG5K2uNkGewOGrLjEI8NKyLlwiMwBv00
 pED+A7s6R/K7T6UYmuYT2XuztiG+s12zxMt8+1pOpUNzMF25ujTdPbVUV1MLQA/fc5fy
 xtShjXfZ3HaXFvW7QqxkEOL8y6g4LmsLHnwBHDbVH38Da/8Q7bbMXRzVU1nFN1auvSi2
 CMYj0bNVjj5R+nPXzZU0nOwgUq2P+knXwUJZugTWWRNVzcP4PvFQEzCYO2WZjLx0an9h
 xQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9FAKN/BEQu3ANfpK3k6qS74j2VR/opY09GB2IejS2PM=;
 b=fviEdlXm1TmEqkp+wG7TKUO+V7YxHTeMWII7i0RnPvrncHUCAOb1T9zD6j57FqjiM7
 DKGMMuwOZAvNlCAXnzTf9jJwI2PVOM9YV2Q0ZhPrc1Nk0rmofVPqiTPnoy5ruqY3UAU4
 pMXARjQI63czrcVrk5AZt19ZnRfl0fGqTtYnwwuPRcIv1iSQQn/BIDETVt30BlxjAkYp
 a6Xb+3ebVQ7cyBThupY4QAu/MPSH0X/0j+WEYDKZyybnZ0t9S/bCah9b5pYS5v+mC0SP
 59Y7xa9C+YkmeDb5k88v5Sr9lNGTpyHEZERH9afdA8b21V1cceAiQEHAX1C2nwX3oAGL
 LRgQ==
X-Gm-Message-State: AHQUAub0jc7Py33EdFffcYF/JKAHrdy2Q7obaVbgjosTToxqo/1kJDfD
 SAmOlnG+g+5cYNDdseX47Bz9akIqhRbu4FEx4xk=
X-Google-Smtp-Source: AHgI3IavRXhbZ8jEiblEEv8C1nkGaudj56+eoSf64oeTR0CqFXwvKxwie21etwVw686Bx0D2ajkVSK8gOE4OEKQGUts=
X-Received: by 2002:aca:cd93:: with SMTP id d141mr5179779oig.163.1550220250349; 
 Fri, 15 Feb 2019 00:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20190213214052.2427-1-linux.amoon@gmail.com>
 <20190213214052.2427-2-linux.amoon@gmail.com>
 <CAJKOXPeyFmKUGwqS1sgf_k2WSx9i0AETjpOLXtsmLFupTpgqnw@mail.gmail.com>
 <CANAwSgQB-=iwX1L0m6N=dbe6jbfUMYyjgna_QMmJyggj6rxzwQ@mail.gmail.com>
 <CAJKOXPcrkVEgsaTFrQbCvn=gx3h6av7zvaXcfroNMYk6qgs8mQ@mail.gmail.com>
In-Reply-To: <CAJKOXPcrkVEgsaTFrQbCvn=gx3h6av7zvaXcfroNMYk6qgs8mQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 15 Feb 2019 14:13:55 +0530
Message-ID: <CANAwSgQv6O281dJ_8nz8dvfuf5sYijZTn9XBEx1RDwN6ikgjQA@mail.gmail.com>
Subject: Re: [RFC 1/2] ARM: dts: exynos: Add proper regulator states for
 suspend-to-mem for odroid-u3
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_004411_312763_DC49557A 
X-CRM114-Status: GOOD (  32.27  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Pankaj Dubey <pankaj.dubey@samsung.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Krzysztof,

On Fri, 15 Feb 2019 at 13:01, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 14 Feb 2019 at 19:35, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > hi Krzysztof,
> >
> > Thanks fro your review comments.
> >
> > On Thu, 14 Feb 2019 at 18:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Hi Anand,
> > >
> > > Thanks for the patch. See comments below.
> > >
> > > On Wed, 13 Feb 2019 at 22:41, Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > Add suspend-to-mem node to regulator core to be enabled or disabled
> > > > during system suspend and also support changing the regulator operating
> > > > mode during runtime and when the system enter sleep mode.
> > > >
> > > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > >
> > > > Changes from previos patch
> > > > [0] https://patchwork.kernel.org/patch/10712549/
> > > >
> > > > Set all the WAKEUP source regulator in suspend-on state.
> > > > LD04, LD012, LD015, LD020, LD022
> > > > Set all the non used regulator in suspend-odd state
> > > > LD02, LD03, LD05, LD06, LD07, LD011, LD013, LDO14, LD016
> > > >
> > > > BUCK5, BUCK6, BUCK7 and not confirable as per driver max77686-regulator
> > > >
> > > > Tested on microSD card and it resumes correcly after suspend.
> > > > eMMC is not able to resume after entering into suspend state,
> > > > which need to be investigated and how to debug more.
> > > > ---
> > > >  .../boot/dts/exynos4412-odroid-common.dtsi    | 63 +++++++++++++++++++
> > > >  arch/arm/boot/dts/exynos4412-odroidu3.dts     |  3 +
> > > >  2 files changed, 66 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > index 08d3a0a7b4eb..e984461c37d9 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > > > @@ -288,6 +288,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > I see my comment from previous patch was not addressed.
> >
> > I left this unchanged since this regulator is not active linked and used.
> > Ok I will change this to regulator-on-in-suspend,
>
> Why?
>
> Previous patch was setting this to "on". I said that this is noop and
> if you want to add it, I need explanation why this regulator has to
> stay on during suspend.
>
> So you changed to "off"... which is still noop... and you did not
> provide explanation. Now you replied that you will change to "on"...
> so this will be circle. Still without explanation.
>

I will re check with my previous patch and the driver code which
support suspend state.
Ok check the regulator driver max77686-regulator and enable the logs their.

> >
> > From documentation device tree binding regulator.txt
> > "- regulator-always-on: boolean, regulator should never be disabled"
> >
> > But some regulator switches to a low power mode under light current loads
> > and the device automatically switches back to a fast response mode as the
> > output load increases.
> >
> > >
> > > >                         };
> > > >
> > > >                         ldo3_reg: LDO3 {
> > > > @@ -295,6 +298,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > The same...
> >
> > Ok I will change this to regulator-on-in-suspend,
>
> The same - why changing this to on or off? I need explanation why this
> should be in first place.

I will check in the driver code.

>
> > >
> > > >                         };
> > > >
> > > >                         ldo4_reg: LDO4 {
> > > > @@ -302,6 +308,9 @@
> > > >                                 regulator-min-microvolt = <2800000>;
> > > >                                 regulator-max-microvolt = <2800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo5_reg: LDO5 {
> > > > @@ -310,6 +319,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo6_reg: LDO6 {
> > > > @@ -317,6 +329,9 @@
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo7_reg: LDO7 {
> > > > @@ -324,18 +339,27 @@
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo8_reg: LDO8 {
> > > >                                 regulator-name = "VDD10_HDMI_1.0V";
> > > >                                 regulator-min-microvolt = <1000000>;
> > > >                                 regulator-max-microvolt = <1000000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo10_reg: LDO10 {
> > > >                                 regulator-name = "VDDQ_MIPIHSI_1.8V";
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo11_reg: LDO11 {
> > > > @@ -343,6 +367,9 @@
> > > >                                 regulator-min-microvolt = <1800000>;
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo12_reg: LDO12 {
> > > > @@ -351,6 +378,9 @@
> > > >                                 regulator-max-microvolt = <3300000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo13_reg: LDO13 {
> > > > @@ -359,6 +389,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo14_reg: LDO14 {
> > > > @@ -367,6 +400,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo15_reg: LDO15 {
> > > > @@ -375,6 +411,9 @@
> > > >                                 regulator-max-microvolt = <1000000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo16_reg: LDO16 {
> > > > @@ -383,6 +422,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo20_reg: LDO20 {
> > > > @@ -396,6 +438,9 @@
> > > >                                 regulator-min-microvolt = <2800000>;
> > > >                                 regulator-max-microvolt = <2800000>;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > >
> > >
> > > The same... any comments?
> >
> > I left this on for mshc_0 (emmc) regulator,
> > since I could not get suspend resume working on eMMc
>
> In general eMMC can be turned off during suspend. However eMMC layer
> may be handling this (manually turning off/on). So after checking and
> confirming it, please document it.

I will check in the driver code.

>
> > >
> > > >                         };
> > > >
> > > >                         ldo22_reg: LDO22 {
> > > > @@ -405,6 +450,9 @@
> > > >                                  */
> > > >                                 regulator-name = "LDO22";
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         ldo25_reg: LDO25 {
> > > > @@ -413,6 +461,9 @@
> > > >                                 regulator-max-microvolt = <1800000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck1_reg: BUCK1 {
> > > > @@ -421,6 +472,9 @@
> > > >                                 regulator-max-microvolt = <1100000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > >
> > > Again, you did not address my comments.
> > >
> >
> > Buck1 support entering into LPM setting,
> > But I will set this to regulator-on-in-suspend; in next patch.
>
> Why?

I will check in the driver code.

>
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck2_reg: BUCK2 {
> > > > @@ -429,6 +483,9 @@
> > > >                                 regulator-max-microvolt = <1350000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-on-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck3_reg: BUCK3 {
> > > > @@ -437,6 +494,9 @@
> > > >                                 regulator-max-microvolt = <1050000>;
> > > >                                 regulator-always-on;
> > > >                                 regulator-boot-on;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > >
> > > The same...
> >
> > Buck3 support entering into LPM setting,
> > But I will set this to regulator-on-in-suspend; in next patch.
>
> Again - why this should be on or off?
>
> > >
> > > >                         };
> > > >
> > > >                         buck4_reg: BUCK4 {
> > > > @@ -444,6 +504,9 @@
> > > >                                 regulator-min-microvolt = <900000>;
> > > >                                 regulator-max-microvolt = <1100000>;
> > > >                                 regulator-microvolt-offset = <50000>;
> > > > +                               regulator-state-mem {
> > > > +                                       regulator-off-in-suspend;
> > > > +                               };
> > > >                         };
> > > >
> > > >                         buck5_reg: BUCK5 {
> > > > diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > > index 2bdf899df436..4ebde09fc51d 100644
> > > > --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > > +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> > > > @@ -82,6 +82,9 @@
> > > >         regulator-name = "LDO22_VDDQ_MMC4_2.8V";
> > > >         regulator-min-microvolt = <2800000>;
> > > >         regulator-max-microvolt = <2800000>;
> > > > +       regulator-state-mem {
> > > > +               regulator-on-in-suspend;
> > >
> > > Why?
> > >
> >
> > I chose not to disable mshc_0 (emmc) regulator,
> > since I could not get suspend resume working on eMMC.
>
> Having "regulator-on-in-suspend" is not the same as not disabling
> regulator during suspend. This property means you will explicitly
> enable it during suspend. To me it looks wrong so I would be happy to
> see explanations.
>

Ok I will disable this and check this help me fix the issue I am observing.

> Best regards,
> Krzysztof

*Sorry for wasting your time*
I know I have the improve a lot of things.

Best regards

-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
