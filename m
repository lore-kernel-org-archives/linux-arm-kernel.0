From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Mar 2016 15:24:34 +0700
Subject: [PATCH 2/5] ARM: bcm2835: Replace alt0/i2s_alt[02] with standard
 groups.
In-Reply-To: <1456510756-15337-3-git-send-email-eric@anholt.net>
References: <1456510756-15337-1-git-send-email-eric@anholt.net>
 <1456510756-15337-3-git-send-email-eric@anholt.net>
Message-ID: <CACRpkdYzSt=R7j9GLSY39CsyMKLjqRYnP_31ti5jWiGngJacqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2016 at 1:19 AM, Eric Anholt <eric@anholt.net> wrote:

> Since all of these pins were documented, we can use their names to
> explain what's going on.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

> +       pinctrl-0 = <&i2c0_gpio0
> +                    &i2c1_gpio2
> +                    &gpclk0_gpio4
> +                    &gpclk1_gpio5
> +                    &spi0_gpio7
> +                    &pcm_gpio18
> +                    &pwm0_gpio40
> +                    &pwm1_gpio45
> +                    &gpioout
> +                    &alt3>;

Why are all of these done as hogs instead of being in pinctrl-0
"default" for the device that is using them? i2c1, gpclk0,
etc?

The only reason I see would be if they are unused or something.

Yours,
Linus Walleij
