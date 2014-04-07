From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Apr 2014 15:19:18 +0100
Subject: Porting plat-pxa to the MMP PDMA driver
In-Reply-To: <5342B20C.4070608@zonque.org>
References: <5342A73F.8010907@zonque.org>
 <20140407140256.GA13237@sirena.org.uk>
 <5342B20C.4070608@zonque.org>
Message-ID: <20140407141918.GH14763@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 04:11:24PM +0200, Daniel Mack wrote:
> On 04/07/2014 04:02 PM, Mark Brown wrote:

> > Is it not possible to do what we're doing with the Samsung
> > platforms and have both platform and generic DMA code in the
> > source, selected via a Kconfig symbol?  That way you don't have to
> > have a flag day.

> Not sure whether I'm following, but on PXA, the DMA controller can
> either be used by the old framework or the new driver, and so users
> can't choose which one to use. I thought about a macro hack to make
> the transition easier, but that seems impossible to do.

That's exactly what Samsung have too - an old API and dmaengine as
either/or options.

> Sure, we could keep implementations for both environments around, but
> chances are that we'll never get rid of the old cruft at all then.
> Also, for most drivers that means lots of code duplication.

At least with Samsung the transition has mostly happened, it's been
taking a long time but there's progress and it means that platforms that
are actively being worked on get to use the new stuff.  The code
duplication is a pain point but it's less painful than having to
transition the entire platform at once when it's difficult to get people
to care.  It makes it easier to maintian forward motion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/20c91c88/attachment.sig>
