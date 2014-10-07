From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 7 Oct 2014 15:03:20 +0200
Subject: [PATCH 1/5] regulator: Add ena_gpio_valid config
In-Reply-To: <20141007115335.GW4609@sirena.org.uk>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-2-git-send-email-mpa@pengutronix.de>
 <20141007115335.GW4609@sirena.org.uk>
Message-ID: <20141007130320.GF5042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 07, 2014 at 12:53:35PM +0100, Mark Brown wrote:
> On Mon, Oct 06, 2014 at 10:17:11PM +0200, Markus Pargmann wrote:
> > Most drivers do not set the ena_gpio field of struct regulator_config
> > before passing it to the regulator core. This is fine as long as the
> > gpio identifier that is passed is a positive integer. But the gpio
> > identifier 0 is also valid. So we are not able to decide wether we got a
> > real gpio identifier or not.
> > 
> > To be able to decide if it is a valid gpio that got passed, this patch
> > adds a ena_gpio_valid field that should be set if ena_gpio is a valid
> > gpio and should be used. It is a preperation patch for multiple patches
> > that adapt the drivers and fix the regulator core checks for this field.
> 
> This should be part of the patch adding meaningful behaviour for the
> flag, it's pointless separately.

I tried to keep the series bisectable while having different patches for
the drivers and the core. By splitting this 'ena_gpio_valid' field into
a seperate patch, the rest of the drivers will still compile and work
until the core condition was changed to ena_gpio_valid.

But I can squash the three patches into one.

Best regards,

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/86058ea8/attachment.sig>
