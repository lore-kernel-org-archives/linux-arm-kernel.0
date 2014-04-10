From: heiko.stuebner@bq.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 10 Apr 2014 11:34:47 +0200
Subject: [PATCH 3/4] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <53465A4B.4040906@free-electrons.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
 <CABuKBeKnEw38sQYwrkheoWetZZcPTJhKRsBK4a62FS6-6dRFTA@mail.gmail.com>
 <53465A4B.4040906@free-electrons.com>
Message-ID: <3428574.kpvz0qlT1a@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Am Donnerstag, 10. April 2014, 08:46:03 schrieb Gregory CLEMENT:
> On 10/04/2014 08:29, Matthias Brugger wrote:
> > 2014-04-09 22:26 GMT+02:00 Gregory CLEMENT <gregory.clement@free-
electrons.com>:
> >> Hi Matthias,
> >> 
> >> On 09/04/2014 19:45, Matthias Brugger wrote:
> >>> diff --git a/arch/arm/boot/dts/mtk6589.dtsi
> >>> b/arch/arm/boot/dts/mtk6589.dtsi new file mode 100644
> >>> index 0000000..6dbb74f
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/mtk6589.dtsi
> >>> @@ -0,0 +1,105 @@
> >>> +/*
> >>> + * Copyright (c) 2014 MundoReader S.L.
> >>> + * Author: Matthias Brugger <matthias.bgg@gmail.com>
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or modify
> >>> + * it under the terms of the GNU General Public License as published by
> >>> + * the Free Software Foundation; either version 2 of the License, or
> >>> + * (at your option) any later version.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful,
> >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + * GNU General Public License for more details.
> >>> + */
> >>> +
> >>> +#include <dt-bindings/interrupt-controller/irq.h>
> >>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >>> +#include "skeleton.dtsi"
> >>> +
> >>> +/ {
> >>> +     compatible = "mediatek,mt6589";
> >>> +     interrupt-parent = <&gic>;
> >>> +
> >>> +     cpus {
> >>> +             #address-cells = <1>;
> >>> +             #size-cells = <0>;
> >>> +
> >>> +             cpu at 0 {
> >>> +                     device_type = "cpu";
> >>> +                     compatible = "arm,cortex-a7";
> >>> +                     next-level-cache = <&L2>;
> >>> +                     reg = <0x0>;
> >>> +             };
> >>> +             cpu at 1 {
> >>> +                     device_type = "cpu";
> >>> +                     compatible = "arm,cortex-a7";
> >>> +                     next-level-cache = <&L2>;
> >>> +                     reg = <0x1>;
> >>> +             };
> >>> +             cpu at 2 {
> >>> +                     device_type = "cpu";
> >>> +                     compatible = "arm,cortex-a7";
> >>> +                     next-level-cache = <&L2>;
> >>> +                     reg = <0x2>;
> >>> +             };
> >>> +             cpu at 3 {
> >>> +                     device_type = "cpu";
> >>> +                     compatible = "arm,cortex-a7";
> >>> +                     next-level-cache = <&L2>;
> >>> +                     reg = <0x3>;
> >>> +             };
> >>> +
> >>> +     };
> >>> +
> >>> +     clocks {
> >>> +             #address-cells = <1>;
> >>> +             #size-cells = <1>;
> >>> +             ranges;
> >>> +
> >>> +             system_clk: system_clk {
> >>> +                     compatible = "fixed-clock";
> >>> +                     clock-frequency = <13000000>;
> >>> +                     #clock-cells = <0>;
> >>> +                     clock-output-names = "system_clk";
> >>> +             };
> >> 
> >> Is it really a fixed clock without any parent, or do you
> >> declare it as a fixed clock because you don't have any clock
> >> common framework support yet?
> > 
> > I don't have any common clock framework support yet.
> 
> So maybe you should provide one (even a very simple one).
> 
> Pretending a clock is a fixed clock and ignoring its parents
> will be problematic when you will add the common clock framework
> support because the device tree is supposed to be stable and you won't
> be able to change it then.

personally I think the danger of introducing unsuitable bindings/precedents 
for a clock controller before it is fully understood is higher.

I'd just rename the clock above to something like dummy130m like sunxi also 
does for example, to reflect its unfinished state and when the clock controller 
is present later on change the supplying clock of the timer.

Or maybe I'm overlooking something here :-)


Heiko
