From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Jan 2013 15:54:42 +0000
Subject: [PATCH] mfd: vexpress: Add pseudo-GPIO based LEDs
In-Reply-To: <20130130154923.GE1174@sortiz-mobl>
References: <1359541996-18127-1-git-send-email-pawel.moll@arm.com>
 <20130130154923.GE1174@sortiz-mobl>
Message-ID: <1359561282.3094.15.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-30 at 15:49 +0000, Samuel Ortiz wrote:
> On Wed, Jan 30, 2013 at 10:33:16AM +0000, Pawel Moll wrote:
> > The LEDs on the Versatile Express motherboard are controlled
> > through simple memory-mapped register. This patch extends
> > the pseudo-GPIO controller definition for these lines and
> > creates generic "leds-gpio" device using them
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> > 
> > Hello Samuel,
> > 
> > Would you be so kind to take this patch in for 3.9? Or would
> > you prefer to get it in through arm-soc tree?
> I'll take it through my MFD tree.

Great, thanks!

> 
> >  drivers/mfd/vexpress-sysreg.c |   73 +++++++++++++++++++++++++++++++----------
> >  include/linux/vexpress.h      |    8 +++++
> Hmmm, there is a include/linux/mfd/ directory for kernel MFD drivers, FYI.

Sure, it's just that this header "serves" whole platform, not only the
mfd drivers (eg. there are power-related declarations there as well). If
one day it gets divided, I'll make sure that the MFD portions will find
its way into ../mfd/.

Cheers!

Pawel
