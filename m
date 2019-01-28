Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB78AC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:07:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC5521736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RNJ9YnFQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wz4ByBeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC5521736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WFrFFHG08VlbrwdrMmOn6+CzLjnkDfKqp0MagfokDRA=; b=RNJ9YnFQIhbPpm
	N38fugWJw9/BtrBJp8siUWcBvSoL2OjaXy05Iav2i9gmtUyb2MTtliJhEY4C2eRt91aUbJqdQ571D
	qhTlO6PUgm7PjP/zawB3FwNuTF3gdtsMfqrNtdnWnv8tN3yiX11wUaQRmP/XMOyK3szrP4rz3YFxm
	MOIYvMl54PY3Yh+4cc3EyxFFS91HOPysl0ALJnJ9MYxYEv8MYm1A47ewoyxKQkbxOc5eKaW6axZKY
	HIEeSlkzNnrHdCvpzRHiDD4zSyOOUi0NndkuVHxP5O6qEvlcQ7GdaglWkQAKECbBgnGvTY5JQgkrC
	xJee2Myj58YuV/VgUHqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2sn-0000dd-48; Mon, 28 Jan 2019 09:07:09 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2sf-0000d5-0s
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:07:06 +0000
Received: by mail-lj1-x241.google.com with SMTP id k19-v6so13499678lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6AE46D6/cCDmDoZh1iJqcDh38UMGe8stZmLa5NdA1E4=;
 b=Wz4ByBeRjmCECsrPXWnZPSS0Q6oxagvLadguqfPp8xUCQa0cv2BAvew5ghTd2w6Dqa
 3msF0IWuFWPPuiOWE5vLLhYxhOJYVO4C44i/FKidvFvobXH0YHtm9mNvtJ4e0+vQpYCU
 nGV9cw/pTVSjWzyFIhQbnYU0aV5ee5FFWYjc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6AE46D6/cCDmDoZh1iJqcDh38UMGe8stZmLa5NdA1E4=;
 b=Th6sczOlHTl6+3LbAVqYFJNEA8NPVICJbJ8zzm5P26p1cnhmpdoIfI+DNkIz6irQPe
 1ydaSr9JAfcF/iz476tQBOUB4simbXyNHK8SLL06MTHkqHaopa4Y370+4f+pXkqjNcHI
 1DHm7pNeLq4ypNJsDUqqb+jFvf2qHBGU9UPnCSRtFAuntWfS7pAXT6B8GW7KI4FmAq3w
 mm04SSM3Vci1iMen7nNE6twlgRO87sZu+bNuf2Lj4icC8BrglJVwD2PUeVoGlrDE5Vxd
 Z8lab5qvEhW7GDKvGsyKoYwfj7PVen2CBItgFZHmauXCFNxQnhfQUGBvvl8VPojYm1IJ
 J8Ig==
X-Gm-Message-State: AJcUukcC6q2io9S9P9zUWBJeI+AZaJnSeyLAi8UMwFCdx8eAZATebUKM
 SyahTtc5imKuWR0BH4KdjIJLkb6qF0E1cdrwkbl5VQ3i
X-Google-Smtp-Source: ALg8bN5Z7Nr9JVeLY4CVp380vYmSkAg/jRgLgaoPXm3xzoyjpD21WTTmtehdsW4txKxVtTcSo2KLUOcW2nC+BO3Qivs=
X-Received: by 2002:a2e:7e04:: with SMTP id
 z4-v6mr17245783ljc.97.1548666418522; 
 Mon, 28 Jan 2019 01:06:58 -0800 (PST)
MIME-Version: 1.0
References: <1548054685-3781-1-git-send-email-stefan.wahren@i2se.com>
 <1548054685-3781-5-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1548054685-3781-5-git-send-email-stefan.wahren@i2se.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Jan 2019 10:06:46 +0100
Message-ID: <CACRpkdb5DjAMRYkT+b0U6HVk7E6ccLT79-LB=QGQWWtE17aPUg@mail.gmail.com>
Subject: Re: [PATCH RFC V2 4/4] gpiolib: Take MUX usage into account
To: Stefan Wahren <stefan.wahren@i2se.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_010701_088088_EDD3D00B 
X-CRM114-Status: GOOD (  25.68  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Eric Anholt <eric@anholt.net>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Stefan!

I like the idea with these patches.

Some thinking aloud below:

On Mon, Jan 21, 2019 at 8:11 AM Stefan Wahren <stefan.wahren@i2se.com> wrote:


> @@ -1075,7 +1075,8 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                     test_bit(FLAG_IS_HOGGED, &desc->flags) ||
>                     test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
>                     test_bit(FLAG_EXPORT, &desc->flags) ||
> -                   test_bit(FLAG_SYSFS, &desc->flags))
> +                   test_bit(FLAG_SYSFS, &desc->flags) ||
> +                   pinctrl_gpio_is_in_use(chip->base + lineinfo.line_offset))

So the idea is that if a line is already in use somehow, we do not
present it to userspace. Fair enough.

> +bool pinctrl_gpio_is_in_use(unsigned gpio)

Please rename it pinctrl_gpio_can_use_line(), as it is more
specific. (Also see below as to why.)

> +{
> +       struct pinctrl_dev *pctldev;
> +       struct pinctrl_gpio_range *range;
> +       bool result;
> +       int pin;
> +
> +       if (pinctrl_get_device_gpio_range(gpio, &pctldev, &range))
> +               return false;

So if this tries to obtain the GPIO range, if the gpio line
is not found in any range, we decide that it is not in use.

Add a comment saying that if we don't find a range, it probably
means we are using a GPIO driver without a backing
pin controller, so we bail out. (Just like the stub does, maybe
add that kind of comment to the stub as well.)

> +       mutex_lock(&pctldev->mutex);
> +
> +       /* Convert to the pin controllers number space */
> +       pin = gpio_to_pin(range, gpio);
> +
> +       result = pinmux_is_in_use(pctldev, pin);

It gets hard to understand the code here, we need to either add
a comment on what's going on or rename that function
(as described below) or both.

> +
> +       mutex_unlock(&pctldev->mutex);
> +
> +       return result;
> +}
> +EXPORT_SYMBOL_GPL(pinctrl_gpio_is_in_use);

(...)

> +bool pinmux_is_in_use(struct pinctrl_dev *pctldev, unsigned pin)

Please name is pinmux_can_be_used_for_gpio() as non-strict
pin controllers allow non-exclusive use and return false,
and that is something GPIO-specific.

I see the idea with the naming, but the fact that this will
return false in some cases where the pin is actually is in
use makes the function name misleading.

Add some kerneldoc above it explaining that this returns true
if the pin is in any kind of use whether by a function or some
GPIO and the controller is strict.

> +{
> +       struct pin_desc *desc = pin_desc_get(pctldev, pin);
> +       const struct pinmux_ops *ops = pctldev->desc->pmxops;
> +
> +       if (!desc) {
> +               dev_err(pctldev->dev,
> +                       "pin %u is not registered so it cannot be requested\n",
> +                       pin);

Is this error message really relevant?

Should be something like "cannot be inspected" but I suspect it
should just silently return false.

> +               return false;
> +       }
> +
> +       if (ops->strict && desc->mux_usecount)
> +               return true;

We return here if the pin is used for some function.

This *could* create a problem for some systems.

In those systems, a pin controller may define a hog in the
device tree like this:

pinctrl@800000 {
                        foo_gpios: foo {
                                bar {
                                        pins = "gpio57";
                                        bias-pull-up;
                                };
                        };
                        pinctrl-names = "default";
                        pinctrl-0 = <&foo_gpios>;
};

This means this controller is not using the fast path with
gpio_owner etc, but instead has created one group per
GPIO pin, which is a common solution.

What the device tree want to do is set this pin up as GPIO,
and apply a pull up, but still expects that pin to be used
from userspace later on. This patch however, would
hide the pin from userspace if the pin controller is strict.

I don't know for sure if this is a real problem, probably not
because such a pin controller should be careful not to
set itself as strict. (That would strictly speaking be a bug IMO, they
are already hogging the line mux and thus the pin controller
itself IS using it, so....) But if someone is using this approach
today it would cause a regression.

But I think we are safe.

> +       return ops->strict && !!desc->gpio_owner;

This catches the case for gpio controllers using the
fast path to access GPIOs very nicely, i.e. controllers
implementing .gpio_request_enable() etc in their
struct pinmux_ops.

Add a comment saying that all non-strict controllers
will return false here thus making all pins in a GPIO range
available for use.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
