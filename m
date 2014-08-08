From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Aug 2014 15:14:44 +0200
Subject: [PATCH 4/4] gpio: pca953x: Add DT binding for reset gpio
In-Reply-To: <1406618686-22385-5-git-send-email-mpa@pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
 <1406618686-22385-5-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkdY0TqVH1tJR1H89S5hvdJUboQdVtNvZnL3NeWit4f+amw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 9:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:

> The pca953x has a negated reset input. This patch adds a DT binding for
> the reset gpio and resets the chip when it is probed. This will reset
> the device and leave the gpio in the correct state so reset is not
> triggered.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Why on earth should this be in the GPIO driver?

The driver should be in drivers/reset/reset-gpio.c and you
should provide a separate driver for it.

As it happens, Houcheng Lin has already proposed such a
driver:
http://marc.info/?l=linux-kernel&m=140309916607115&w=2

Please coordinate with Houcheng and use his driver for what
you want to achieve.

Yours,
Linus Walleij
