From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 22:31:17 +0200
Subject: [PATCH v3 14/19] ARM: shmobile: r8a7779: Add TMU devices to DT
In-Reply-To: <CAMuHMdXeyKy4vR0jNS3RC9E7+0_=xPXRUDokXe0kP+V8uVEiyQ@mail.gmail.com>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1462083.WMstm6aRc1@avalon>
 <CAMuHMdXeyKy4vR0jNS3RC9E7+0_=xPXRUDokXe0kP+V8uVEiyQ@mail.gmail.com>
Message-ID: <5236750.dtz35JItTk@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Monday 16 June 2014 18:19:02 Geert Uytterhoeven wrote:
> On Mon, Jun 16, 2014 at 4:22 PM, Laurent Pinchart wrote:
> >> diff --git a/arch/arm/boot/dts/r8a7779.dtsi
> >> b/arch/arm/boot/dts/r8a7779.dtsi index bf716ce..81714ce 100644
> >> --- a/arch/arm/boot/dts/r8a7779.dtsi
> >> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> >> @@ -269,9 +269,10 @@
> >>       tmu0: timer at ffd80000 {
> >>               compatible = "renesas,tmu";
> >>               reg = <0xffd80000 0x30>;
> >> -             interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
> >> -                          <0 41 IRQ_TYPE_LEVEL_HIGH>,
> >> -                          <0 42 IRQ_TYPE_LEVEL_HIGH>;
> >> +             interrupt-parent = <&gic>;
> >> +             interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <0 33 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <0 34 IRQ_TYPE_LEVEL_HIGH>;
> >> 
> >>               clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
> >>               clock-names = "fck";
> >> 
> >> @@ -283,9 +284,10 @@
> >>       tmu1: timer at ffd81000 {
> >>               compatible = "renesas,tmu";
> >>               reg = <0xffd81000 0x30>;
> >> -             interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>,
> >> -                          <0 45 IRQ_TYPE_LEVEL_HIGH>,
> >> -                          <0 46 IRQ_TYPE_LEVEL_HIGH>;
> >> +             interrupt-parent = <&gic>;
> >> +             interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <0 36 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <0 37 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > If I'm not mistaken the interrupts should be 36, 37 and 38.
> 
> (diving into the documentation)
> 
> Yes, probably 36, 37, and 38. I say "probably", as I find it non-trivial
> to convert from docs to DT.
> 
> What happens with 35, which is "TMU21 (input capture)"?
> As DT describes the hardware, shouldn't it be mentioned here?

Input capture isn't supported by the TMU driver yet. I haven't checked how the 
feature is implemented in the hardware, which is why I've left it out from the 
DT bindings for now.

> >>               clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
> >>               clock-names = "fck";
> >> 
> >> @@ -296,10 +298,11 @@
> >> 
> >>       tmu2: timer at ffd82000 {
> >>               compatible = "renesas,tmu";
> >> +             interrupt-parent = <&gic>;
> >>               reg = <0xffd82000 0x30>;
> >> -             interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>,
> >> -                          <0 49 IRQ_TYPE_LEVEL_HIGH>,
> >> -                          <0 50 IRQ_TYPE_LEVEL_HIGH>;
> >> +             interrupts = <0 38 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <0 39 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <0 40 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > And 40, 41 and 42 here.
> 
> Likewise for "TMU51 (input capture)"?
> 
> >>               clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
> >>               clock-names = "fck";

-- 
Regards,

Laurent Pinchart
