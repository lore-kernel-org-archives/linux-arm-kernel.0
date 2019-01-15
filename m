Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99730C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:33:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F9720656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W5Uu2GkB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wEBLWGzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F9720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D0npdj6OK27FYGUqa1H6QcPn882cXLNSW3Q1qNc9m3M=; b=W5Uu2GkBwTFNE0
	rueCBBQSdnK+tkf3hqprpI62j+J9WI5hAXpA+4ZJhvJq6mCnMauZ+Wpezq7xexODQ3WjIFuOhtcXZ
	USio8O+aDsGV42TzeOUQWzEwoq84xbGKsF3S3SucoCZiXVvWOS40+oWa3keCbfIBmvf8Lwf63baLU
	kIqk5s5HxXy9Cdpbi177E9A2pwH8w0Kub7EwZw6PXIK1ZcSa2KrXOYHLZot7w7XMIDzBK2+uNSbJu
	6TaO0WfuVZr+1oPddc86jL2TNUuX65cKH2lIUd6k5LM9lPo5HkTpdQzx9D5Ab+qlwJK9A4zBVOfot
	eEKIFTZb1fsX4OFhtg6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjSaJ-0003uZ-5W; Tue, 15 Jan 2019 17:33:07 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjSaE-0003u6-Te
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 17:33:05 +0000
Received: by mail-pf1-x444.google.com with SMTP id 64so1621911pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=4U0OvVrkxFBjSA8W5Lm7VS40KUbUjrzMUZQnvA9o4pU=;
 b=wEBLWGzTNbnLT0SQ7XjOWnMPDC05vGd2UjO5hbTWczX2JqnycaJr3E3fby9boGD03w
 XZVOafE9R6nzFek66oe3FzBqsJbexwLYn54wZXtBViHA1LRKQUvkaAWP588kFIlj0VB8
 yp2r9asYVbCYlLa/MMpjJjcVudk+HVk4YFs/U+7ASP3pUnLU+VqWAZRgxKwQgnO4aUy8
 DPye/+VuPF4PgXiOuvLVxsGYcUt+DtGaRniJHChff8oSt/odNozH9TxF2rTKSiOMTpTJ
 Veqv7S0wYlFZ/gMvR8tLvbqnNoEoE8pM+To0zH5soTftlKn6O6/AJE9DbBS6gu/JaEG7
 ivYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=4U0OvVrkxFBjSA8W5Lm7VS40KUbUjrzMUZQnvA9o4pU=;
 b=DR22c0cp4kySSmtDuN0aIk4sC7hxTZCDeI6kE9Qoan1CN+UqC094dKT0RGlOy10lrX
 uIv3TNvrD4YZqejzstC2PBjE4jGLEW1zrNRP5+z3GAr0D5ktgc/6tyA0ar6+94JmOZEl
 2yOm1iZnR0bGJj+yzaxZmw2ZO1t2EdgCjnHo0lwvcoQFWEZnIjzXtKzvoJjrCTUv2NTW
 arZxZUgCdREEzJoQvD0X+o9BUrRPvN/TtwpVbo0eAzMyykUL0eJ9hoFXvNKujUHpbR4a
 Tw67poDMBt6FuAr6lKBOhWDikvFgK5ubLx6PwClN1pNHjKBrA5lnMJc57pM7BNelTQyn
 nFCg==
X-Gm-Message-State: AJcUukf5JIdGdjF0T1CKLcyjzuWjT/62V+4ap8H3jhd8IC535jbhrOO6
 n3HjZ5RpB0o0kESeOHW3RW//zQ==
X-Google-Smtp-Source: ALg8bN6/M5WBB7GNfbjGqgI0MPWGrQajvmlUJTF9TSvVrP8AubuQo8DgeGH/g/OOzA6lHafWFLD9Kg==
X-Received: by 2002:a63:c42:: with SMTP id 2mr4795113pgm.372.1547573581531;
 Tue, 15 Jan 2019 09:33:01 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:5cbd:8bed:2b0a:a142])
 by smtp.googlemail.com with ESMTPSA id w3sm4462914pge.8.2019.01.15.09.33.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 09:33:00 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 "kernelci.org bot" <bot@kernelci.org>,
 Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: broonie-regulator/for-next boot bisection:
 v5.0-rc2-20-g61b67608c6b9 on meson-gxl-s905x-libretech-cc
In-Reply-To: <CACRpkdY5ipcZqujGXJN9hcNYA+3WvknaQH0syYDb3YrrrgkgCg@mail.gmail.com>
References: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com>
 <CACRpkdY5ipcZqujGXJN9hcNYA+3WvknaQH0syYDb3YrrrgkgCg@mail.gmail.com>
Date: Tue, 15 Jan 2019 09:33:00 -0800
Message-ID: <7ha7k1ker7.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_093303_006028_13CE74E1 
X-CRM114-Status: GOOD (  18.10  )
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
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, guillaume.tucker@collabora.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>,
 Philipp Zabel <philipp.zabel@gmail.com>,
 Paul Parsons <lost.distance@yahoo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> Thanks for this pretty impressive automated report!
>
> Maybe it will be hard to ask a robot to test changes! :D
>
> On Mon, Jan 14, 2019 at 11:04 PM kernelci.org bot <bot@kernelci.org> wrote:
>
>>   Target:     meson-gxl-s905x-libretech-cc
>
> I hope there is someone else with this board on CC since I don't
> know how to ask the robot to test patches.
>
> The log from the robot isn't super helpful as it does not have
> earlyprintk enabled and boot hangs before it gets to that (!)
> so no console messages.
>
> So I suppose this is:
> arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> a pure device tree plattform which was added by Neil, so I hope
> he can test patches.
>
> And that has only one GPIO regulator, this one:
>
>         vcc_card: regulator-vcc-card {
>                 compatible = "regulator-gpio";
>
>                 regulator-name = "VCC_CARD";
>                 regulator-min-microvolt = <1800000>;
>                 regulator-max-microvolt = <3300000>;
>
>                 gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
>                 gpios-states = <0>;
>
>                 states = <3300000 0>,
>                          <1800000 1>;
>
>                 regulator-settling-time-up-us = <200>;
>                 regulator-settling-time-down-us = <50000>;
>         };
>
> Meaning this is 3.3 V when that GPIO line is low, and 1.8V when that
> line is high, correct?
>
> That controls the VCC. This surely wouldn't block the boot process.
> So my code must be crashing completely. OK I will look closer at it
> and try to create a mock system of some sort.

Both Neil and I have access to this board, so we can test any fixes for
you.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
