Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1BEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:33:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E22E2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F3D+o0qZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D973TjTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E22E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=16C+W0k7vrej59UC2mZuTbzCmakGRITfCkPj+AyYpxk=; b=F3D+o0qZXEFUN+
	swaTC1ol0YFTPxdanz7lDUwsABzeBOCZ+tnmNMDh0Je4AOb71WFCy3c/5gj2M+iPDN5Net0YkmBA7
	s6s2m92M3SQXDXXkUy+06nn7CiiIAnZQODmEOxbkAH03A7jQ0180Q349fn4/Z6yHIAceIIzR+0hLN
	K9Pn0eIo8L/LnEQdAiEb14K3vlJneZXLyymo8Xox4LCvsgPRgTN8BRi8gukyzLF/9Sl3FWlhiKm0f
	kTMoGzIezyTUGMub2Ib3V+2R1uLxRpD1loIPK5gEGdDrxDIcYLtUaLG5DCU8K8/ALfn19f7ui1rDA
	V4NrCXkkljExvjd0uNAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx89E-00089L-AX; Fri, 22 Feb 2019 10:33:40 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx89A-00088l-Ny
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 10:33:38 +0000
Received: by mail-ot1-x341.google.com with SMTP id n71so1433113ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 02:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kPoR1P+Jx7C7d9k/Q/XUwBrh6UJnb7qtMiFYdsFu3s4=;
 b=D973TjTCF970LNesGwfFth4msYJckQM+sHxHgHJ4SDdL5iiqks5a/orvXY4WPZYwYy
 UNi8PiT4JTX7vEhWK/SzQXaGoVhGEDeO2ylHCFz6834G+aeezHzumz7/8RpioAI/+v4r
 oG9U0fMvftjwW1PulSJK6Z+X51ozVQsvow5hrUq2/pLqZV2khUdaUFcA4XTSRVwwJ2EY
 LpX3h2T+VnhIFGfo1gnmD3vCMtYaqgPdSCoa70koMzmw3o5HDFLMbt9K/C1goNN0drrF
 DNyhzs9b0GQs+190G4DjxfvVolg9RoEkKl/ePe5yvDSQSCTKgr5HBCnCFYg5gB+YuJkf
 sPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kPoR1P+Jx7C7d9k/Q/XUwBrh6UJnb7qtMiFYdsFu3s4=;
 b=RJLxGeMvW/4Z5iYBiiSdnAsWXDwWHoJnv2RYTyfx87hmKvrT+ISofAR944XoDlUZOi
 Rt8XbOxhfwvRPrQq5jPqC78suotHuh3RPofes0eSLDHjoBuoNcl/QeaMMeGWOuNmnbCX
 PV/7qqm5jvY5eBaK/ATKaOZoeVmakchGTYKt0OVMvfSNn45KY3OgGxUvnIxp6/IAiOhA
 AOB/wVLYYd4qmfuImYat9WeNu2OqCLlAwTKbxrDY1Wo89xkfQJPWxJdcJ0qwl9sJtuIP
 qgnTGOG+VBnHr6wtElf1A0NsgENXNjnSjPVAOEgsKdl8bZlXYTzsgRrnvrT7fhL9nv4b
 WQjw==
X-Gm-Message-State: AHQUAuYlrn8/HtXNtd5rThZjwmJ/R7WXE8tKDz2clt/7nDXoLS+8xYhK
 9dElBhr0f6ToROpKJM/dE46UZDIZO7rMenb55a8=
X-Google-Smtp-Source: AHgI3IahvAgFj6HX0sGtDIKUruSFZn0xCxQL8wQ1GZSiE85RxiZij1ehpjQ86ayaacrUV77MAUvau4Ai6qlYrAdGp8k=
X-Received: by 2002:a9d:69d4:: with SMTP id v20mr2314540oto.41.1550831615833; 
 Fri, 22 Feb 2019 02:33:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190222102034epcas3p373245ed6e3e83e297bcaff48aec37992@epcas3p3.samsung.com>
 <20190222101948.848-1-linux.amoon@gmail.com>
 <d4f36ce1-ddef-5756-05dc-74e8dd08417c@samsung.com>
In-Reply-To: <d4f36ce1-ddef-5756-05dc-74e8dd08417c@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 22 Feb 2019 16:03:26 +0530
Message-ID: <CANAwSgSnunUbZJeT72B7HjAuBgsLQFA6_y_ijadHUKEAOoM-gA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add pin configuration for read strobe
 for Odroid XU3/XU4 eMMC
To: Marek Szyprowski <m.szyprowski@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_023336_806547_E8950E49 
X-CRM114-Status: GOOD (  16.07  )
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
Cc: devicetree <devicetree@vger.kernel.org>, linux-samsung-soc@vger.kernel.org,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marek,

On Fri, 22 Feb 2019 at 15:59, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Anand,
>
> On 2019-02-22 11:19, Anand Moon wrote:
> > Add Read Strobe RDQS pin configuration for eMMC to support higher data rate read/write.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 6 ++++++
> >  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> > index b82af7c89654..4fb3865e082a 100644
> > --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> > @@ -206,6 +206,12 @@
> >               samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> >       };
> >
> > +     sd0_rdqs: sd0-rdqs {
> > +             samsung,pins = "gpc0-7";
> > +             samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +             samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> > +     };
> > +
>
> The above lines are not needed. There is already a sd0_rclk node with
> exactly the same configuration just above your change.
>

Sorry once again, I failed to look closely., sorry for the noise.

Best Regards
-Anand

> >       sd1_clk: sd1-clk {
> >               samsung,pins = "gpc1-0";
> >               samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > index b299e541cac0..d41397748ed2 100644
> > --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> > @@ -411,7 +411,7 @@
> >       samsung,dw-mshc-hs400-timing = <0 2>;
> >       samsung,read-strobe-delay = <90>;
> >       pinctrl-names = "default";
> > -     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
> > +     pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_rdqs &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
> >       bus-width = <8>;
> >       cap-mmc-highspeed;
> >       mmc-hs200-1_8v;
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
