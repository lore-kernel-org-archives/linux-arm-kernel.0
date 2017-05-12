From: madalin.bucur@nxp.com (Madalin-Cristian Bucur)
Date: Fri, 12 May 2017 14:14:18 +0000
Subject: [PATCH 3/3] dts: arm64: add LS1046A DPAA QBMan nodes
In-Reply-To: <20170331022941.GJ683@dragon>
References: <1490884672-18294-1-git-send-email-madalin.bucur@nxp.com>
 <1490884672-18294-4-git-send-email-madalin.bucur@nxp.com>
 <20170331022941.GJ683@dragon>
Message-ID: <AM5PR0402MB26914F301FF7C0B7C7AEF553ECE20@AM5PR0402MB2691.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Friday, March 31, 2017 5:30 AM
> On Thu, Mar 30, 2017 at 05:37:52PM +0300, Madalin Bucur wrote:
> > Add the QBMan device tree nodes for LS1046A devices.
> >
> > Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> > Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 52
> ++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > index 4a164b8..67e073a 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > @@ -268,6 +268,30 @@
> >  			};
> >  		};
> >
> > +		qman: qman at 1880000 {
> > +			compatible = "fsl,qman";
> > +			reg = <0x00 0x1880000 0x0 0x10000>;
> > +			interrupts = <0 45 0x4>;
> > +			memory-region = <&qman_fqd &qman_pfdr>;
> > +
> > +		};
> > +
> > +		bman: bman at 1890000 {
> > +			compatible = "fsl,bman";
> > +			reg = <0x00 0x1890000 0x0 0x10000>;
> > +			interrupts = <0 45 0x4>;
> > +			memory-region = <&bman_fbpr>;
> > +
> > +		};
> > +
> > +		qportals: qman-portals at 500000000 {
> > +			ranges = <0x0 0x5 0x00000000 0x8000000>;
> > +		};
> > +
> > +		bportals: bman-portals at 508000000 {
> > +			ranges = <0x0 0x5 0x08000000 0x8000000>;
> > +		};
> > +
> >  		dcfg: dcfg at 1ee0000 {
> >  			compatible = "fsl,ls1046a-dcfg", "syscon";
> >  			reg = <0x0 0x1ee0000 0x0 0x10000>;
> > @@ -592,4 +616,32 @@
> >  			clocks = <&clockgen 4 1>;
> >  		};
> >  	};
> > +
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		bman_fbpr: bman-fbpr {
> > +			compatible = "shared-dma-pool";
> > +			size = <0 0x1000000>;
> > +			alignment = <0 0x1000000>;
> > +			no-map;
> > +		};
> 
> Please have a newline between nodes.
> 
> Shawn

Done.
 
> > +		qman_fqd: qman-fqd {
> > +			compatible = "shared-dma-pool";
> > +			size = <0 0x800000>;
> > +			alignment = <0 0x800000>;
> > +			no-map;
> > +		};
> > +		qman_pfdr: qman-pfdr {
> > +			compatible = "shared-dma-pool";
> > +			size = <0 0x2000000>;
> > +			alignment = <0 0x2000000>;
> > +			no-map;
> > +		};
> > +	};
> >  };
> > +
> > +#include "qoriq-qman1-portals.dtsi"
> > +#include "qoriq-bman1-portals.dtsi"
> > --
> > 2.1.0
> >
