From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 7 Oct 2014 21:18:19 +0200
Subject: [PATCH 1/5] regulator: Add ena_gpio_valid config
In-Reply-To: <20141007161933.GH4609@sirena.org.uk>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-2-git-send-email-mpa@pengutronix.de>
 <20141007115335.GW4609@sirena.org.uk>
 <20141007130320.GF5042@pengutronix.de>
 <20141007161933.GH4609@sirena.org.uk>
Message-ID: <20141007191819.GI5042@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 05:19:33PM +0100, Mark Brown wrote:
> On Tue, Oct 07, 2014 at 03:03:20PM +0200, Markus Pargmann wrote:
> > On Tue, Oct 07, 2014 at 12:53:35PM +0100, Mark Brown wrote:
> 
> > > This should be part of the patch adding meaningful behaviour for the
> > > flag, it's pointless separately.
> 
> > I tried to keep the series bisectable while having different patches for
> > the drivers and the core. By splitting this 'ena_gpio_valid' field into
> > a seperate patch, the rest of the drivers will still compile and work
> > until the core condition was changed to ena_gpio_valid.
> 
> > But I can squash the three patches into one.
> 
> No, I think this is missing the point a bit - if we need to introduce
> this such that all drivers are instantly buggy without an update that's
> probably an indication that we're introducing compatibility problems.

Yes, it was designed to not be compatible with the old way of setting up
ena_gpio. But I think it shouldn't be a problem to get it backwads
compatible. I will fix the series and send the next version with one
core patch and another one which adds ena_gpio_valid to the drivers.

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/36163524/attachment.sig>
