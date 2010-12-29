From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 29 Dec 2010 00:40:33 -0700
Subject: [PATCHv3 1/4] mc13xxx-core: Consolidate common code to prepare
	for separate i2c and spi
In-Reply-To: <20101220083120.GP1940@pengutronix.de>
References: <1292817055-17715-1-git-send-email-marc@cpdesign.com.au>
	<1292817055-17715-2-git-send-email-marc@cpdesign.com.au>
	<20101220083120.GP1940@pengutronix.de>
Message-ID: <20101229074033.GJ8172@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc and Uwe,

On Mon, Dec 20, 2010 at 09:31:20AM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Dec 20, 2010 at 02:50:52PM +1100, Marc Reilly wrote:
> > This patch moves common mc13xxx definitions to the header file in
> > preparation for separate i2c and spi driver modules.
> > spi specific functions are also removed.
> > 
> > Changes to the mc13xxx struct are:
> > removing the redundant irq member,
> > adding driver read/write function ptrs,
> > adding ictype
> This list isn't complete, but see below.
> 
> I don't like that after this patch the driver isn't functional, because
> you removed the spi functionality which breaks bisection.

Ugh, yes.  Breaking bisection is absolutely a no-no.  I'll wait for
the next version of this series before I do a full review.

> 
> > Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> > ---
> >  drivers/mfd/mc13xxx-core.c  |  207 +++++++-----------------------------------
> >  include/linux/mfd/mc13xxx.h |   77 +++++++++++-----
> >  2 files changed, 87 insertions(+), 197 deletions(-)
> > 
> > diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> > index a2ac2ed..3367a40 100644
> > --- a/drivers/mfd/mc13xxx-core.c
> > +++ b/drivers/mfd/mc13xxx-core.c
> > @@ -9,24 +9,14 @@
> >   * the terms of the GNU General Public License version 2 as published by the
> >   * Free Software Foundation.
> >   */
> > -
> (hmm.  I think there is no style guide for that, but I know people who
> think that this nl should be there.  So IMHO don't touch this.)

A better comment is: don't make unrelated, non-functional whitespace
changes in patches for something else.  They add noise that make it
harder to review.

Cheers,
g.
