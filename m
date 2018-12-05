Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196AAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:51:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF91220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WYwyiskX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="atG+wfkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF91220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fIq6KRrFPoctjXMVE4tyzbBiS4x7eoVuYWErTbZGtyA=; b=WYwyiskXuMKeYl
	q2G6Rcm//t/G5IuSVVD4fvEq4a6X7aNO1CcQrD26cb5nEDHSeCkAH/EK7biHySwIFyYV1m9m5oOlR
	pCZKz9uOaZCVNr0lZRTWeVVdvu4o21R8vSGcekoI+fyzHe6qdAlOZ9MdpNBG9S2nYcC7mKvcKl+MF
	8BLKMe15UEuhMaRJqfF91+hxpzb/yJKc92D/qFwFNaCL8R+oBW0aoVKv4+yqzksvhpY36cwLPIjh5
	Q3bHl12AbzN2zzqOeZ6NFrsdKky3dIQxaCQWOdjgEVQ6z1ni6WvJZQjL8mO8htUlVXmv+OPk1J67y
	M+4HELQmjTbDTVPPscNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULPt-0007tw-Gr; Wed, 05 Dec 2018 00:51:53 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULPp-0007ho-Q8
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 00:51:52 +0000
Received: by mail-pf1-x441.google.com with SMTP id c72so9088433pfc.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 16:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=/UOZRCzp8o93LV/zBJgnh/YA7nPwCovq44EnVRi0VQY=;
 b=atG+wfkNdf+yFgbTamkezUr5E/3chGK32+6EPmHxG/HvbfrJLvroV9tPEcVOgDQsdm
 SQPCymQuZucruHUujK9LHSXCHnR2wLoaCUf2zC7f1iDuz5O4vDSHZddVYs3CZVEoTTtt
 Y9SQ4YA3Lu40lr8gCbYYPn4KUXCS4KTKI3qEYSfbF7tRQ53Cg2JaUpdYYqF8RhTmBzUZ
 5gdiw3kfQMtlX25h1z49bgBCNX7JuPe7NkoYGjj0/7l+ZXX3lw5s/3wNtwujqNJvzaEJ
 mQJPsTYZEhqygYetY7AW1D1WVwjAp3pqMPxlXGrymvypOP+px9ATqxGhK8C3lIa80TyX
 H1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=/UOZRCzp8o93LV/zBJgnh/YA7nPwCovq44EnVRi0VQY=;
 b=bH8QQbQNep2XkTeIVLc0R/Q7tXs+HS0lxKuIzqFs7DCKQLwM5CeLlW8HjhOyVBBSie
 jb3RdFYK5pP4uP/UwFJKPWHci57sBjPryGyCQpoUX8irImcYDIRp0vLYgs2b1o7oHJmn
 k/PEURbAve5hIc6iCC+2eD16RDbHZVjf1YTsL0KXbP87Wcike4wVAluCZjvB8tbxWaE8
 FxN6bNWm9tFETshKU0MCqGd+66ZDJ7flovwlJtUwCIiuZN09gAn+uVzqdvnkf21WQsNF
 Crx4J1qx9Axi9LoUP2QhzEvxNCKDDyLGDCs7CkbMvo5k5oyOXUDx3JpJevYjLZ02V5/d
 rBRA==
X-Gm-Message-State: AA+aEWZauLxlJKwaQSWxzJoZoLBRcFNbFh0XWdvBMSQ7j443fucLs7oe
 yGGSB6VjmPfE4gGGE0DmKHRUimfOBIQ=
X-Google-Smtp-Source: AFSGD/Xqk7EtQdo6NJyHGtu0xUA/IzsmeksJ8+xYl7i6kJxHa6KU71T1CpLnd0HHoWdqrPHaN2jLlA==
X-Received: by 2002:a62:d0c1:: with SMTP id
 p184mr22113582pfg.245.1543971095199; 
 Tue, 04 Dec 2018 16:51:35 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id r12sm18045914pgv.83.2018.12.04.16.51.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 16:51:34 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, carlo@caione.org,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/6] 32-bit Meson: add the ARM TWD and Global Timers
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
Date: Tue, 04 Dec 2018 16:51:33 -0800
Message-ID: <7hwooobxt6.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_165149_898968_18FC54AA 
X-CRM114-Status: GOOD (  16.86  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The 32-bit Meson SoCs use Cortex-A9 or Cortex-A5 cores. These come
> with the ARM TWD ("Timer Watchdog") which contains a timer and a
> watchdog as well as the ARM Global Timer.
>
> This enables the corresponding configs for the 32-bit Meson target.
> Additionally this adds and enables the ARM TWD timer. The Global
> Timer is added but currently disabled because it's clock input is
> the PERIPH clock which is derived from the CPU clock. Thus the rate
> of the PERIPH clock will change when changing the CPU frequency.
> Unfortunately the Global Timer driver doesn't handle clocks with
> changing rates yet (unlike the TWD timer), thus we keep it disabled
> for now.
>
> The whole series is inspired by an almost 3 year old patch from
> Carlo: [0]
>
>
> Dependencies:
> - I build this on top of my other series "ARM: dts: meson: add the
>   timer interrupts and clocks" from [1]
> - CLKID_PERIPH requires updated clock driver headers. Neil provided
>   a tag which includes the updated headers: [2]

I pulled this branch into v4.21/dt

> - There is no runtime dependency on the PERIPH clock as we don't
>   have CPU frequency scaling support enabled yet. In case the TWD
>   timer driver can't find the clock it falls back to auto-detecting
>   the clock rate at boot time. This is safe as long as we don't have
>   .dts patches in place which allow changing the CPU clock rate. Once
>   we enable CPU frequency scaling support for the PERIPH clock becomes
>   mandatory so the TWD timer driver knows about changes to the PERIPH
>   clock (which is derived from the CPU clock).
>
>
> [0] https://patchwork.kernel.org/patch/7797581/
> [1] https://patchwork.kernel.org/cover/10687005/
> [2] http://lists.infradead.org/pipermail/linux-amlogic/2018-November/009136.html
>
>
> Martin Blumenstingl (6):
>   ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER

Applied to v4.21/defconfig

>   ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
>   ARM: dts: meson8: add the ARM TWD timer
>   ARM: dts: meson8: add the Cortex-A9 global timer
>   ARM: dts: meson8b: add the ARM TWD timer
>   ARM: dts: meson8b: add the Cortex-A5 global timer

Applied to v4.21/dt

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
