From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 1 Aug 2016 18:26:03 +0200
Subject: [PATCH v2] mmc: sunxi: Handle the 'New Timings'
In-Reply-To: <20160801153016.GB17146@leverpostej>
References: <E1bUDNG-0000pR-Fv@bombadil.infradead.org>
 <20160801153016.GB17146@leverpostej>
Message-ID: <20160801182603.6f44af17e0bb801353f4b5e0@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Aug 2016 16:30:19 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Aug 01, 2016 at 03:10:29PM +0200, Jean-Francois Moine wrote:
> > Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> > a 'New Timings' mode.
> > Set this capacity in the DT and use it when possible.
> 
> What exactly is this "New Timings" mode?
> 
> Why do we wnat to set it? Improved performance, power?
> 
> Is it *necessary* to use it?

This mode is described at least in the Allwinner's documentation of the
A83T, A64 and H3.
>From my tests, it is required to access the eMMC of the Banana Pi M3
(mmc2).

> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> > I don't know if this mode works or is needed at 25MHz.
> > ---
> >  Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  1 +
> >  drivers/mmc/host/sunxi-mmc.c                        | 21 +++++++++++++++++++--
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > index 4bf41d8..a541bf4 100644
> > --- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> > @@ -19,6 +19,7 @@ Optional properties:
> >   - reset-names : must contain "ahb"
> >   - for cd, bus-width and additional generic mmc parameters
> >     please refer to mmc.txt within this directory
> > + - allwinner,new-timings: the controller may accept the "New Timings" mode
> 
> It's not at all clear to me what this means. This needs a better
> description.
> 
> Which devices have this? Can we determine this based on compatible
> string?

No, only some devices of the SoCs have this capability: the mmc2 of the
A83T, the smhc0 and smhc1 of the A64, and the mmc1 and mmc2 of the H3.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
