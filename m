From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 20:05:53 +0200
Subject: [linux-sunxi] [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
In-Reply-To: <aa2d6072-87a5-cd52-d3a5-17df889e6bc9@arm.com>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
 <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
 <45956397-a593-e51e-8637-655178c5901c@arm.com>
 <20180502093601.fvkacdv62aqxshbr@flea>
 <aa2d6072-87a5-cd52-d3a5-17df889e6bc9@arm.com>
Message-ID: <20180503180553.qjjgnw5jnvtdn46n@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 12:01:53PM +0100, Andre Przywara wrote:
> >>>> It looks like there are more users of those power rails, so we could
> >>>> keep those supplies connected to these fixed regulators here, even with
> >>>> AXP-805 support in the kernel.
> >>>
> >>> It's not a good choice.
> >>>
> >>>>
> >>>> Or we keep this back until we get proper AXP support in the kernel? I
> >>>> guess it's quite close to the existing PMICs, so it might be more a
> >>>> copy&paste exercise to support the AXP-805?
> >>>
> >>> It's not a reason to keep it back.
> >>
> >> So I compared the manuals of the AXP806 and the AXP805, the register
> >> interface looks identical to me. I only have a (somewhat) Chinese
> >> version of the AXP806 manual, so couldn't really find the difference
> >> between the two. Do you know more about it? Is it just maybe the
> >> packaging and the electrical properties (like max current supported)?
> >>
> >> If the I2C register interface is really the same, we could just add the
> >> DT nodes for the regulator and be done.
> > 
> > And that argument is only valid if you 100% trust the fact that both
> > datasheet are complete and accurate.
> > 
> > And experience show that you can't.
> 
> Well, but I wonder how paranoid we are going to be? And in this case we
> have confirmation from Wink that they are the same.

Paranoid enough so that we don't blindly trust that the reviewer had a
coffee, no interruptions or moment of distraction, or that the
datasheet is correct.

But not so paranoid that having the driver running on a kernel is
enough.

> So I think we can go with just a DT addition, given that we test it
> and confirm that it works for our use case. Should we discover
> something odd or undocumented later, I'd consider this a bug fix,
> which we then (and only then!) could fix by adding the compatible
> string to the driver. Any DT would be fine already, because we list
> both compatible strings in there.

In this particular case, yeah, it seems reasonable.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
