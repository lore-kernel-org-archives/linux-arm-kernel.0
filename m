From: JOLLYS@xilinx.com (Jolly Shah)
Date: Wed, 7 Mar 2018 22:25:03 +0000
Subject: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
 <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
Message-ID: <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
> Sent: Thursday, March 01, 2018 6:15 AM
> To: Jolly Shah <JOLLYS@xilinx.com>; gregkh at linuxfoundation.org;
> matt at codeblueprint.co.uk; hkallweit1 at gmail.com; michal.simek at xilinx.com;
> robh+dt at kernel.org; mark.rutland at arm.com
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org; keescook at chromium.org;
> dmitry.torokhov at gmail.com; Sudeep Holla <sudeep.holla@arm.com>; Rajan
> Vaja <RAJANV@xilinx.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
> firmware
> 
> 
> 
> On 20/02/18 19:21, Jolly Shah wrote:
> > Add documentation to describe Xilinx ZynqMP firmware driver bindings.
> > Firmware driver provides an interface to firmware APIs. Interface APIs
> > can be used by any driver to communicate to PMUFW (Platform Management
> > Unit).
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 24
> ++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
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
> > index 0000000..99434ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.txt
> > @@ -0,0 +1,24 @@
> > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> > +
> > +The zynqmp-firmware node describes the interface to platform firmware.
> > +ZynqMP has an interface to communicate with secure firmware. Firmware
> > +driver provides an interface to firmware APIs. Interface APIs can be
> > +used by any driver to communicate to PMUFW(Platform Management Unit).
> > +These requests include clock management, pin control, device control,
> > +power management service, FPGA service and other platform management
> > +services.
> > +
> > +Required properties:
> > + - compatible:	Must contain:  "xlnx,zynqmp-firmware"
> > + - method:	The method of calling the PM-API firmware layer.
> > +		Permitted values are:
> > +		  - "smc" : SMC #0, following the SMCCC
> > +		  - "hvc" : HVC #0, following the SMCCC
> > +
> > +Examples:
> > +	firmware {
> > +		zynqmp_firmware: zynqmp-firmware {
> > +			compatible = "xlnx,zynqmp-firmware";
> > +			method = "smc";
> > +		};
> > +	};
> >
> 
> Do you foresee using SMC/HVC for this firmware even on future platforms?
> If not, I suggest to keep the protocol part separate from the transport i.e.
> smc/hvc via ATF. It could be replaced with mailbox or some h/w mechanism in
> future ?
> 

We have PSCI and EEMI interfaces exposed to linux from ATF.  PSCI is an EEMI client. We do not have current plans to switch to mailbox as it will require 2 communication channels to PMU as PSCI is through ATF. 

> --
> Regards,
> Sudeep
