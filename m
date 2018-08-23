From: vabhav.sharma@nxp.com (Vabhav Sharma)
Date: Thu, 23 Aug 2018 15:08:07 +0000
Subject: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
In-Reply-To: <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
 <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
Message-ID: <AM6PR04MB478980C90EE825D024D8B977F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Rob Herring <robh+dt@kernel.org>
> Sent: Wednesday, August 22, 2018 2:15 AM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Mark Rutland
> <mark.rutland@arm.com>; linuxppc-dev <linuxppc-dev@lists.ozlabs.org>;
> moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel at lists.infradead.org>; Michael Turquette <mturquette@baylibre.com>;
> Stephen Boyd <sboyd@kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> Viresh Kumar <viresh.kumar@linaro.org>; linux-clk <linux-
> clk at vger.kernel.org>; open list:THERMAL <linux-pm@vger.kernel.org>; linux-
> kernel-owner at vger.kernel.org; Catalin Marinas <catalin.marinas@arm.com>;
> Will Deacon <will.deacon@arm.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>; Kate
> Stewart <kstewart@linuxfoundation.org>; Masahiro Yamada
> <yamada.masahiro@socionext.com>; Russell King <linux@armlinux.org.uk>;
> Varun Sethi <V.Sethi@nxp.com>; Udit Kumar <udit.kumar@nxp.com>;
> Priyanka Jain <priyanka.jain@nxp.com>; Sriram Dash
> <sriram.dash@nxp.com>
> Subject: Re: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
> 
> On Mon, Aug 20, 2018 at 1:52 PM Vabhav Sharma
> <vabhav.sharma@nxp.com> wrote:
> >
> > LX2160A reference design board (RDB) is a high-performance computing,
> > evaluation, and development platform with LX2160A SoC.
> >
> > Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile            |  1 +
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 95
> > +++++++++++++++++++++++
> >  2 files changed, 96 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index 86e18ad..445b72b 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-
> rdb.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> > +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > new file mode 100644
> > index 0000000..70fad20
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -0,0 +1,95 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree file
> > +for LX2160ARDB // // Copyright 2018 NXP
> > +
> > +/dts-v1/;
> > +
> > +#include "fsl-lx2160a.dtsi"
> > +
> > +/ {
> > +       model = "NXP Layerscape LX2160ARDB";
> > +       compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> > +
> > +       aliases {
> > +               crypto = &crypto;
> 
> Drop this. Aliases should be numbered, and this is not a standard alias name
> either.
Ok
> 
> > +               serial0 = &uart0;
> > +               serial1 = &uart1;
> > +               serial2 = &uart2;
> > +               serial3 = &uart3;
> > +       };
> > +       chosen {
> > +               stdout-path = "serial0:115200n8";
> > +       };
> > +};
> > +
> > +&uart0 {
> > +       status = "okay";
> > +};
> > +
> > +&uart1 {
> > +       status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +       status = "okay";
> > +       pca9547 at 77 {
> 
> i2c-mux at 77
Sure
> 
> > +               compatible = "nxp,pca9547";
> > +               reg = <0x77>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               i2c at 2 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0x2>;
> > +
> > +                       ina220 at 40 {
power-sensor at 40
> > +                               compatible = "ti,ina220";
> > +                               reg = <0x40>;
> > +                               shunt-resistor = <1000>;
> > +                       };
> > +               };
> > +
> > +               i2c at 3 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       reg = <0x3>;
> > +
> > +                       sa56004 at 4c {
> 
> temperature-sensor at 4c
Ok, temperature-sensor-1 at 4c
> 
> > +                               compatible = "nxp,sa56004";
> > +                               reg = <0x4c>;
> > +                       };
> > +
> > +                       sa56004 at 4d {
Ok,temperature-sensor-2 at 4d
> > +                               compatible = "nxp,sa56004";
> > +                               reg = <0x4d>;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&i2c4 {
> > +       status = "okay";
> > +
> > +       rtc at 51 {
> > +               compatible = "nxp,pcf2129";
> > +               reg = <0x51>;
> > +               // IRQ10_B
> > +               interrupts = <0 150 0x4>;
> > +               };
> > +
> > +};
> > +
> > +&usb0 {
> > +       status = "okay";
> > +};
> > +
> > +&usb1 {
> > +       status = "okay";
> > +};
> > +
> > +&crypto {
> > +       status = "okay";
> > +};
> > --
> > 2.7.4
> >
