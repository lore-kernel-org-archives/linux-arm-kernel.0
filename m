From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 25 Apr 2018 05:36:01 +0000
Subject: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
In-Reply-To: <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
 <1524455219-6736-4-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CDAQtw7Q6NgSzKP4ogaqRaGSE0A+st1iqZ=cQsK49moQ@mail.gmail.com>
 <AM3PR04MB131566E1C8033D256686F192F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5Dm=MFRoh=y54Qf2RrncWfQPTUJ2ZNfvYnUD=idp8RPNA@mail.gmail.com>
 <AM3PR04MB1315ED599A20F67BB9FEFEE1F58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <AM3PR04MB1315B04BE46755E3EB82E04CF58F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Wednesday, April 25, 2018 11:30 AM
> To: 'Fabio Estevam' <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX / MXC
> ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list:OPEN
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> <devicetree@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>
> Subject: RE: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> 
> Hi, Fabio
> 
> Anson Huang
> Best Regards!
> 
> 
> > -----Original Message-----
> > From: Fabio Estevam [mailto:festevam at gmail.com]
> > Sent: Tuesday, April 24, 2018 8:23 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> > Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > dl-linux-imx <linux-imx@nxp.com>; moderated list:ARM/FREESCALE IMX /
> > MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open
> > list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; linux-kernel
> > <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH 4/5] ARM: dts: imx6sx-sabreauto: add fec support
> >
> > Hi Anson,
> >
> > On Mon, Apr 23, 2018 at 11:09 PM, Anson Huang <anson.huang@nxp.com>
> > wrote:
> >
> > > Ah, yes, thanks for pointing out this issue, I just removed it and
> > > the function is still working, already sent out V2 patch set, thanks.
> >
> > So now maybe it is working only because the bootloader activated this
> > GPIO, which is not good.
> >
> > I don't have access to the mx6sx sabreauto schematics to verify  where
> > &max7322 0 connects to, but it would be better to make sure that you
> > activate this pin in dts if it is needed for Ethernet, without relying on the
> bootloader.
> 
> It is working by default hardware settings, but I agree we should do it in dts, I
> found it has a lot of dependency if we want to enable the gpio reset for FEC1,
> many gpio reset patch missed in upstream kernel, need patch work for
> MAX7322 first, so I plan to remove FEC support in this patch set, and will
> upstream the MAX7322 reset patch first, then will add FEC support after
> MAX7322 patch done. Will send out V3 patch to drop fec support for now,
> thanks.
> 
> Anson.

Sorry, I made a mistake here, the MAX7320 IO0 is for adjusting FEC1's voltage,
NOT reset, and when I tested MAX7320 driver, I did NOT notice that the
CONFIG_GPIO_MAX732X is NOT enabled in imx_v6_v7_defconfig, so I thought
it is NOT working, after enabling MAX7320 driver, max7320 is working as expected,
will send out another patch set including fec driver and MAX7320 config, thanks for your patience.

Anson.

> 
> 
> 
> 
