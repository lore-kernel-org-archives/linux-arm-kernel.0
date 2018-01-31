From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 31 Jan 2018 18:03:54 +0000
Subject: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <1516836074-4149-2-git-send-email-jollys@xilinx.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-2-git-send-email-jollys@xilinx.com>
Message-ID: <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 03:21:11PM -0800, Jolly Shah wrote:
> Add documentation to describe Xilinx ZynqMP firmware driver
> bindings. Firmware driver provides an interface to firmware
> APIs. Interface APIs can be used by any driver to communicate
> to PMUFW (Platform Management Unit).
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> new file mode 100644
> index 0000000..a7aaf56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -0,0 +1,16 @@
> +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> +
> +The zynqmp-firmware node describes the interface to platform firmware.

Is there any documentation for this that can be referred to?

> +
> +Required properties:
> + - compatible:	Must contain:  "xlnx,zynqmp-firmware"
> + - method:	The method of calling the PM-API firmware layer.
> +		Permitted values are:
> +		 - "smc" : To be used in configurations without a hypervisor
> +		 - "hvc" : To be used when hypervisor is present

Please specify what exactly these mean. I assume these follow the SMCCC.
If so, this can be:

- method: The method of calling the PM-API firmware layer.
          Permitted values are:
	  - "smc" : SMC #0, following the SMCCC
	  - "hvc" : HVC #0, following the SMCCC

Otherwise, this looks ok to me.

Thanks,
Mark.

> +
> +Examples:
> +	zynqmp_firmware: zynqmp-firmware {
> +		compatible = "xlnx,zynqmp-firmware";
> +		method = "smc";
> +	};
> -- 
> 2.7.4
> 
