Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D46C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:02:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D57C2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V8Q+gpxA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YltO5+fX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D57C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/QTrO4bNGvWvwOyiol7Q3iQ5U8CGvTThtgTm4do7ZdY=; b=V8Q+gpxAKJy/m4
	CSLUPlDWSYnPYr41dEc76Vm7c1m3mfU/3tGHBZqqc3Yvv5H7Ub8EtIqffl472VeJo9RYXWSFtZt+k
	Uh8S9kxLGPSP54GhNsOfPNWcw55ky7/hISCnc9NhZNSWbidZGXJtqFd4AUB4bTGwL0Kvni9n5zGGx
	G49llG1uubUSOxLGThvMDWXQoErOZVs6qATfZYqtUuCFK0Vfp0FFkVjHs880h24UEvcGSt2AdBQMH
	lThh2Pw50hChQmbciOi1BQ401h3JnNTscnHQ+82UI7OjKBNJmFEA8B2Fwgv+vJXxWFBkIiULvgT2k
	UWllhKiKBHEvarvPymQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaHdB-0007cG-9m; Fri, 21 Dec 2018 10:02:09 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaHd0-0007aw-Vf
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:02:06 +0000
Received: by mail-lf1-x142.google.com with SMTP id b20so3463163lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TAoEMsT2IMcQJB1nBDhNQagiQv6o4I/H6mhK69Y/SAI=;
 b=YltO5+fXyB+wRR6WVXASdFiQ6YbjMYULLg1Da/Op20rkcqYKePjv8w1Ren6dZzgDmC
 Cn5KJuZhUNwUBFxGJjup3cGdZ/G7J0m/Eccwvm/W8oSfMBO/J2r8+UxhOvdACmS+dvI8
 ox+LjAm8TgBJRD5EJBFTfeNkhnbpaSJeKaayM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TAoEMsT2IMcQJB1nBDhNQagiQv6o4I/H6mhK69Y/SAI=;
 b=mpQBVXzSJP41JbRcz2F/PEnhV8i6ZQWzqgGTe27l3vitsvP9J4cjGeOyPNnFjb1G8H
 kePk0v26PN6E2X1AeHfkjCtUNMr3kq8I2MnkOAGHPU01Yfz0kGWdgI8JQXbypIHd6xFm
 Skx6bOCYD21HMTg4SxZ5hhiTUj0bzT5q3ok470QSSn+rb6IsVxTUePznygeSBFAZm2w4
 AjeX0eGYfNuDZXX376PKEOvAYYInT1mywBxL3uRRi+NQpBhr8wwnItceBRkbgFhgG61y
 NjI063a3LJdfiVH8Wlvr/zwPa3/7j2XggnwW5FLj4Olif/QVWWWabyGehAiCWCg+gYpz
 4dwg==
X-Gm-Message-State: AA+aEWb3LsFf0L6GaKktnadT5/fShcf7uKCpUYFANdXcq8GjJknNJ1wc
 XovA2pr21HEfAmu25xNkdlG5W3qmytEmg04KG434FQ==
X-Google-Smtp-Source: AFSGD/XAbRiaLmWNs6PS/cM2L4w/CMgvQ27ksMmkwA1Oz8gwgS1CVkWV6iVJoLu9oKCLDu030r1zPcRubaRgykvigHA=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1071666lfb.96.1545386506529; 
 Fri, 21 Dec 2018 02:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 21 Dec 2018 11:01:35 +0100
Message-ID: <CACRpkdZ+vUwEcEyMj0Snsy_F8AmELSMt1wGbhMsQi7A=_tY3RQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] pinctrl: various fixes for Meson8 and Meson8b SoCs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_020201_813787_015C0249 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Carlo Caione <carlo@caione.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Dec 9, 2018 at 8:51 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> While debugging an USB issue on my Odroid-C1 I found a few issues with
> the pinctrl driver for the Meson8 and Meson8b SoCs:
> - GPIOAO pins cannot be specified as GPIO group in device-tree
> - (not a bugfix bug an improvement) make the gpio_periphs group naming
>   consistent with drivers for newer SoCs
> - add missing GPIO_GROUP definitions for the pins in the BOOT and CARD
>   banks
>
> I added the correct "Fixes" tag to all commits where applicable. These
> fixes don't affect any existing boards or functionality. Thus I suggest
> to apply them for next (v4.21) instead of sending them to mainline.

All patches applied for v4.21!

Sorry for taking some time to process.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
