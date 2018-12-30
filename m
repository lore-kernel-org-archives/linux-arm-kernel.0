Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E57DC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:55:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF82320836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VExsLqhk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jljtcpvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF82320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lOJib/zapVQeyHQUncff51QtP/Lome3pyzPWERCcP2Q=; b=VExsLqhkhEK1vh
	nCpOjGnuDwYwP9ZAB/SaZWAoCQnDpXLyARTv6WWaTbRlyEWE4z98KdtQTVU7WSR+L6pIi9ZFeD4cA
	8NThSgsM2O77HgXSU3/COsi0Ws4w+6ZvhtRMl614IWrFwhWg4bFfVe2hKyGmWQtLlAiOeiV7Dd+I9
	iO/bCWivVSGQuy6XzzrgE4b76p8NaUaLo8Y6fB/js0mBVz1pvmZ5gH5w1+KREFPoUtf/d7IUHj4Ba
	irlL1Kce/kKQ08NSYiCVMlLNHxckHvyNGPUs5PJvoDRhDaX+7daohi1Q/lDgTW9R8LLmkBPCFLkqS
	DnN26qb1O9l+xTIlNGfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdhAq-0007T3-Kx; Sun, 30 Dec 2018 19:55:00 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdhAl-0007MF-3i
 for linux-arm-kernel@lists.infradead.org; Sun, 30 Dec 2018 19:54:58 +0000
Received: by mail-lj1-x244.google.com with SMTP id g11-v6so22473620ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 30 Dec 2018 11:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aYtSk6UmrVbeFiJrPCWrDNJtF//zE/XhWTWZsfzZlr0=;
 b=JljtcpvvjvfZsyE41qtX+X1tW/+yg99c4/1+k84FYtW9k7CskCsttxkAjewQKzhwg3
 76je7ajEx5nc1J2d/WTVnZkuHRQICDO0Yzrd8D1mqevOpSAhpj03OrwwRiksZeryK6vc
 AyWwTLAJowftNyr1BxoGbNQt3nzuPyOXE1mic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aYtSk6UmrVbeFiJrPCWrDNJtF//zE/XhWTWZsfzZlr0=;
 b=tWSMJ96Ydu8hotX+1os4TbwmFHCGThHtuBJDeOaNLyltHf7UCLJfFKzC5uFLHzou6+
 WaTPaWS2YHenBx9eDq2MoUDBowCCv5JeaI9bS2Sm6/AytAE7rzlzn+NxWsEHNmtOO5Hi
 1ESpYEIfOWRLdBROcVeS62ZTBkbTc/d8c7/Kak7kzYjMx87lZiMVry5lMV1lVmlR9EwM
 vEl7wk+CdhbZ5xszHS0ZTEVB1jRQKT8QSpra8G+JOikEx6OjACLaQR8VzZ1ZpFS0GNHD
 xfiqjDYy1IUKz9NjxMlKGXSrQzvclGuU4bBdUguS9BD6duVuBUYu84NULehxPqCthA3L
 1lhQ==
X-Gm-Message-State: AJcUukfA9eUGji5+YXvzYtKny5sa2ZlZR94AwxF5zBC1Xhz0FWDPMSJa
 DXDU/c4lgx1nGcUzfTAjVbnvYyJETLD24AP2YpsB8Q==
X-Google-Smtp-Source: ALg8bN5rAd2E7nHQaFoEWAqqQx+/TmpYhhPdSZKd7GYiQQ+ISJS4dPPsG5gktd5lvzYxEjI2VJkCIOPNWb5H2puplv0=
X-Received: by 2002:a2e:7e04:: with SMTP id
 z4-v6mr19207070ljc.97.1546199683181; 
 Sun, 30 Dec 2018 11:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <20181229125711.5205-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181229125711.5205-3-martin.blumenstingl@googlemail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 30 Dec 2018 20:54:31 +0100
Message-ID: <CACRpkdYQLvCEvNaA_O2SP4VXh7Lp7sD31wOBD9ZDoZwx3c+ZuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: meson8b: ec100: mark the SD card detection
 GPIO active-low
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_115455_175349_1979E932 
X-CRM114-Status: GOOD (  12.37  )
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
> The CD GPIO is "active low" on the EC-100. The MMC dt-bindings specify:
> "[...] using the "cd-inverted" property means, that the CD line is active
> high, i.e. it is high, when a card is inserted".
>
> Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
> drop the "cd-inverted" property. This makes the definition consistent
> with the existing dt-bindings and fixes the check whether an SD card is
> inserted.
>
> Fixes: bbedc1f1d90e33 ("ARM: dts: meson8b: Add support for the Endless Mini (EC-100)")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
