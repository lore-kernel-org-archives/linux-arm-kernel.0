From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 4 Jul 2018 11:06:50 +0200
Subject: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
Message-ID: <20180704090650.hr3j7a6wn7nwfkvq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 09:16:32AM +0100, Marc Zyngier wrote:
> On 03/07/18 19:42, Samuel Holland wrote:
> > On 07/03/18 10:09, Marc Zyngier wrote:
> >> On 11/05/18 03:27, Samuel Holland wrote:
> >>> Hello,
> >>>
> >>> Several people (including me) have experienced extremely large system
> >>> clock jumps on their A64-based devices, apparently due to the architectural
> >>> timer going backward, which is interpreted by Linux as the timer wrapping
> >>> around after 2^56 cycles.
> >>>
> >>> Investigation led to discovery of some obvious problems with this SoC's 
> >>> architectural timer, and this patch series introduces what I believe is
> >>> the simplest workaround. More details are in the commit message for patch
> >>> 1. Patch 2 simply enables the workaround in the device tree.
> >>
> >> What's the deal with this series? There was a couple of nits to address, and 
> >> I was more or less expecting a v2.
> > 
> > I got reports that people were still occasionally having clock jumps after
> > applying this series, so I wanted to attempt a more complete fix, but I haven't
> > had time to do any deeper investigation. I think this series is still beneficial
> > even if it's not a complete solution, so I'll come back with another patch on
> > top of this if/once I get it fully fixed.
> > 
> > I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
> > timer) ? 150 should be a conservative iteration limit?
> 
> Should be OK.
> 
> Maxime: How do you want to deal with the documentation aspect? We need
> an erratum number, but AFAIU the concept hasn't made it into the silicom
> vendor's brain yet. Any chance you could come up with something that
> uniquely identifies this?

Yeah, I don't know how we can address that unfortunately. Or maybe we
can call it timer-broken-1 ? It's as good as an ID than any other ID :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180704/0afc6017/attachment.sig>
