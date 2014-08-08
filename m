From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 08 Aug 2014 16:11:34 +0200
Subject: [PATCH 4/4] gpio: pca953x: Add DT binding for reset gpio
In-Reply-To: <CACRpkdY0TqVH1tJR1H89S5hvdJUboQdVtNvZnL3NeWit4f+amw@mail.gmail.com>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
 <1406618686-22385-5-git-send-email-mpa@pengutronix.de>
 <CACRpkdY0TqVH1tJR1H89S5hvdJUboQdVtNvZnL3NeWit4f+amw@mail.gmail.com>
Message-ID: <1407507094.3354.11.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 08.08.2014, 15:14 +0200 schrieb Linus Walleij:
> On Tue, Jul 29, 2014 at 9:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > The pca953x has a negated reset input. This patch adds a DT binding for
> > the reset gpio and resets the chip when it is probed. This will reset
> > the device and leave the gpio in the correct state so reset is not
> > triggered.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> Why on earth should this be in the GPIO driver?
>
> The driver should be in drivers/reset/reset-gpio.c and you
> should provide a separate driver for it.

I still think we should keep using the reset-gpios binding for simple
cases like this; I see no reason to add a separate device to the device
tree for a single GPIO.

> As it happens, Houcheng Lin has already proposed such a
> driver:
> http://marc.info/?l=linux-kernel&m=140309916607115&w=2

That is a different issue, as there the device does not appear on the
bus until the reset is released.

Here the I2C device will be probed from the device tree, so the reset
can be released or triggered from the probe function.

regards
Philipp
