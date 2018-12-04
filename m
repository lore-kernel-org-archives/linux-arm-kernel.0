Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEC3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:59:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C7B20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4nCHFY6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f7oiPUSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C7B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/2nb3tIBLxYGvFn2qUPILmHC1IT1urH37rVbLceP+cE=; b=a4nCHFY6PETT+2
	ZZNJJpS3IV04EW4NHhoAsJHdw2eNaZOVfw6e4M9Lp5EitkyDiVXXN/EzqbUenc9Xn+jecDd6d96UE
	nC5r9sAUV58xiBvvspB61WD62aZeKLL+WAGHT38Pib8FfmvjT+E5cfQH3ktwrd9Q8hBe6Ks2Ylpqj
	9cz/HjrEu/eTDlw9Yx1xIIUOEJwsH3zxT2ZQpCLa9/J8pYtYziiboRrDslJK3b3aVqrL8XUkyoRwo
	lrqvd46PyNhGMHpTeqpuqV0VwNrR0O3FqHjFt7n0h0TI+13C74UHEvWZVAIHQnSxKXDkR11IwwypA
	Hkw8bTctQ9ddk16oTvnw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGrB-0007Qu-TW; Tue, 04 Dec 2018 19:59:45 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGr8-0007QG-VZ; Tue, 04 Dec 2018 19:59:44 +0000
Received: by mail-ot1-x344.google.com with SMTP id i20so16396402otl.0;
 Tue, 04 Dec 2018 11:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3g5J4Vn2vKkTvpd5IUdSICFJ8/Vj9g5uNchbMKJVvVc=;
 b=f7oiPUSLHIpoyH612mSKYp1dWisUu+A6+GWPltZjFDCRIkDSdOzNanE/9jx6nXCrsQ
 /pNo5Kipa8LIP08xkg4LHv0hAn5+ltqK3S7v0vYIVkpxeasUaKbhO2JUV8hvQCDtV4Yw
 oTjdrm8MsV5UcS9FbZDvJlSzZUtH1owy8MdROLOLfyD8TGM+3u/WX0fqr/oO/CY8B9yj
 70JilnEIa92TyhvcU4BGYC3o3dpO3VgSRWdFTKxMeDRQPITSkw2MZKp9hUU38rYcURSR
 GsJbyhHToxY+5rr7TH/skV+bBDEjeOwnACUvyCWdfkAJSW5TuKL32ThVRZJA513Z8qvg
 PZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3g5J4Vn2vKkTvpd5IUdSICFJ8/Vj9g5uNchbMKJVvVc=;
 b=TSk6skq6uFYo5cFV8SXIAiY50MR3/60mMf76W2O2UQFEFpHy6fS8gRYrefHYrzfOYS
 ioD09GPYsN7jF2n8vzKaXpOWzaMX19u3b2I6pS+6iJsQRhnPGj3LxBwnAjH0rPtVU1iP
 aYeC4zKi7QwGtEccEQshOKF55V6b3KP3ZEYxYN3tmSmae22V6YOk18EzCScnzvS/aLf/
 bPKy88tRX8kM09blPhF9o+C7/e16e/ibcAJEbLufPm1XeMNQiLkecSYQmltXTtv8FqpZ
 FUq0ZWNa/U8xzifmSXCnNfOaGqWHzQm85DuJz0S4l2wh98z4EgFPlChRLqT0R+cbR9B4
 sIPw==
X-Gm-Message-State: AA+aEWZ99wCj2y9X5yH7xxGHwvr5iI3ZjdQmuYwgRSozwXoKg7kIqgdk
 RlfQ3inm328IXOvS7qSGBxePCYS5s222ux3TRTA=
X-Google-Smtp-Source: AFSGD/W/T8a159KxIQJtVIMIjf7CkVfui4XeYkc2QO5ecX4JwzWNnbUG02RF1bqKpeuonSkoN8lL/NzjaGsqOrxDqFc=
X-Received: by 2002:a9d:715d:: with SMTP id y29mr14003283otj.148.1543953571272; 
 Tue, 04 Dec 2018 11:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20181204160447.27869-1-ccaione@baylibre.com>
In-Reply-To: <20181204160447.27869-1-ccaione@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 4 Dec 2018 20:59:20 +0100
Message-ID: <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
To: ccaione@baylibre.com, ingrassia@epigenesys.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_115943_039235_4E5C9128 
X-CRM114-Status: GOOD (  13.84  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

adding Emiliano because he experienced high packet loss on Odroid-C1
without "eee-broken-1000t"

On Tue, Dec 4, 2018 at 5:05 PM Carlo Caione <ccaione@baylibre.com> wrote:
>
> The wrong IRQ trigger type for the macirq was causing the connection
> speed to drop after a few hours when stress testing the DUT. The fix
> seems also to fix another long standing issue with EEE.
the other two DesignWare controllers (2x dwc2) are also using
IRQ_TYPE_LEVEL_HIGH
so this is not unlikely - good job detective!

> The fixes are tested on a AXG board but we think that the same fix is
> valid also for all the others Amlogic SoC families.
I checked Amlogic's 3.10 kernel for the 32-bit SoCs and it seems they
are setting all IRQs to be edge triggered: [0]
however, Emiliano reported an issue with IRQ_TYPE_EDGE_RISING for the
dwc2 controllers as well. 291f45dd6da5fa6 "ARM: dts: meson: fixing USB
support on Meson6, Meson8 and Meson8b" fixed it for him whereas it
worked for me with IRQ_TYPE_EDGE_RISING

I find it strange though that Amlogic's buildroot kernel (even the
latest buildroot_openlinux_kernel_4.9_fbdev_20180706) uses:
  interrupts = <0 8 1>
which translates to:
  interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>

does the datasheet give a hint that this IRQ should be level triggered
or did you find out by trial and error?

> Carlo Caione (2):
>   arm64: dts: meson: Fix IRQ trigger type for macirq
>   arm64: dts: meson: Remove eee-broken-1000t quirk
>
>  arch/arm/boot/dts/meson.dtsi                        | 2 +-
>  arch/arm/boot/dts/meson8b-odroidc1.dts              | 1 -
these two should be in separate patches with "ARM: dts: " as prefix

>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi          | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
>  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
>  7 files changed, 3 insertions(+), 7 deletions(-)
>
> --
> 2.19.1
>

Regards
Martin

[0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/drivers/irqchip/irq-gic.c#L400

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
