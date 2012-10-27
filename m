From: michal.simek@xilinx.com (Michal Simek)
Date: Sat, 27 Oct 2012 14:06:45 +0000
Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
In-Reply-To: <20121027140053.GB5190@beefymiracle.amer.corp.natinst.com>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200310.GB6713@beefymiracle.amer.corp.natinst.com>
 <0d1c4cf8-70d8-4d12-bd77-393009d32b22@CH1EHSMHS001.ehs.local>
 <20121027140053.GB5190@beefymiracle.amer.corp.natinst.com>
Message-ID: <4fd22fac-49c4-4000-9e70-12e94f248753@AM1EHSMHS010.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh

> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Saturday, October 27, 2012 4:01 PM
> To: Michal Simek
> Cc: arm at kernel.org; Arnd Bergmann; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; John Linn; Nick Bowler
> Subject: Re: [PATCH v4 1/5] zynq: use GIC device tree bindings
> 
> On Sat, Oct 27, 2012 at 01:39:00PM +0000, Michal Simek wrote:
> > Hi Josh,
> >
> > > -----Original Message-----
> > > From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> > > Sent: Wednesday, October 24, 2012 10:03 PM
> > > To: arm at kernel.org; Arnd Bergmann
> > > Cc: linux-kernel at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org; John Linn; Nick Bowler; Michal
> > > Simek
> > > Subject: [PATCH v4 1/5] zynq: use GIC device tree bindings
> > >
> > > The Zynq uses the cortex-a9-gic.  This eliminates the need to
> > > hardcode register addresses.
> > >
> > > Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> > > Cc: John Linn <john.linn@xilinx.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/arm/boot/dts/zynq-ep107.dts           | 8 +++++---
> > >  arch/arm/mach-zynq/common.c                | 7 ++++++-
> > >  arch/arm/mach-zynq/include/mach/zynq_soc.h | 2 --
> > >  3 files changed, 11 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/zynq-ep107.dts
> > > b/arch/arm/boot/dts/zynq- ep107.dts index 37ca192..7bfff4a 100644
> > > --- a/arch/arm/boot/dts/zynq-ep107.dts
> > > +++ b/arch/arm/boot/dts/zynq-ep107.dts
> > > @@ -36,10 +36,12 @@
> > >               ranges;
> > >
> > >               intc: interrupt-controller at f8f01000 {
> > > +                     compatible = "arm,cortex-a9-gic";
> > > +                     #interrupt-cells = <3>;
> >
> > If you change git to 3 cells format you should also change it for uart below.
> >
> > Also will be the best to remove this dts entirely and replace it by
> > existing Platform.
> 
> Do you mean to say get rid of the ep107 entirely and replace it with, for
> example, a zc702 dts?

Yes, Ep107 platform is nothing what you can buy, that's why it is not the platform
Which should be supported in mainline. Supporting zc702 make sense.

> 
> I have a follow up patchset which splits off a zynq-7000.dtsi and a zynq-
> zc702.dts, and which also fixes the 3 interrupt cell problem.

I am not big fan to use dtsi solution because dts can be simple generated directly
>From Xilinx design tool based on your hw design. That's why I can't see any benefit
To have dtsi file. 

> Would you like for me to pull this into v5, or spin up a separate patch series?

Definitely not. I have checked patches but haven't got it work on the zc702.
Not sure if you have run it on real hw or just on the qemu as you have mentioned
In 5/5.

Thanks,
Michal
