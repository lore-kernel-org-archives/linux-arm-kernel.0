From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 17 Mar 2012 21:26:53 +0000
Subject: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
In-Reply-To: <201203161236.36088.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <201203152058.31398.arnd@arndb.de>
 <CACRpkdbyVXA+GxRtVL+JGPorp0ULJmeUEUZPxVxOT8W1-WmeMw@mail.gmail.com>
 <201203161236.36088.arnd@arndb.de>
Message-ID: <20120317212652.GD3315@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 12:36:35PM +0000, Arnd Bergmann wrote:
> On Friday 16 March 2012, Linus Walleij wrote:
> > On Thu, Mar 15, 2012 at 9:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > But I guess you're after modelling the levelshifter as a regulator?

> > Basically the level shifter is a separate device has two voltage
> > inputs A and B (from other regulators) that is controlled by a
> > simple GPIO to select voltage A or B to drive the signals to
> > the card.

> > That could probably be modelled as a regulator with two
> > volategs for sure, but then we should maybe create a more
> > generic "struct level_shifter_regulator" (or whatever) for the
> > concept as a whole.

> Ok, thanks for the explanation.

I'm not sure I'd bother defining a special regulator type for this if it
is done using regulators - given that it's likely to just be a GPIO
rather than a specific driver I'm not sure it's worth worrying about how
exactly the hardware is implemented.

> > Let's page Mark about what to do with levelshifters and whether
> > they are regulators of sorts in his book.

> It does sound appealing, especially because this one could be
> done completely generically by defining a regulator that has
> a bunch of other regulators as well as a set of gpio lines as
> inputs and one output that can be used in other devices. We
> would probably only use this one together with device tree then.

It seems sensible to me - probably the existing gpio-regulator driver
can do the job, though it's not unreasonable to expect that we'll want
to support switching between variable voltage supplies at some point.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120317/67f5e0c6/attachment.sig>
