From: anson.huang@nxp.com (Anson Huang)
Date: Fri, 27 Apr 2018 01:33:00 +0000
Subject: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
In-Reply-To: <CAOMZO5DWeYCbWn9LEi1e+tc4gZsjBBpXtiwzmwLbYp=E4TERrg@mail.gmail.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
 <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
 <DB5PR04MB13205A0A7134C969748560B4F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
 <CAOMZO5DWeYCbWn9LEi1e+tc4gZsjBBpXtiwzmwLbYp=E4TERrg@mail.gmail.com>
Message-ID: <AM3PR04MB1315E21D05BC3EA5F9E6D2EAF58D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Friday, April 27, 2018 1:24 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Russell King - ARM Linux <linux@armlinux.org.uk>; dl-linux-imx
> <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
> max7310 support
> 
> On Thu, Apr 26, 2018 at 3:31 AM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > I searched the mail I sent, I can NOT found where I said "MAX7310 controls
> the ethernet phy"....
> 
> Initially you passed:  pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>
> inside the fec1 node.
> 
> Then I explained that 'pinctrl-assert-gpios' is not a valid property in mainline. It
> only exists in NXP vendor tree.
> 
> Then you explained:
> 
> "Sorry, I made a mistake here, the MAX7320 IO0 is for adjusting FEC1's voltage"

The ' pinctrl-assert-gpios ' is ONLY in NXP local tree, FEC owner added it because he
wants to set this GPIO ONCE during kernel boot up, but upstream kernel does NOT
support the pinctrl-assert-gpio, so we have to drop it, the MAX7322 IO0 is for adjusting
FEC's voltage, I meant for FEC IO's voltage, 1.5V or 1.8V. If I made any confuse, I am
sorry for that, I think it should be clear now, all we want/need is to set this GPIO ONCE
to get the IO voltage we want.

> 
> > There are MAX7310 users, it is just because currently those users are
> > NOT enabled, so I can NOT verify them. MAX7310 is an independent I2C
> device, why we can NOT enable it first?
> > I tested it from sysfs interface, we can control the MAX7310's IO
> > output via echo different value to GPIO value, that means MAX7310
> > itself as an IO expander chip is working just fine, similar with PMIC, it is a I2C
> device, can be enabled independently, then consumers can be added later when
> they are enabled.
> > Just my personal opinion, thanks.
> 
> Right, but if FEC needs max7322 IO0 at level 1 then better describe it in dts.
 
Agree, since currently our FEC driver does NOT support adjusting such IO voltage in driver, 
and there is NO such requirement of runtime switching IO voltage for FEC, so I think it
should be good here, just use the default settings of MAX7322 IO0 described in 'reg_fec',
if there is any further requirement of runtime adjusting FEC IO voltage, I think FEC driver
needs to add such support, and there will be new patch for it.

Thanks.

Anson.  
