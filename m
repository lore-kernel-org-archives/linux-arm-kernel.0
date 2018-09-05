From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Sep 2018 12:09:48 +0200
Subject: [RFC PATCH v3 2/3] dt-bindings: reset: Add bindings for ZynqMP
 reset driver
In-Reply-To: <1536131342-28041-3-git-send-email-nava.manne@xilinx.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
 <1536131342-28041-3-git-send-email-nava.manne@xilinx.com>
Message-ID: <1536142188.4084.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2018-09-05 at 12:39 +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP reset driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-Corrected Commit Msg. 
> Changes for v2:
> 		-Moved reset node as a child to firwmare
> 		 node.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 142 +++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index 1b431d9..351b1bb 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
[...]
>  -------
>  Example
>  -------
> @@ -25,5 +163,9 @@ firmware {
>  	zynqmp_firmware: zynqmp-firmware {
>  		compatible = "xlnx,zynqmp-firmware";
>  		method = "smc";
> +		reset-controller:reset-controller at 0 {

I think the label should use underscore instead of hyphen, and the unit
address part should be removed from the node name. There is no unit
address, as there is no reg property inside the node and the parent node
doesn't have #address-cells:

		reset_controller: reset-controller {

> +			compatible = "xlnx,zynqmp-reset";
> +			#reset-cells = <1>;
> +		};
>  	};
>  };

regards
Philipp
