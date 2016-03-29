From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Mar 2016 14:00:18 -0700
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <7339827.UeYZLZET5g@wuerfel>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <21028994.N5ajfyoUoV@wuerfel> <20160329195230.GK2350@sirena.org.uk>
 <7339827.UeYZLZET5g@wuerfel>
Message-ID: <20160329210018.GL2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 10:04:59PM +0200, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 12:52:30 Mark Brown wrote:

> > Well, we currently don't have any XIP or whatever support at all, it's
> > still only in the SPI operations so it's academic - that'd be a future
> > issue if we did start doing things that accessed the memory map outside
> > of the SPI flow.

> Isn't this just about implementing .point()/.unpoint() in the spi-nor
> driver?

Implementing that would require the SPI core to export something
providing access to the memory regions.  We don't currently do that,
it'd require us to deal with the interaction with access as a SPI device
(this hardware often seems to only accelerate reads so we still need to
use regular SPI access for writes).

> > For me the simplest thing seems like just using one window for all the
> > devices, it seems more likely to deliver useful results without the
> > system integrator having to think about how to configure this for
> > optimisation.

> Do you mean single-window mode? I don't see the difference to the other
> modes, but that's certainly fine with me if it helps.

I don't like having to assign windows per device, like I say it seems
like more work.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/a5f0c702/attachment-0001.sig>
