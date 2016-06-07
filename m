From: hongtao.jia@nxp.com (Hongtao Jia)
Date: Tue, 7 Jun 2016 02:26:51 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvN10gZHQtYmluZGluZ3M6IFVwZGF0ZSBRb3JJUSBU?=
 =?gb2312?Q?MU_thermal_bindings?=
In-Reply-To: <20160606134708.GA27357@rob-hp-laptop>
References: <1464937059-19349-1-git-send-email-hongtao.jia@nxp.com>
 <20160606134708.GA27357@rob-hp-laptop>
Message-ID: <AM4PR0401MB1843CB326ACB958AA8FE64F8EB5D0@AM4PR0401MB1843.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----????-----
> ???: Rob Herring [mailto:robh at kernel.org]
> ????: Monday, June 06, 2016 9:47 PM
> ???: Hongtao Jia <hongtao.jia@nxp.com>
> ??: edubezval at gmail.com; rui.zhang at intel.com; galak at codeaurora.org;
> Scott Wood <scott.wood@nxp.com>; shawnguo at kernel.org;
> devicetree at vger.kernel.org; linux-pm at vger.kernel.org; linux-
> kernel at vger.kernel.org; linuxppc-dev at lists.ozlabs.org; linux-arm-
> kernel at lists.infradead.org
> ??: Re: [PATCH 1/7] dt-bindings: Update QorIQ TMU thermal bindings
> 
> On Fri, Jun 03, 2016 at 02:57:33PM +0800, Jia Hongtao wrote:
> > For different types of SoC the sensor id and endianness may vary.
> > "#thermal-sensor-cells" is used to provide sensor id information.
> > "little-endian" property is to tell the endianness of TMU.
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> > ---
> >  .../devicetree/bindings/thermal/qoriq-thermal.txt     | 19 +++++++++++++---
> ---
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> > index 66223d5..8eeef80 100644
> > --- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
> > @@ -1,22 +1,28 @@
> >  * Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
> >
> >  Required properties:
> > -- compatible : Must include "fsl,qoriq-tmu". The version of the device is
> > +- compatible: Must include "fsl,qoriq-tmu". The version of the device is
> 
> Please split functional changes from formatting changes. This one seems
> pretty pointless.

I will remove formatting changes in the next version.
Thanks.

> 
> >  	determined by the TMU IP Block Revision Register (IPBRR0) at
> >  	offset 0x0BF8.
> > -	Table of correspondences between IPBRR0 values and example  chips:
> > +	Table of correspondences between IPBRR0 values and example chips:
> >  		Value           Device
> >  		----------      -----
> >  		0x01900102      T1040
> > -- reg : Address range of TMU registers.
> > -- interrupts : Contains the interrupt for TMU.
> > -- fsl,tmu-range : The values to be programmed into TTRnCR, as specified by
> > +- reg: Address range of TMU registers.
> > +- interrupts: Contains the interrupt for TMU.
> > +- fsl,tmu-range: The values to be programmed into TTRnCR, as specified by
> >  	the SoC reference manual. The first cell is TTR0CR, the second is
> >  	TTR1CR, etc.
> > -- fsl,tmu-calibration : A list of cell pairs containing temperature
> > +- fsl,tmu-calibration: A list of cell pairs containing temperature
> >  	calibration data, as specified by the SoC reference manual.
> >  	The first cell of each pair is the value to be written to TTCFGR,
> >  	and the second is the value to be written to TSCFGR.
> > +- #thermal-sensor-cells: Must be 1. The sensor specifier is the monitoring
> > +	site ID, and represents the "n" in TRITSRn and TRATSRn.
> > +
> > +Optional property:
> > +- little-endian: If present, the TMU registers are little endian.  If absent,
> > +	the default is big endian.
> >
> >  Example:
> >
> > @@ -60,4 +66,5 @@ tmu at f0000 {
> >
> >  			       0x00030000 0x00000012
> >  			       0x00030001 0x0000001d>;
> > +	#thermal-sensor-cells = <1>;
> >  };
> > --
> > 2.1.0.27.g96db324
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
