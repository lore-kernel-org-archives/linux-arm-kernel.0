From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 14 Dec 2013 17:27:07 -0500
Subject: [PATCH 0/4] ARM: mvebu: sort DT nodes by reg address
In-Reply-To: <cover.1386861599.git.jason@lakedaemon.net>
References: <20130816061500.GE7035@quad.lixom.net>
 <cover.1386861599.git.jason@lakedaemon.net>
Message-ID: <20131214222707.GH2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:25:15PM +0000, Jason Cooper wrote:
> Olof, all,
> 
> I love December!  I'm getting around to some of the items on my -onice folder.
> Namely, this one:
> 
> On Thu, Aug 15, 2013 at 11:15:00PM -0700, Olof Johansson wrote:
> > On Wed, Aug 14, 2013 at 02:59:45PM -0400, Jason Cooper wrote:
> ...
> > > diff --cc arch/arm/boot/dts/kirkwood.dtsi
> > > index 70f414d,1d6921d..6489b98
> > > --- a/arch/arm/boot/dts/kirkwood.dtsi
> > > +++ b/arch/arm/boot/dts/kirkwood.dtsi
> > > @@@ -47,11 -30,30 +40,35 @@@
> > >             #address-cells = <1>;
> > >             #size-cells = <1>;
> > >   
> > > +           timer: timer at 20300 {
> > > +                   compatible = "marvell,orion-timer";
> > > +                   reg = <0x20300 0x20>;
> > > +                   interrupt-parent = <&bridge_intc>;
> > > +                   interrupts = <1>, <2>;
> > > +                   clocks = <&core_clk 0>;
> > > +           };
> > > + 
> > > +           intc: main-interrupt-ctrl at 20200 {
> > > +                   compatible = "marvell,orion-intc";
> > > +                   interrupt-controller;
> > > +                   #interrupt-cells = <1>;
> > > +                   reg = <0x20200 0x10>, <0x20210 0x10>;
> > > +           };
> > > + 
> > > +           bridge_intc: bridge-interrupt-ctrl at 20110 {
> > > +                   compatible = "marvell,orion-bridge-intc";
> > > +                   interrupt-controller;
> > > +                   #interrupt-cells = <1>;
> > > +                   reg = <0x20110 0x8>;
> > > +                   interrupts = <1>;
> > > +                   marvell,#interrupts = <6>;
> > > +           };
> > > + 
> > >  +          mbusc: mbus-controller at 20000 {
> > >  +                  compatible = "marvell,mbus-controller";
> > >  +                  reg = <0x20000 0x80>, <0x1500 0x20>;
> > >  +          };
> > >  +
> > >             core_clk: core-clocks at 10030 {
> > >                     compatible = "marvell,kirkwood-core-clock";
> > >                     reg = <0x10030 0x4>;
> > 
> > This file is a real mess. :( Nothing is sorted properly under the ocp/ bus.
> > It's common to sort by memory address. Or I'd even take alphabetically if
> > there was a good reason to do so. Just some order of some kind.
> 
> Done.
> 
> thx,
> 
> Jason.
> 
> Jason Cooper (4):
>   ARM: kirkwood: sort dt nodes by address
>   ARM: dove: sort DT nodes by address
>   ARM: orion5x: sort DT nodes by address
>   ARM: mvebu: sort DT nodes by address
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi | 176 ++++++-------
>  arch/arm/boot/dts/armada-370.dtsi    |  74 +++---
>  arch/arm/boot/dts/armada-xp.dtsi     | 100 +++----
>  arch/arm/boot/dts/dove.dtsi          | 496 +++++++++++++++++------------------
>  arch/arm/boot/dts/kirkwood.dtsi      | 140 +++++-----
>  arch/arm/boot/dts/orion5x.dtsi       | 106 ++++----
>  6 files changed, 546 insertions(+), 546 deletions(-)

Series applied to mvebu/dt

And Jason, next time, don't take so long.  :)

thx,

Jason.
