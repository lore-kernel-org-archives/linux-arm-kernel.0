From: pankaj.bansal@nxp.com (Pankaj Bansal)
Date: Sat, 29 Sep 2018 01:54:12 +0000
Subject: [PATCH] arm64: dts: add LX2160AQDS board support
In-Reply-To: <CADRPPNQ2HU5JgoSjwXEG-7n9=hAOQJO5FS2BJSWa5YWb2AGriw@mail.gmail.com>
References: <20180921141720.19159-1-pankaj.bansal@nxp.com>
 <20180928090030.GI26692@dragon>
 <CADRPPNQ2HU5JgoSjwXEG-7n9=hAOQJO5FS2BJSWa5YWb2AGriw@mail.gmail.com>
Message-ID: <HE1PR0402MB332353F9B710710DCB7CFA83F1ED0@HE1PR0402MB3323.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

> -----Original Message-----
> From: Li Yang [mailto:leoyang.li at nxp.com]
> Sent: Saturday, September 29, 2018 12:51 AM
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel at lists.infradead.org>; Mark Rutland <mark.rutland@arm.com>;
> open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Vabhav Sharma <vabhav.sharma@nxp.com>; Sriram Dash
> <sriram.dash@nxp.com>
> Subject: Re: [PATCH] arm64: dts: add LX2160AQDS board support
> 
> On Fri, Sep 28, 2018 at 4:01 AM Shawn Guo <shawnguo@kernel.org>
> wrote:
> >
> > On Fri, Sep 21, 2018 at 07:47:20PM +0530, Pankaj Bansal wrote:
> > > The LX2160A QorIQ Development System (QDS) is a test, evaluation,
> > > and development platform, supporting QorIQ LX2160A processor.
> > >
> > > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > > Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > ---
> > >
> > > Notes:
> > >     This patch is dependent on [1] and [2]
> > >      [1]
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flo
> re.kernel.org%2Fpatchwork%2Fpatch%2F985935%2F&amp;data=02%7C01
> %7Cpankaj.bansal%40nxp.com%7C9463713031ba421c0b7808d625778d4d
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6367375927397
> 12471&amp;sdata=n8dSYL1yq2zsaVHy4LnnpglK%2Fjn0f4sED0LX3XQma5Y
> %3D&amp;reserved=0
> > >      [2]
> > >
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fl
> > >
> ore.kernel.org%2Fpatchwork%2Fpatch%2F985938%2F&amp;data=02%7C0
> 1%7Cpa
> > >
> nkaj.bansal%40nxp.com%7C9463713031ba421c0b7808d625778d4d%7C6
> 86ea1d3b
> > >
> c2b4c6fa92cd99c5c301635%7C0%7C0%7C636737592739712471&amp;sd
> ata=SWxih
> > > D1cQTvjnUslr2%2BfBndYvmsCJveIGboc4i5fssU%3D&amp;reserved=0
> >
> > I did not receive these.
> 
> Please add the Shawn Guo and me in "to" recipients when you send next
> version of these patches.  And, btw, I find there is a v3 now, but your link is
> still pointing to the v2.

Vabhav Sharma sent the patches for LX2160A SOC support. I will ask him to include you and Shawn Guo to add in to list.
I have sent only this patch for LX2160AQDS board, which depends on LX2160A SOC support.

When I sent this patch V2 of SOC patches was the latest version.
I will update the links to V3 SOC support patches, when I send V2 of this patch.

> 
> >
> > >
> > >  arch/arm64/boot/dts/freescale/Makefile       |  1 +
> > >  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 88 ++++++++++++++++++
> > >  2 files changed, 89 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > b/arch/arm64/boot/dts/freescale/Makefile
> > > index 445b72bd5a36..ae80fc5c45f7 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -14,3 +14,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=
> > > fsl-ls2080a-simu.dtb
> > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
> > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> > >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> > > +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
> >
> > Please keep them in alphabetic order.

Ok.

> >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > new file mode 100644
> > > index 000000000000..5cf2fe279f73
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> > > @@ -0,0 +1,88 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree file
> > > +for LX2160AQDS // // Copyright 2018 NXP
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "fsl-lx2160a.dtsi"
> > > +
> > > +/ {
> > > +     model = "NXP Layerscape LX2160AQDS";
> > > +     compatible = "fsl,lx2160a-qds", "fsl,lx2160a";
> > > +
> > > +     chosen {
> > > +             stdout-path = "serial0:115200n8";
> > > +     };
> > > +};
> > > +
> > > +&uart0 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&uart1 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&i2c0 {
> >
> > Sort these labeled nodes alphabetically, so that new additions can
> > find their place easier.

Ok.

> >
> > > +     status = "okay";
> >
> > Have a newline between property list and child node.

Ok.

> >
> > Shawn
> >
> > > +     i2c-mux at 77 {
> > > +             compatible = "nxp,pca9547";
> > > +             reg = <0x77>;
> > > +             #address-cells = <1>;
> > > +             #size-cells = <0>;
> > > +
> > > +             i2c at 2 {
> > > +                     #address-cells = <1>;
> > > +                     #size-cells = <0>;
> > > +                     reg = <0x2>;
> > > +
> > > +                     power-monitor at 40 {
> > > +                             compatible = "ti,ina220";
> > > +                             reg = <0x40>;
> > > +                             shunt-resistor = <500>;
> > > +                     };
> > > +
> > > +                     power-monitor at 41 {
> > > +                             compatible = "ti,ina220";
> > > +                             reg = <0x41>;
> > > +                             shunt-resistor = <1000>;
> > > +                     };
> > > +             };
> > > +
> > > +             i2c at 3 {
> > > +                     #address-cells = <1>;
> > > +                     #size-cells = <0>;
> > > +                     reg = <0x3>;
> > > +
> > > +                     temperature-sensor at 4c {
> > > +                             compatible = "nxp,sa56004";
> > > +                             reg = <0x4c>;
> > > +                     };
> > > +
> > > +                     temperature-sensor at 4d {
> > > +                             compatible = "nxp,sa56004";
> > > +                             reg = <0x4d>;
> > > +                     };
> > > +
> > > +                     rtc at 51 {
> > > +                             compatible = "nxp,pcf2129";
> > > +                             reg = <0x51>;
> > > +                     };
> > > +             };
> > > +     };
> > > +};
> > > +
> > > +&usb0 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usb1 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&crypto {
> > > +     status = "okay";
> > > +};
> > > +
> > > --
> > > 2.17.1
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel at lists.infradead.org
> > >
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fli
> > > sts.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=0
> > >
> 2%7C01%7Cpankaj.bansal%40nxp.com%7C9463713031ba421c0b7808d62
> 5778d4d%
> > >
> 7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63673759273971
> 2471&amp;
> > >
> sdata=zjGNGbbV8ODaRnL%2F762TTTtRdBC12rbEwD2Gcq3LI0c%3D&amp;r
> eserved=
> > > 0
