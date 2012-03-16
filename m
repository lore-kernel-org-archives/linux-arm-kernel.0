From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Mar 2012 12:36:35 +0000
Subject: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
In-Reply-To: <CACRpkdbyVXA+GxRtVL+JGPorp0ULJmeUEUZPxVxOT8W1-WmeMw@mail.gmail.com>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <201203152058.31398.arnd@arndb.de>
 <CACRpkdbyVXA+GxRtVL+JGPorp0ULJmeUEUZPxVxOT8W1-WmeMw@mail.gmail.com>
Message-ID: <201203161236.36088.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012, Linus Walleij wrote:
> On Thu, Mar 15, 2012 at 9:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > [Per]
> >> The stedma40 filter function is not really specific for ux500. ux500
> >> use stedma40 but it should be possible to replace this DMA.IP with
> >> some other DMA-controller. This is board specific configuration. You
> >> should not need to change the mmci-driver just because the dma-driver
> >> has changed, right?
> >> Or will the board-configuration now be placed in mmci-ux500?
> >
> > Right, the DMA configuration does not really belong in there, but
> > the voltage setup might (unless we convert that to the regulator
> > setup).
> 
> The voltage to power the card is already using the regulator
> framework with the MMC-specific helpers in the MMCI driver.
> 
> But I guess you're after modelling the levelshifter as a regulator?
> 
> Basically the level shifter is a separate device has two voltage
> inputs A and B (from other regulators) that is controlled by a
> simple GPIO to select voltage A or B to drive the signals to
> the card.
> 
> That could probably be modelled as a regulator with two
> volategs for sure, but then we should maybe create a more
> generic "struct level_shifter_regulator" (or whatever) for the
> concept as a whole.

Ok, thanks for the explanation.

> Let's page Mark about what to do with levelshifters and whether
> they are regulators of sorts in his book.

It does sound appealing, especially because this one could be
done completely generically by defining a regulator that has
a bunch of other regulators as well as a set of gpio lines as
inputs and one output that can be used in other devices. We
would probably only use this one together with device tree then.

	Arnd
