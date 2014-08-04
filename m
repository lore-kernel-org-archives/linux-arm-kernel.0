From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Aug 2014 15:25:07 +0100
Subject: [PATCH v2 03/10] mtd: spi-nor: add DDR quad read support
In-Reply-To: <CAMuHMdWxzKG1TTUVgYqfRP0Prp85HPwVxH7NQp7S-pNeLfFqjA@mail.gmail.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-4-git-send-email-b32955@freescale.com>
 <20140730050843.GE11952@brian-ubuntu>
 <20140730064413.GA15547@shldeISGChi005.sh.intel.com>
 <20140730074500.GF11952@brian-ubuntu>
 <20140730104607.GQ17528@sirena.org.uk>
 <20140802020617.GS3711@ld-irv-0074>
 <CAMuHMdWxzKG1TTUVgYqfRP0Prp85HPwVxH7NQp7S-pNeLfFqjA@mail.gmail.com>
Message-ID: <20140804142507.GP30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 02, 2014 at 11:09:09AM +0200, Geert Uytterhoeven wrote:
> On Sat, Aug 2, 2014 at 4:06 AM, Brian Norris
> > On Wed, Jul 30, 2014 at 11:46:07AM +0100, Mark Brown wrote:

> >> I don't know what DDR is in this context, sorry.

> > I think it's just the ability to latch data on both the rising and
> > falling edges of the SPI clock. For SPI flash, it seems to be used for
> > the data portion of the opcode/address/data sequence.

> > Yeah, I suppose it could be wedged in later if drivers/spi/ ever adopts
> > a solution.

> I think this can just be another SPI_* spi_device.mode flag.

Sounds like it yes - I was wondering if this might be one of the modes
with extra clock cycles that I've heard mentioned before which might be
a little more fun.

> Do we need bindings for this in
> Documentation/devicetree/bindings/spi/spi-bus.txt?
> Unlike Quad SPI transfer support, this doesn't need special wiring, so DDR
> capability is an intrinsic property of the SPI slave, and the mode bit can just
> be set in the SPI slave driver, without any DT magic?

Right, unless we run into things like board design issues causing
constraints this is something that can be enabled by the two drivers
without needing DT configuration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/391bf0b7/attachment.sig>
