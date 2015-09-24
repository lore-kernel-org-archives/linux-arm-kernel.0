From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 24 Sep 2015 09:23:40 +0200
Subject: [PATCH v3 7/9] gpiolib-sysfs: Add gpio name parsing for sysfs
 export
In-Reply-To: <CACRpkdYb3i-Bb75bn--r2ack_wiSMFFq1msFkxx5o4UVht6WWw@mail.gmail.com>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-8-git-send-email-mpa@pengutronix.de>
 <CACRpkdYb3i-Bb75bn--r2ack_wiSMFFq1msFkxx5o4UVht6WWw@mail.gmail.com>
Message-ID: <20150924072340.GX32203@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 06:09:15PM -0700, Linus Walleij wrote:
> On Fri, Aug 14, 2015 at 7:11 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> This has too terse commit description. I don't understand the patch or
> what it is supposed to do.

Sorry, indeed, this requires a commit description. I would add something
like this:

In '/sys/class/gpio/' GPIOs can be exported by using their GPIO number.
If the exported GPIO has a name, it will show up as a new directory in
'/sys/class/gpio/<GPIO_NAME>'. It is somehow inconsistent to use a
number for exporting and the name for accessing the GPIO.

This patch adds the possibility to use the GPIO name to export it. This
introduces a consistent behaviour for exporting and accessing a GPIO
from userspace.

The mechanism of parsing the GPIO name is a fallback mechanism. This
ensures backwards compatibility of the gpio interface. If the string
passed to '/sys/class/gpio/export' can not be parsed as number, it tries
to match a GPIO name. The same behaviour is implemented for the
'unexport' file.

The implementation uses the previously defined gpio_name_to_desc().



Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/591166c9/attachment-0001.sig>
