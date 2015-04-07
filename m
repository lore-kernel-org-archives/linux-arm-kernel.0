From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Apr 2015 15:11:49 +0200
Subject: [PATCH] pinctrl: fsl: imx: Check for 0 config register
In-Reply-To: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
References: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdYvF_pBwbJeRsSzSkJTajixH9jwUoESMZrr5TFC=qxgiA@mail.gmail.com>
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

Patch applied with the ACKs and all.

Yours,
Linus Walleij
