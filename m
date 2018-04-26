From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 26 Apr 2018 06:31:08 +0000
Subject: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
In-Reply-To: <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
 <AM3PR04MB13150654494B8D251988F76CF58E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5AZLbUoL7FWgUFA7qc3q3wcz9UBLSQhMXXkUJeiRz8X4A@mail.gmail.com>
Message-ID: <DB5PR04MB13205A0A7134C969748560B4F58E0@DB5PR04MB1320.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Thursday, April 26, 2018 2:21 PM
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
> On Thu, Apr 26, 2018 at 12:06 AM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> > MAX7310 pins are for PCIe, CAN, MLB. GPS etc., these modules are NOT
> > enabled yet, so I can NOT test it, I think we should add MAX7310 users
> > when these modules are enabled, ethernet PHY is NOT controlled by it.
> 
> You said previously that MAX7310 also controls the Ethernet PHY. Is the vendor
> dts wrong then?
> 
> If there are no MAX7310 users, why are you adding support for MAX7310 then?
> 
> Confused.

I searched the mail I sent, I can NOT found where I said "MAX7310 controls the ethernet phy"....

There are MAX7310 users, it is just because currently those users are NOT enabled, so I can
NOT verify them. MAX7310 is an independent I2C device, why we can NOT enable it first?
I tested it from sysfs interface, we can control the MAX7310's IO output via echo different value
to GPIO value, that means MAX7310 itself as an IO expander chip is working just fine, similar with PMIC,
it is a I2C device, can be enabled independently, then consumers can be added later when they are enabled.
Just my personal opinion, thanks.

Anson.
