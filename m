Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:54:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741CC20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sZ2qnkVD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OySq//We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741CC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZHDvbt6kfCaL+rbt08auBWpAny2Id+H+52Nj/hYNsek=; b=sZ2qnkVD14I77f
	WvKMOP2lmKsSU8sEEKRgctDuSS1FI/vWQ9h0ZP/GZ0w5B2uM6zThY/1jlCOrTB56JJKLSk8CJhVBF
	A9KBWFv5BFa2Hgz/xOP+3FZ1cXERwBgbM1y0kA4ZmdT7rj+9Hs8d9f4xMU4zbhSCOgVMq/8U13G/v
	Dk/A0jObluGjVvajQeUladL6V7E1KVPJI21T0bumgdDzPYB5JSYcScxBpFlxwXXrcEjX4AKcLCWSj
	BV8yAfPGsjfG0ByrmU5JDF2LRjx0PSXIJlU9i49H0WnktreNnhhuXd50zQa3HM8uMJxsKKvc+PDib
	LsCHdIKiJJZLI3IAnzWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjOEO-0004ys-9e; Tue, 15 Jan 2019 12:54:12 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjOEH-0004yX-6r
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 12:54:06 +0000
Received: by mail-lf1-x132.google.com with SMTP id p6so1977641lfc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 04:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C3HLSwkiKa59wFB4FckuMcj1IpI//0uh6c763fmVa98=;
 b=OySq//WewiKOWOlkpKnUSOvtv6pBGpjDlYxQCj3kkHQHGf+c1Zu0XVqW3DUTdGBLFo
 vDm5yFKdyiIeiWYschEEpCKRLs36zqwjHknAXhiqQHwxqFwPOaxUPYNEkUUj4GvoOBNS
 VdZWdzSkmNISQvEK6vgPx8TsPpKdv6CgYPLY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C3HLSwkiKa59wFB4FckuMcj1IpI//0uh6c763fmVa98=;
 b=nPgBrsLgtK1btyqW8uvNSTfL0+R8h6wOyfjMQJy3lpbxR0jjlBlY4mo0eFgNrhnarK
 iSR4Was8eoLmfixS6ro0hiehsKqg1/ERu4yW1o9p+ePxeQc+ri+K70izEwb4EUU9khLz
 nqx0RPpG6ydBtoEG6q1S4adcfUbI2tEqgC4WzQUP2IJc6ezp5GZ4Q6bZqqOf0fj/9C/K
 AabR6b51WjRDLschnSdYvqC2t9S9/KD3POye5qY5I3j7cVl3FxtEJxfzno7exNeKxgHb
 PepkgZWbG44wDR07IZitQaZGpsBdRuP+ro9BVB1+/oVULCQvjm6nMWxjs95hVattNIV8
 IXOA==
X-Gm-Message-State: AJcUukfnqxJZgPimXlvLXH7huWeEckQK9+rSLEJldDAphrI1YtdKwn9s
 1+NnjvJPgk7JOWwyU6etsNX/ZHp/dNFIGvQk+QkYgg==
X-Google-Smtp-Source: ALg8bN4F0pTxOXgSrWK6OtOouC7GP5NYLZvHsaYvJO9cqEYaHzX2930vqJNAd+LagxXlEacf39b0QrIs49PzCOIBPDU=
X-Received: by 2002:a19:5154:: with SMTP id f81mr2854868lfb.96.1547556843081; 
 Tue, 15 Jan 2019 04:54:03 -0800 (PST)
MIME-Version: 1.0
References: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com>
In-Reply-To: <5c3d0781.1c69fb81.8f009.0d7e@mx.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Jan 2019 13:53:51 +0100
Message-ID: <CACRpkdY5ipcZqujGXJN9hcNYA+3WvknaQH0syYDb3YrrrgkgCg@mail.gmail.com>
Subject: Re: broonie-regulator/for-next boot bisection:
 v5.0-rc2-20-g61b67608c6b9 on meson-gxl-s905x-libretech-cc
To: "kernelci.org bot" <bot@kernelci.org>,
 Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_045405_257318_39E352C3 
X-CRM114-Status: GOOD (  12.29  )
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
 Paul Parsons <lost.distance@yahoo.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>,
 Philipp Zabel <philipp.zabel@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Thanks for this pretty impressive automated report!

Maybe it will be hard to ask a robot to test changes! :D

On Mon, Jan 14, 2019 at 11:04 PM kernelci.org bot <bot@kernelci.org> wrote:

>   Target:     meson-gxl-s905x-libretech-cc

I hope there is someone else with this board on CC since I don't
know how to ask the robot to test patches.

The log from the robot isn't super helpful as it does not have
earlyprintk enabled and boot hangs before it gets to that (!)
so no console messages.

So I suppose this is:
arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
a pure device tree plattform which was added by Neil, so I hope
he can test patches.

And that has only one GPIO regulator, this one:

        vcc_card: regulator-vcc-card {
                compatible = "regulator-gpio";

                regulator-name = "VCC_CARD";
                regulator-min-microvolt = <1800000>;
                regulator-max-microvolt = <3300000>;

                gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
                gpios-states = <0>;

                states = <3300000 0>,
                         <1800000 1>;

                regulator-settling-time-up-us = <200>;
                regulator-settling-time-down-us = <50000>;
        };

Meaning this is 3.3 V when that GPIO line is low, and 1.8V when that
line is high, correct?

That controls the VCC. This surely wouldn't block the boot process.
So my code must be crashing completely. OK I will look closer at it
and try to create a mock system of some sort.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
