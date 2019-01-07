Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7824C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:51:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50662087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IYmKOmYZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX/HLUl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50662087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YLcqxOEaWtGT2cffWcG/NHJRYdrFISfyqdpBWWitC20=; b=IYmKOmYZ7bPtlg
	wEZvG3nMIC7Mdm9aFDddMBm5XdoslRmLVW6uiNKTaUh3A8Xu570zNKUwLkn/7a1eh5sk8dYsQDsb9
	6XCJ0TdbJSLQdzzVKVYoq/kzywJwDS27LIAWMN+84NYLJUkexqHxijH5GKtTsmLoHma8zdIWHP9cE
	0vvBlWtTYTdPf23hUQ5NO9N6ZXIT4NA27PB4zQNOeWYG4sCf+dQxmTarvcOO39dve9CZrCB9rFsBQ
	jsZ7ruEhhm4J6rxDZYPiALrB3QwA5k05o+as6ZvUWonQ+ObHuFUS10i4ssKtiyvOjWZZd1aqVnlR2
	9DZ9O/c+GwGqDCSJfvOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggQct-0008R0-GV; Mon, 07 Jan 2019 08:51:15 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggQcp-0008Pm-BV; Mon, 07 Jan 2019 08:51:12 +0000
Received: by mail-oi1-x242.google.com with SMTP id i6so35237134oia.6;
 Mon, 07 Jan 2019 00:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uLkUJ/jQT20r97kkh5KC+O126E2HctWoslGRzVy4yDk=;
 b=CX/HLUl3wl2NivwD29cMoT1PZ2jGokD8piMg4yBTA/lntVFgiI/HZQpDMz7IxDRx/z
 kdEc7l+//xTEejGeg1OQQRJJAbwAzD6t4vxEnSP9+tm1V6X8AZHLtFibBmX3uCBy6atj
 NVZHjOayB671Mls4YN8ci+KPbyA0Azh8nUELbBCDB5KwsGS0nTYxkJIbLfyufe/K6CLy
 EhSl+S92TXiUq7VZXGetAUo1WNPvXtqHf8eUMyhun4nMVJ1NL/L5+ZPJDdjO4GarHNUC
 Iyldp2iZC7ja1JJFMnUc04KTCxa5er7lF3mnY/mpPEUkNglfbZ3D6NqVOUyvp0EPKUk2
 f2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uLkUJ/jQT20r97kkh5KC+O126E2HctWoslGRzVy4yDk=;
 b=IG3QeqWCyDN2uO43Sh0mspYJNv90/2xHC9+nTfGzNUWGmxHHiFEjxlfQ5PKkFHN7DZ
 dBReGZE/FLoMS2fKIFpAXqa8bdP9dmwqDvWz0fYs16/krAWgzMzFuz41hh/H0tmaS9V0
 AhL6u61GGTqB8jJGvivxuedKLbid0ai2XK4TTre/hlOGUwxCZbRmk4wjfO6tT4R68Rzr
 NESpB/rN0VYlBw5dMv1oozUe4MbVnFac9AKFBtIz6r0Vxv2AyvJXg/4itcPXgb3hJOB0
 wcblcwqQO7+l93q1OgNtSTt+ArcXSE1uUkFyFMJsGlbJ4tIY8hvOZk0XmuqUxrsggulh
 XWjQ==
X-Gm-Message-State: AJcUukc7k/jq9VXfkAJEW4SKctRadj5eFNOaTj1X/A6pN17ocEgVcJuh
 GWR0gNZcQ049SWyUAnhbPfS4/6Q4Zj08ugZXjsk=
X-Google-Smtp-Source: ALg8bN4NLaA58IS0fvAgCKx3JFYLrH2SkYBDfyBYb4VBBoUIh+dCDZ884Z+nOWvJkU3EpICjjnCONB/Lc88yVJ+oy68=
X-Received: by 2002:aca:3fc6:: with SMTP id m189mr7750837oia.142.1546851070063; 
 Mon, 07 Jan 2019 00:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <20181229125711.5205-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181229125711.5205-2-martin.blumenstingl@googlemail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 7 Jan 2019 14:21:01 +0530
Message-ID: <CANAwSgQjoXqbV2hDs4W3kR=7ULK0gkR24V6SiEJw2+mYsaNcVQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: meson8b: odroidc1: mark the SD card
 detection GPIO active-low
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_005111_393055_223BEF3C 
X-CRM114-Status: GOOD (  18.23  )
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
Cc: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-gpio@vger.kernel.org, balbes-150@yandex.ru,
 Kevin Hilman <khilman@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mmc@vger.kernel.org, bgolaszewski@baylibre.com,
 Guenter Roeck <linux@roeck-us.net>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Martin,

On Sat, 29 Dec 2018 at 18:28, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> tree") SD cards are not detected anymore.
>
> The CD GPIO is "active low" on Odroid-C1. The MMC dt-bindings specify:
> "[...] using the "cd-inverted" property means, that the CD line is active
> high, i.e. it is high, when a card is inserted".
>
> Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
> drop the "cd-inverted" property. This makes the definition consistent
> with the existing dt-bindings and fixes the check whether an SD card is
> inserted.
>
> Fixes: e03efbce6bebf5 ("ARM: dts: meson8b-odroidc1: add microSD support")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index 58669abda259..070d69889f3e 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -273,8 +273,7 @@
>                 cap-sd-highspeed;
>                 disable-wp;
>
> -               cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> -               cd-inverted;
> +               cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>
>                 vmmc-supply = <&tflash_vdd>;
>                 vqmmc-supply = <&tf_io>;
> --
> 2.20.1
>

Please add my on my Odroid c1+

Tested-by: Anand Moon <linux.amoon@gmail.com>

My Odroid C2 is also fails to bootup with out these changes.
Can you send patch to fix them as well.

Best Regards

-Anand

>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
