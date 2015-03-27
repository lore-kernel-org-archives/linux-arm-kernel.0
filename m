From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Mar 2015 11:14:30 +0100
Subject: [PATCH] pinctrl: fsl: imx: Check for 0 config register
In-Reply-To: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
References: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdZgcVe+5_N5oia8UFNxLYQ-au=Sh3Og-iJg9bbuThY-Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 4:26 PM, Markus Pargmann <mpa@pengutronix.de> wrote:

> 0 is used in all pinfunction definitions when a config register is not
> available, for example imx25-pinfunc.h. If a configuration value is used
> for such a pinfunction the driver will always write it to the
> configuration register if it is not -1. For a 0 configuration register
> the configuration value is written to offset 0x0. This can lead to a
> crashing/hanging system without any warning message.
>
> This patch checks for 0 config register and sets the internal value to
> -1. If the configuration value is not NO_PADCTL this leads to an error
> message that applying the configuration failed.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Stefan, Uwe: can you look at this patch.

Yours,
Linus Walleij
