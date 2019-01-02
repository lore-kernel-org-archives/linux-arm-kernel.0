Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AA0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:21:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0228C214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rD1fDw1E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTFLusnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0228C214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FOHyOb+X4RTD9WPuOzz52+aj1HPh/70LwrIuxrR0/Go=; b=rD1fDw1ECenVg7
	ysV2WbGrPWWZMxpfV7wQuYagjpSs7ckw8iTjBt1YBKKfTFrJ2CH6k5xvPGo/s9JqGb8jmXqorazaA
	Hw/LSH6QOKpEz0WKa++A0D/9oY0faYQTgRly5PLp9/C1SCzWfvWc0r9I1fGNpI2dSk8fHK0AcnNqj
	6poDXYV4kn59RNfLkkhaENyL+3XBkK8D5/GtBhxBKY9rOjjkZnWAJ9MGXlfTioasZdBG/g9cNntoG
	SOzxvDJlz9DhSsAN3a9026vVQ70NhVAEwRvGpBPQSzKDn5b6SzS+IriFohBNKku0Oosgt2zJD+MwR
	CMlvOHkZxjTo7kGJ/XAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geot4-0006Tt-Jp; Wed, 02 Jan 2019 22:21:18 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geot1-0006TV-D4
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 22:21:17 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so16871002wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 14:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ojsTVbVTAIs/niPLHtQCX4zbvkoWHK82NQCIk9i6+8=;
 b=cTFLusnhZoz3q1fJeFAUiB9UfM8v2Go7kbvchGEIQFjv/F/Jemi0KXEmU4+B+Lo2xR
 /Ur3P+C+vywRWfDPC+I/Grv3M0zWL8yUbTGNxhg0Z1jS0R0hYhoArKUOpuuJYDt2lhh2
 +lgm7ZEyR5gDCcTaNI76Br9Y5TgDDYLLzsAKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ojsTVbVTAIs/niPLHtQCX4zbvkoWHK82NQCIk9i6+8=;
 b=tshVCXsBD3MCRQVRz+aCgt+qVId6RKp7gh7FkDqVAG4Fruid5qNpkdzjtKvkcu+cLx
 lf2OM6ABbBpdqNhnyec5gnLFGc1LGQITyHS7aYV8UIGIA1qlOG90Qq+mpkPd7KntWui0
 A5QbioP7yYxf1HibctC3egMAZTskOq5u3AST5+UolqwhNMAdWue/Xr4tdit7YtEJVEJ1
 oSqaybkvCLlYqzlINMtVEgdQLOIv8atVLDQOrMIspztKhmbVkogn7eOUBRgnFP0qZPr0
 3j2TJrIt8NyQQIhHFbbgek0gPjItWruQ5Pns5sP9pzQh+Gg8Xq11xJOnSgiafJv8lIWe
 iDDg==
X-Gm-Message-State: AA+aEWZpTwVIA/TEqKxG7ooZRyiFs0ZLWS97uLvKl23UF1d1oVZeCaGf
 ZERynWXJMZAaQZatyvhQbl1EnDdmBugNFRb87wIXrA==
X-Google-Smtp-Source: ALg8bN43iK9qfYLUWpVldk4Xure8bzEyIOlklXkgIW3+BA1O8pwlUcSS5szn/Ni7Hv4AI6gY8ogyoKnoxOp3SRHZiHc=
X-Received: by 2002:a1c:b456:: with SMTP id d83mr38299481wmf.115.1546467673353; 
 Wed, 02 Jan 2019 14:21:13 -0800 (PST)
MIME-Version: 1.0
References: <6ccac7db-3ab7-e396-90be-8681a8ee336b@web.de>
In-Reply-To: <6ccac7db-3ab7-e396-90be-8681a8ee336b@web.de>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 2 Jan 2019 14:21:01 -0800
Message-ID: <CALAqxLXz_s6B=NzSp17Lj6xMTYybEsMh4jDR8COXnWQCnFTrsw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: hikey: Give wifi some time after power-on
To: Jan Kiszka <jan.kiszka@web.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_142115_450859_923B6C49 
X-CRM114-Status: GOOD (  16.44  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Ryan Grachek <ryan@edited.us>,
 Tony Lindgren <tony@atomide.com>, Ricardo Salveti <rsalveti@rsalveti.net>,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wei Xu <xuwei5@hisilicon.com>, KISHON VIJAY ABRAHAM <kishon@ti.com>, "Reizer,
 Eyal" <eyalr@ti.com>, Kalle Valo <kvalo@codeaurora.org>,
 Valentin Schneider <valentin.schneider@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Mishol,
 Guy" <guym@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Adding a few folks to cc from the thread here:
https://patchwork.kernel.org/patch/10734021/

As this sounds like a very similar issue.
thanks
-john

On Sun, Dec 30, 2018 at 3:38 AM Jan Kiszka <jan.kiszka@web.de> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Somewhere along recent changes to power control of the wl1835, power-on
> became very unreliable on the hikey, failing like this:
>
> wl1271_sdio: probe of mmc2:0001:1 failed with error -16
> wl1271_sdio: probe of mmc2:0001:2 failed with error -16
>
> After playing with some dt parameters and comparing to other users of
> this chip, it turned out we need some power-on delay to make things
> stable again. In contrast to those other users which define 200 ms, the
> hikey is already very happy with 1 ms.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Tested with 4.19 and linus/master.
>
>   arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index f4964bee6a1a..1e771bf201b9 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -118,6 +118,7 @@
>                 reset-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
>                 clocks = <&pmic>;
>                 clock-names = "ext_clock";
> +               post-power-on-delay-ms = <1>;
>                 power-off-delay-us = <10>;
>         };
>
> --
> 2.16.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
