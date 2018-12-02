Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E92DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:12:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08E620881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W4yjK+Pt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OvcAGoAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08E620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PfZcexkjIy/I+Qwn0p/z6zk6R3y4rZl6QAj+HingxfY=; b=W4yjK+PtOxbPgs
	81ZQFfoUWOfw+ZbXCa4JufisdPQSzhOHjbhRmo7HuCXdLoqyVg3rejU3sm0kbwTAABah1ZixHpK0+
	ZFEmRZQOWnYot4mvSRT+d2M5rdW7mgJQaEcxfC4BbbVxur2Uhtu1ucl3F4QFgXqEHcV7Kh0NB81ib
	QcBn4B3+/zDFlp6vC1dmT8YCXmwOiKBJTZ/Mavn23dT5Q8SphfPufNHkC4Zaukm3nOJrOJB19tdIT
	F4ISbd+u6OEJEvkxvzRfxFTMCkAfjlQL79DHrj7DpyRWze5i9gisFRh2VSTMEAgGRtTQsbODS1IAG
	pwO6sCIewM0xlCjJx0iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZ2m-0005X9-Jv; Sun, 02 Dec 2018 21:12:48 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZ2i-0005WX-3A; Sun, 02 Dec 2018 21:12:46 +0000
Received: by mail-oi1-x244.google.com with SMTP id h25so9217842oig.1;
 Sun, 02 Dec 2018 13:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YNC6UybqQt8UI6xiJE2xLki3zzn88E5tXcT+MtLKe68=;
 b=OvcAGoArXMu1YS4lVnY9aw1AMOyip7+gv37XNXPayMniRpD22xvLImQy8R2ojzU409
 DfZD4aWYzEn3z4Zmx2nKBYIknhbJe160FgTVOS2UDSBNkDp2mp25VXr0uheUcSH5KGik
 jv46htjH2kgB27JniIAvwHEM0YFg00fBOpgHpDBam5JWbU4ZYBg3hUBFbuISZOOj5GCQ
 Gp53cAiZLgYsfYUufBmw4Pd4TAuUqb6z8SH+7/FvMR/3oFEVXricX2ksJcrVPGqK3IsX
 K3EAzkPDooI8Xrp71nqr4Zh0IeO1DbTCsPaP+Sh/jPV3xC4K+SPfPvMpJW8AuVfIOaMy
 Nq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YNC6UybqQt8UI6xiJE2xLki3zzn88E5tXcT+MtLKe68=;
 b=VY6voB12w93l7KTqvcak9w9E+gm3SEn3SbpW1DjIqQmnOKwGfEDdZ6aPnY88TTB7U2
 gxm51PyH250CaZvDlHF4+48BUZ+RBNjni/PY+SMMN8hHgEnRiKfPYGhv4yrdlr32aeFa
 bpXm4x7zlluMWWA81ZSTp9u3mON49HLCz9M56fuNZNqpVxgBw98pqyY0zdxFmE2X4tS+
 OsRVqtBd1MYffb3NMKIuI3PRUPEikRyiojvgUOsBKMqgugktALlTJNCcBN6mtd4OKeT4
 T6tr9OcGfPPq2u9rIDZXuWf/a6A4fQDcHyZo1c33NUAv6fs/Pl/mQ7sj7z4kcaNn7IkE
 zUlA==
X-Gm-Message-State: AA+aEWYrVVKdkeK+P2ktgtV9grOkAEmirM+qZOpUiCfRJmDppU/H27Ex
 sKUDOXBwqn7FMcpbFIdIM5/ssxjGnsKeYn/hK94=
X-Google-Smtp-Source: AFSGD/Vl3zKkeQK3n/q92OMoPK0sdOEfpj9yvzmrF/gMXAir7g7yGiQNM4aM2dY/hAyCy3yvaTVmLp4zmp796DecV1Y=
X-Received: by 2002:aca:f0f:: with SMTP id 15mr8898641oip.47.1543785152265;
 Sun, 02 Dec 2018 13:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 2 Dec 2018 22:12:21 +0100
Message-ID: <CAFBinCDg2tbaJMYusLyH-q1=n1Mb8ng4BhGOa8=vc0QoAFMzFA@mail.gmail.com>
Subject: Re: [PATCH 0/6] 32-bit Meson: add the ARM TWD and Global Timers
To: khilman@baylibre.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_131244_154322_CC244166 
X-CRM114-Status: GOOD (  19.05  )
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
Cc: carlo@caione.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Fri, Nov 23, 2018 at 8:53 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
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
this is already merged into your v4.21/dt branch

> - CLKID_PERIPH requires updated clock driver headers. Neil provided
>   a tag which includes the updated headers: [2]
this is still a dependency which you could easily pull in

> - There is no runtime dependency on the PERIPH clock as we don't
>   have CPU frequency scaling support enabled yet. In case the TWD
>   timer driver can't find the clock it falls back to auto-detecting
>   the clock rate at boot time. This is safe as long as we don't have
>   .dts patches in place which allow changing the CPU clock rate. Once
>   we enable CPU frequency scaling support for the PERIPH clock becomes
>   mandatory so the TWD timer driver knows about changes to the PERIPH
>   clock (which is derived from the CPU clock).
and there's still not a hard runtime dependency until you apply [3]
"ARM: dts: enable CPU frequency scaling on Meson8/Meson8b"

> Martin Blumenstingl (6):
>   ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER
>   ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
>   ARM: dts: meson8: add the ARM TWD timer
>   ARM: dts: meson8: add the Cortex-A9 global timer
>   ARM: dts: meson8b: add the ARM TWD timer
>   ARM: dts: meson8b: add the Cortex-A5 global timer
>
>  arch/arm/boot/dts/meson.dtsi   | 24 ++++++++++++++++--------
>  arch/arm/boot/dts/meson8.dtsi  | 32 +++++++++++++++++++++++++++-----
>  arch/arm/boot/dts/meson8b.dtsi | 32 +++++++++++++++++++++++++++-----
>  arch/arm/mach-meson/Kconfig    |  2 ++
>  4 files changed, 72 insertions(+), 18 deletions(-)
if you plan to send another pull-request to the arm-soc tree then
please consider including this series.
it fixes some harmless (but still noisy) warnings during boot which
also also seen by Odroid-C1 in your KernelCI lab:
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
  Clockevents: could not switch to one-shot mode:
   dummy_timer is not functional.
  Could not switch to high resolution mode on CPU 3
  Could not switch to high resolution mode on CPU 2
  Could not switch to high resolution mode on CPU 0
  Could not switch to high resolution mode on CPU 1


Regards
Martin


[0] https://patchwork.kernel.org/patch/7797581/
[1] https://patchwork.kernel.org/cover/10687005/
[2] http://lists.infradead.org/pipermail/linux-amlogic/2018-November/009136.html
[3] https://patchwork.kernel.org/cover/10705475/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
