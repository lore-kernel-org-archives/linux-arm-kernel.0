Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49144C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:54:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144382070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0YzvmKt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cWbPIWCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144382070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TwkZSCiGnrOecHGgzQUuwDq/JV0lz43LEmeI/Lmuy6Q=; b=u0YzvmKta7HVHZ
	gJLQ6QUBJUkoScrjHZC4yzl4YJ4Ijra0oGEio/gIOMHJg8JrwX65JB9tz124gMS/G8PXDIhm+HkUS
	3GA6G5BS1A0CS9N1snOcPxJhBDSaJd3jprBC3i5T53fmA/gV3OfwHxCprnb5yRmkeCDW4eA3MZf5y
	7Z+3S0LY0KFjoOZxsmLCp0A8wtXWbTiX4xkFg0XONyEoKeL8VH8Q6XywMM2O4xmhphxFpLMVcmT/B
	jQ+BuTGBHsu/ap8YjBlkI8772k7m0SPI/KVFDniU/NyGW5xtHWkAp+tOl/jrsW5C/vf8Ex32esIOr
	rNL81FoWQwLFDm3/nBGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdhAO-00079m-LX; Sun, 30 Dec 2018 19:54:32 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdhAL-00077v-5A
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 19:54:30 +0000
Received: by mail-lj1-x241.google.com with SMTP id s5-v6so22447327ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 30 Dec 2018 11:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jy4/5yrHPJtEJmXUsMTQxDmn+vHkQZe+Dia4snuwG2w=;
 b=cWbPIWCQ490AX3haqlE0HKdco7UZdUfHipXeAAdGHjQOTIjtDlIwxWJNha7w+cq9ok
 Ui0FafiwutdhPXTd7BBnEbJAqo54w2wHLBaog+8myu1tIkM0ufUFtyxD5OI+deiOwZ4y
 +q1DYWplQzjz3hUYjox6Y0z1bDM3FmRalIeBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jy4/5yrHPJtEJmXUsMTQxDmn+vHkQZe+Dia4snuwG2w=;
 b=pcwVIDyn3H2qzkgS1fG++2NxwXRtPA4G7ReqD+AYZd2jBfuRFdy20YOUwzHGBO3doC
 sHqgCy7rDdh5jaw7IV7kG9x88+5jMdKRB/wHuF+8umWyjM/2uEtloVXXjBL+Gpt64gDf
 qUPCBNp0MFR0+k8/QfK9LbA3UEky48oIkDTUkz4wBsbKtqDJJRg6oTDApFIUmUOAJo+b
 G8iW1iCHFOKY+YZmMqiOoFay87aegpxOaT1u7Yb1+NNNqEJZk2vosnFUR8pQTuCpcEGJ
 38buU8rG4QZ1OAs/ITAreQH8FzXiFVCSBHeQht+MCkLdK8EZh5Ih0mj7446Q6mt9kRxR
 e6RA==
X-Gm-Message-State: AJcUukeDdAT8N5SXBYi7PJ34FBq/5CP2px+uBn4EdbzsuhyWoATSD8nJ
 AEF2RcfThWtMaEyKsmvicMxtI6y7qIc0qZHBmPPFVg==
X-Google-Smtp-Source: ALg8bN5sGcB0WtqdFpe2OtYA8PDjQMDXuOdAa5LhLNkk9SGLDwQ8TVj6mdTIu0NdAMbjBhBsVvVO7CZlR/03qFM5da0=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr20269606ljj.9.1546199654826; 
 Sun, 30 Dec 2018 11:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <20181229125711.5205-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181229125711.5205-2-martin.blumenstingl@googlemail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 30 Dec 2018 20:54:03 +0100
Message-ID: <CACRpkdY89oiTn1XRu5Dx8+HQBcUysVQ=LpjvKA_Mx2hbmGXdiw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: meson8b: odroidc1: mark the SD card
 detection GPIO active-low
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_115429_273604_08FCDC2C 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: linus.luessing@c0d3.blue, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 balbes-150@yandex.ru, Kevin Hilman <khilman@baylibre.com>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Dec 29, 2018 at 1:57 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This is definately a better way to do it (we should insert some text into the
nindings about doing it this way).

We also need to fix it for existing device trees using "cd-inverted"
though.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
