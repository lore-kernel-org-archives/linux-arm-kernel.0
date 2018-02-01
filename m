From: JOLLYS@xilinx.com (Jolly Shah)
Date: Thu, 1 Feb 2018 01:04:45 +0000
Subject: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-2-git-send-email-jollys@xilinx.com>
 <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
Message-ID: <CY1PR0201MB076454E915A6E6947A39F04BB8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Thanks for the review,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Wednesday, January 31, 2018 10:04 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org;
> gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com; robh+dt at kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
> firmware
> 
> On Wed, Jan 24, 2018 at 03:21:11PM -0800, Jolly Shah wrote:
> > Add documentation to describe Xilinx ZynqMP firmware driver bindings.
> > Firmware driver provides an interface to firmware APIs. Interface APIs
> > can be used by any driver to communicate to PMUFW (Platform Management
> > Unit).
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16
> ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware
> > .txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > new file mode 100644
> > index 0000000..a7aaf56
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.txt
> > @@ -0,0 +1,16 @@
> > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> > +
> > +The zynqmp-firmware node describes the interface to platform firmware.
> 
> Is there any documentation for this that can be referred to?
>

Will add more information about supported APIs in next version patch.
Below document describes interface APIs though it is not latest.   
https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf


> > +
> > +Required properties:
> > + - compatible:	Must contain:  "xlnx,zynqmp-firmware"
> > + - method:	The method of calling the PM-API firmware layer.
> > +		Permitted values are:
> > +		 - "smc" : To be used in configurations without a hypervisor
> > +		 - "hvc" : To be used when hypervisor is present
> 
> Please specify what exactly these mean. I assume these follow the SMCCC.
> If so, this can be:
> 
> - method: The method of calling the PM-API firmware layer.
>           Permitted values are:
> 	  - "smc" : SMC #0, following the SMCCC
> 	  - "hvc" : HVC #0, following the SMCCC
> 
> Otherwise, this looks ok to me.
> 

Yes it follows SMCCC. 

> Thanks,
> Mark.
> 
> > +
> > +Examples:
> > +	zynqmp_firmware: zynqmp-firmware {
> > +		compatible = "xlnx,zynqmp-firmware";
> > +		method = "smc";
> > +	};
> > --
> > 2.7.4
> >
