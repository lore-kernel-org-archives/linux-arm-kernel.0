From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 9 Jun 2017 15:46:38 +0200
Subject: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
In-Reply-To: <1497005895.28352.88.camel@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
 <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
 <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
 <1497005895.28352.88.camel@nxp.com>
Message-ID: <20170609154638.3b64e6d0@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 9 Jun 2017 13:58:15 +0300 Leonard Crestez wrote:
> On Thu, 2017-06-08 at 13:45 -0300, Fabio Estevam wrote:
> > On Thu, Jun 8, 2017 at 1:26 PM, Leonard Crestez  wrote:
> > 
> > > 
> > > +???????????????????????tempmon: tempmon {
> > > +???????????????????????????????compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
> > > +???????????????????????????????interrupts = ;
> > > +???????????????????????????????fsl,tempmon = <&anatop>;
> > > +???????????????????????????????fsl,tempmon-data = <&ocotp>;
> > > +???????????????????????????????clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
> > Does the IMX6UL_CLK_PLL3_USB_OTG clock really control tempmon? Please
> > double check.
> 
> Yes, as far as I can tell the tempmon block uses the 480 Mhz PLL3 clock
> directly. This is similar to other imx6 SOCs. This PLL is used for
> stuff like USB but not only that. My understanding is the _USB_OTG
> suffix is descriptive, similar to PLL4_AUDIO and PLL6_ENET. Other non-
> usb components use PLL3 (like UART) but through other gates/dividers.
> 
> Setting this to?IMX6UL_CLK_DUMMY will cause temperature reads to fail.
> Even if PLL3 usually ends up being constantly enabled because of uarts
> this is not true at imx_thermal_probe time (or uarts can be disabled).
>
Since the driver is accessing the OCOTP registers it definitely needs
the IMX6UL_CLK_OCOTP too!


Lothar Wa?mann
