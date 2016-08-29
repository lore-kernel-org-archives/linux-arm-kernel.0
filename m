From: anson.huang@nxp.com (Yongcai Huang)
Date: Mon, 29 Aug 2016 14:44:47 +0000
Subject: [PATCH V2] ARM: dts: imx6ul iomuxc syscon is compatible to imx6q
In-Reply-To: <20160829143447.GV30790@tiger>
References: <1472480743-8405-1-git-send-email-Anson.Huang@nxp.com>
 <20160829143447.GV30790@tiger>
Message-ID: <AM3PR04MB1315C6AE3AC95A1150DB04D7F5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2016-08-29 10:35 PM
> To: Yongcai Huang <anson.huang@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; mark.rutland at arm.com; robh+dt at kernel.org;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> linux at armlinux.org.uk
> Subject: Re: [PATCH V2] ARM: dts: imx6ul iomuxc syscon is compatible to imx6q
> 
> On Mon, Aug 29, 2016 at 10:25:43PM +0800, Anson Huang wrote:
> > The imx6ul iomuxc syscon is compatible to imx6q, so let's add
> > compatible string 'fsl,imx6q-iomuxc-gpr'
> > for imx6ul iomuxc syscon node.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Will this patch still be needed if you implement imx6ul suspend support with
> PSCI?
> 
> Shawn

This patch is to set the GINT bit for all low power mode transition.

Do we decide to go with PSCI for all i.MX6 SoCs? Currently i.MX6UL's suspend is
already supported with non-PCSI method, only i.MX7D uses PSCI, right? If we decide
to implement all power management feature with PSCI, then yes, all these changes
can be put into PSCI. But since current suspend/cpuidle function are already supported
using old method, this bit must be set to avoid system goes into low power mode
unexpected.

Regards!
Anson.

> 
> > ---
> > changes since V1:
> > 	improve commit message.
> >  arch/arm/boot/dts/imx6ul.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/imx6ul.dtsi
> > b/arch/arm/boot/dts/imx6ul.dtsi index 33b95d7..acc9486 100644
> > --- a/arch/arm/boot/dts/imx6ul.dtsi
> > +++ b/arch/arm/boot/dts/imx6ul.dtsi
> > @@ -644,7 +644,8 @@
> >  			};
> >
> >  			gpr: iomuxc-gpr at 020e4000 {
> > -				compatible = "fsl,imx6ul-iomuxc-gpr", "syscon";
> > +				compatible = "fsl,imx6ul-iomuxc-gpr",
> > +					     "fsl,imx6q-iomuxc-gpr", "syscon";
> >  				reg = <0x020e4000 0x4000>;
> >  			};
> >
> > --
> > 1.9.1
> >
