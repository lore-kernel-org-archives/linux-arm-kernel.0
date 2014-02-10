From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Feb 2014 12:09:29 +0100
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <20140210104032.GB20143@ulmo.nvidia.com>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <20140210104032.GB20143@ulmo.nvidia.com>
Message-ID: <CACRpkdb1T1GCqEpy9=fPp4hYQErLYiQqJezrFhoS3x1MU=0S9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:40 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> it seems like at least BACKLIGHT_LP8788 is missing a corresponding
> dependency as well.
>
> I have applied Sascha's patch to remove the obsolete HAVE_PWM symbol,
> and this will fix at least the build issues. However it will also cause
> the driver to fail at runtime because the pwm_*() functions won't work.

So it definately needs that API, not just stubs.

But isn't it proper for Kconfig to allow you to break things
like that by configuring out stuff and have stubs come in?

I'm a bit torn here.

Yours,
Linus Walleij
