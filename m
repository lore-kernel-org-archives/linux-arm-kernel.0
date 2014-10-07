From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Oct 2014 17:19:33 +0100
Subject: [PATCH 1/5] regulator: Add ena_gpio_valid config
In-Reply-To: <20141007130320.GF5042@pengutronix.de>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-2-git-send-email-mpa@pengutronix.de>
 <20141007115335.GW4609@sirena.org.uk>
 <20141007130320.GF5042@pengutronix.de>
Message-ID: <20141007161933.GH4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 03:03:20PM +0200, Markus Pargmann wrote:
> On Tue, Oct 07, 2014 at 12:53:35PM +0100, Mark Brown wrote:

> > This should be part of the patch adding meaningful behaviour for the
> > flag, it's pointless separately.

> I tried to keep the series bisectable while having different patches for
> the drivers and the core. By splitting this 'ena_gpio_valid' field into
> a seperate patch, the rest of the drivers will still compile and work
> until the core condition was changed to ena_gpio_valid.

> But I can squash the three patches into one.

No, I think this is missing the point a bit - if we need to introduce
this such that all drivers are instantly buggy without an update that's
probably an indication that we're introducing compatibility problems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/2dcfa233/attachment.sig>
