From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 21 Jun 2018 12:05:18 +0000
Subject: [PATCH V2 3/4] dt-bindings: arm: fsl: add scu binding doc
In-Reply-To: <20180621073728.wmxb4jkn3ek4n2vt@pengutronix.de>
References: <1529239789-26849-1-git-send-email-aisheng.dong@nxp.com>
 <1529239789-26849-4-git-send-email-aisheng.dong@nxp.com>
 <20180620194438.GA3494@rob-hp-laptop>
 <AM0PR04MB4211C2A376E6C74C7C4AC37880760@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180621073728.wmxb4jkn3ek4n2vt@pengutronix.de>
Message-ID: <AM0PR04MB42115CCB6D7121E16D25122880760@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Thursday, June 21, 2018 3:37 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Rob Herring <robh@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; devicetree at vger.kernel.org;
> dongas86 at gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V2 3/4] dt-bindings: arm: fsl: add scu binding doc
> 
> On Thu, Jun 21, 2018 at 03:38:30AM +0000, A.s. Dong wrote:
> > Hi Rob,
> >
> > > -----Original Message-----
> > > From: Rob Herring [mailto:robh at kernel.org]
> > > Sent: Thursday, June 21, 2018 3:45 AM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> > > kernel at pengutronix.de; shawnguo at kernel.org; Fabio Estevam
> > > <fabio.estevam@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; Mark
> > > Rutland <mark.rutland@arm.com>; devicetree at vger.kernel.org
> > > Subject: Re: [PATCH V2 3/4] dt-bindings: arm: fsl: add scu binding
> > > doc
> > >
> > > On Sun, Jun 17, 2018 at 08:49:48PM +0800, Dong Aisheng wrote:
> > > > The System Controller Firmware (SCFW) is a low-level system
> > > > function which runs on a dedicated Cortex-M core to provide power,
> > > > clock, and resource management. It exists on some i.MX8
> > > > processors. e.g. i.MX8QM (QM, QP), and i.MX8QX (QXP, DX).
> > > >
> > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: devicetree at vger.kernel.org
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > ---
> > > > v1->v2:
> > > >  * remove status
> > > >  * changed to mu1
> > > > ---
> > > >  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 38
> > > > ++++++++++++++++++++++
> > > >  1 file changed, 38 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > new file mode 100644
> > > > index 0000000..9b7c9fe
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> > > > @@ -0,0 +1,38 @@
> > > > +NXP i.MX System Controller Firmware (SCFW)
> > > > +-----------------------------------------------------------------
> > > > +---
> > > > +
> > > > +The System Controller Firmware (SCFW) is a low-level system
> > > > +function which runs on a dedicated Cortex-M core to provide
> > > > +power, clock, and resource management. It exists on some i.MX8
> > > > +processors. e.g. i.MX8QM (QM, QP), and i.MX8QX (QXP, DX).
> > > > +
> > > > +The AP communicates with the SC using a multi-ported MU module
> > > > +found in the LSIO subsystem. The current definition of this MU
> > > > +module provides
> > > > +5 remote AP connections to the SC to support up to 5 execution
> > > > +environments (TZ, HV, standard Linux, etc.). The SC side of this
> > > > +MU module interfaces with the LSIO DSC IP bus. The SC firmware
> > > > +will communicate with this MU using the MSI bus.
> > > > +
> > > > +System Controller Device Node:
> > > > +=============================
> > > > +
> > > > +Required properties:
> > > > +-------------------
> > > > +- compatible: should be "fsl,imx8qxp-scu" or "fsl,imx8qm-scu"
> > > > +- fsl,mu: a phandle to the Message Unit used by SCU. Should be
> > > > +	  one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
> > > > +	  to make sure not use the one which is conflict with
> > > > +	  other execution environments. e.g. ATF.
> > >
> > > Use the mailbox binding even if you don't use the mailbox subsystem.
> > >
> >
> > Looks reasonable. Will change it.
> >
> > BTW as I said before, the current mailbox binding fixed #mbox-cells to
> > be at least 1 which is not suitable for i.MX SCU MU as it has only one
> > physical channel.
> 
> Why is that not suitable? If we use #mbox-cells = 1 we can encode the
> channel into the second cell. Furthermore, the SCU mode which uses all
> channels in a funny way could be another channel id the mu driver could use
> to distinguish the different channel/modes. i.e.
> 
> #define MU_CHANNEL_0	0
> #define MU_CHANNEL_1    1
> #define MU_CHANNEL_2    2
> #define MU_CHANNEL_3    3
> #define MU_CHANNEL_SCU	4
> 

That's a bit confusing.
The 'channel' here actually are abstract virtual channels implemented by driver,
not hardware. MU itself does not have multi channels. (For example, you can't
grep a 'channel' word in the MU chapter in RM).

Yes, it has 4 Read/Write Data register pairs, but it's not originally designed for
separate channels, they're defined to send multi words.

See:
42.3.3.2 Messaging Examples
The following are messaging examples:
* Passing short messages: Transmit register(s) can be used to pass short messages
from one to four words in length. For example, when a four-word message is desired,
only one of the registers needs to have its corresponding interrupt enable bit set at the
receiver side; the message's first three words are written to the registers whose
interrupt is masked, and the fourth word is written to the other register (which
triggers an interrupt at the receiver side).

Abstracting them into individual channels mean we lose the HW capability to send
multi words during one transfer. However, I'm not object to it if we have no
special requirent of it. But for SCU, we need use the four data read/write register
at the same time which seems Mailbox driver can't support.

And MU_CHANNEL_SCU seems a bit more confuse. It is really one
channel from HW point of view but transfer multi works at one time.

Do you really want us to do that way?

And by greping mbox-cells in device tree, there's indeed someone using 0.
arch/arm/boot/dts/bcm283x.dtsi:145:			#mbox-cells = <0>;

Regards
Dong Aisheng

> 
> scu {
>        compatible = "fsl,imx8qxp-scu";
>        fsl,mu = <&lsio_mu1 MU_CHANNEL_SCU>; };
> 
> This would also allow to the MU-SCU-mode driver to coexist with the regular
> MU driver for which Oleksij posted a driver.
> 
> Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7C17a
> 33ebbb3ef437fe76b08d5d749da3c%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C636651634553051648&sdata=YqJD%2FOcQvywtUtG6tpzdOxlnM
> tPRZP17ftjYP3gwynU%3D&reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
