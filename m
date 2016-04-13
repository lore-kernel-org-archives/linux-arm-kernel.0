From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Apr 2016 15:19:01 +0200
Subject: [PATCH RESEND 1/2] pinctrl: ns2: add pinmux driver support for
 Broadcom NS2 SoC
In-Reply-To: <1459264932-27884-2-git-send-email-yendapally.reddy@broadcom.com>
References: <1459264932-27884-1-git-send-email-yendapally.reddy@broadcom.com>
 <1459264932-27884-2-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <CACRpkdY8R91_j4+A_CFzrZdp1zj10SBthL2yyoSxUDJnVBs8NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 5:22 PM, Yendapally Reddy Dhananjaya Reddy
<yendapally.reddy@broadcom.com> wrote:

> This adds the initial support of the Broadcom NS2 pinmux driver
>
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>

Sorry for slow replies. :(

This mostly looks good. Some small things needs fixing:

> +config PINCTRL_NS2_MUX
> +       bool "Broadcom Northstar2 pinmux driver"

This is a bool driver, yet it uses MODULE* macros at the end of the file.
Check the recent commits from Paul Gortmaker cleaning this up.
Just a git log -p --author=Gortmaker in the main kernel tree will quickly
give you an idea of what you have to do.


> +static const unsigned int gpio_0_1_pins[] = {24, 25};
> +static const unsigned int pwm_0_pins[] = {24};
> +static const unsigned int pwm_1_pins[] = {25};

So either the same pins are used for GPIO or PWM.
And this pattern persists.

Do you have a brewing GPIO driver for this block as well?
Is it a separate front-end calling to pinctrl using the
pinctrl_gpio_* calls or do you plan to patch it into this
driver?

This is more of a question.

Apart from this it looks good.

Yours,
Linus Walleij
