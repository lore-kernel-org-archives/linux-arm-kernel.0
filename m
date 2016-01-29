From: horms@verge.net.au (Simon Horman)
Date: Fri, 29 Jan 2016 09:35:34 +0900
Subject: [PATCH] ARM: dts: emev2:use GIC_* defines
In-Reply-To: <20160129002609.GB26068@verge.net.au>
References: <1453944594-24757-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVBK1nGiYucbDA8SKTLtVd7yC6v1oq==fnzP9Fq2cWhfw@mail.gmail.com>
 <20160129002609.GB26068@verge.net.au>
Message-ID: <20160129003533.GD26068@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 09:26:10AM +0900, Simon Horman wrote:
> On Thu, Jan 28, 2016 at 09:15:50AM +0100, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Thu, Jan 28, 2016 at 2:29 AM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > Use GIC_* defines for GIC interrupt cells in emev2 device tree.
> > >
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > > Based on renesas-devel-20160127-v4.5-rc1
> > > ---
> > >  arch/arm/boot/dts/emev2.dtsi | 37 +++++++++++++++++++------------------
> > >  1 file changed, 19 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
> > > index 57795da616cb..366e822367c7 100644
> > > --- a/arch/arm/boot/dts/emev2.dtsi
> > > +++ b/arch/arm/boot/dts/emev2.dtsi
> > > @@ -9,6 +9,7 @@
> > >   */
> > >
> > >  #include "skeleton.dtsi"
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > >  #include <dt-bindings/interrupt-controller/irq.h>
> > >
> > >  / {
> > > @@ -53,7 +54,7 @@
> > >
> > >         pmu {
> > >                 compatible = "arm,cortex-a9-pmu";
> > > -               interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
> > > +               interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> > >                              <0 121 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > If you convert the above line, too, you can add my
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks, I have fixed that and queued up the following:
> 
> From: Simon Horman <horms+renesas@verge.net.au>
> Date: Thu, 28 Jan 2016 10:29:54 +0900
> Subject: [PATCH] ARM: dts: emev2:use GIC_* defines

I subsequently corrected the subject so there is a space after "emev2:".
Sorry for letting that get this far.

[snip]
