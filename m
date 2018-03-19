From: ping.bai@nxp.com (Jacky Bai)
Date: Mon, 19 Mar 2018 01:40:52 +0000
Subject: [PATCH v4 1/2] ARM: dts: imx: Add basic dtsi file for imx6sll
In-Reply-To: <CAL_Jsq+=qMOAYw1+APwWKmgkfY=2c8OSes5ah2jrXnRVNU78mw@mail.gmail.com>
References: <1520503424-22985-1-git-send-email-ping.bai@nxp.com>
 <20180309233931.7xujvo4eg4g5ftri@rob-hp-laptop>
 <HE1PR04MB3113DC090D0608077D396DCB87D30@HE1PR04MB3113.eurprd04.prod.outlook.com>
 <CAL_Jsq+=qMOAYw1+APwWKmgkfY=2c8OSes5ah2jrXnRVNU78mw@mail.gmail.com>
Message-ID: <HE1PR04MB3113594EF47FBFE55802C88F87D40@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v4 1/2] ARM: dts: imx: Add basic dtsi file for imx6sll
> 
> On Sun, Mar 11, 2018 at 11:43 PM, Jacky Bai <ping.bai@nxp.com> wrote:
> >> > diff --git a/arch/arm/boot/dts/imx6sll.dtsi
> >> > b/arch/arm/boot/dts/imx6sll.dtsi
> >> > +           spi3 = &ecspi3;
> >> > +           spi4 = &ecspi4;
> >> > +           usbphy0 = &usbphy1;
> >> > +           usbphy1 = &usbphy2;
> >>
> >> Why do you need a alias for phys?
> >
> > The alias of usbphy seems used by drivers/usb/phy/phy-mxs-usb.c. So we need
> to add alias for usbphy.
> 
> That use should be fixed. The correct way to handle this is add a cell to
> "fsl,anatop" with 0 or 1 to distinguish each phy.
> 

This change can be done later by usb guys, for now I think it can be just keep as other imx6 platform.

> >> > +   };
> >> > +
> >> > +   cpus {
> >> > +           #address-cells = <1>;
> >> > +           #size-cells = <0>;
> >> > +
> >> > +           cpu0: cpu at 0 {
> >> > +                   compatible = "arm,cortex-a9";
> >> > +                   device_type = "cpu";
> >> > +                   reg = <0>;
> >> > +                   next-level-cache = <&L2>;
> >> > +                   operating-points = <
> >> > +                           /* kHz    uV */
> >> > +                           996000  1225000
> >> > +                           792000  1175000
> >> > +                           396000  1075000
> >> > +                           198000  975000
> >> > +                   >;
> >> > +                   fsl,soc-operating-points = <
> >>
> >> This is not documented.
> >
> > This is same as we used on other imx6 SOC. I don't know where to add doc for
> this property. Please give me some suggestion.
> 
> Along side other OPP binding docs. The real question is why you need this and
> can't use the original OPP binding (which you have too) or move to the v2
> binding.
> 

For i.MX6 SOCs, we have CPU core voltage domain and a SOC voltage domain. The voltage of these two domain
has strict relationship. So when doing cpu core DVFS, the SOC voltage need to be changed accordingly, the
'fsl,soc-operating-points' binding is used for SOC OPP.

Jacky
> Rob
