From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Jan 2015 08:57:30 +0100
Subject: [PATCH 1/5] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <1417826408-1600-2-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1417826408-1600-1-git-send-email-rjui@broadcom.com>
 <1417826408-1600-2-git-send-email-rjui@broadcom.com>
Message-ID: <CACRpkdaTU_efMOpKoEdBA0rDHyn6wcn7VamUZRiX-K2MYZygBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 6, 2014 at 1:40 AM, Ray Jui <rjui@broadcom.com> wrote:

> Document the GPIO device tree binding for Broadcom Cygnus SoC
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
(...)
> +- #gpio-cells:
> +    Must be two. The first cell is the GPIO pin number (within the
> +controller's domain) and the second cell is used for the following:
> +    bit[0]: polarity (0 for normal and 1 for inverted)
> +    bit[18:16]: internal pull up/down: 0 - pull up/down disabled
> +                                       1 - pull up enabled
> +                                       2 - pull down enabled
> +    bit[22:20]: drive strength: 0 - 2 mA
> +                                1 - 4 mA
> +                                2 - 6 mA
> +                                3 - 8 mA
> +                                4 - 10 mA
> +                                5 - 12 mA
> +                                6 - 14 mA
> +                                7 - 16 mA

No. This pull up/down and drive strength is pin controller
business, use a pin control backend behind the GPIO driver
see Documentation/pinctrl.txt.

Initial states for these configurations can be set up using
pin control hogs since pin control and GPIO is orthogonal.

Yours,
Linus Walleij
