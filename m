From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 1 Mar 2018 14:15:24 +0000
Subject: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <1519154467-2896-2-git-send-email-jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
Message-ID: <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/02/18 19:21, Jolly Shah wrote:
> Add documentation to describe Xilinx ZynqMP firmware driver
> bindings. Firmware driver provides an interface to firmware
> APIs. Interface APIs can be used by any driver to communicate
> to PMUFW (Platform Management Unit).
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> new file mode 100644
> index 0000000..99434ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -0,0 +1,24 @@
> +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> +
> +The zynqmp-firmware node describes the interface to platform firmware.
> +ZynqMP has an interface to communicate with secure firmware. Firmware
> +driver provides an interface to firmware APIs. Interface APIs can be
> +used by any driver to communicate to PMUFW(Platform Management Unit).
> +These requests include clock management, pin control, device control,
> +power management service, FPGA service and other platform management
> +services.
> +
> +Required properties:
> + - compatible:	Must contain:  "xlnx,zynqmp-firmware"
> + - method:	The method of calling the PM-API firmware layer.
> +		Permitted values are:
> +		  - "smc" : SMC #0, following the SMCCC
> +		  - "hvc" : HVC #0, following the SMCCC
> +
> +Examples:
> +	firmware {
> +		zynqmp_firmware: zynqmp-firmware {
> +			compatible = "xlnx,zynqmp-firmware";
> +			method = "smc";
> +		};
> +	};
> 

Do you foresee using SMC/HVC for this firmware even on future platforms?
If not, I suggest to keep the protocol part separate from the transport
i.e. smc/hvc via ATF. It could be replaced with mailbox or some h/w
mechanism in future ?

-- 
Regards,
Sudeep
