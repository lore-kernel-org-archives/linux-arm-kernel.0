From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 15:14:32 +0100
Subject: [Patch v5 3/7] mfd: ti-keystone-devctrl: add bindings for device
 state control
In-Reply-To: <1400766516-14537-4-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400766516-14537-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400766516-14537-4-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <20140522141432.GA19747@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Why do I only have this patch?  Where is the rest of the set?  Also,
it's on v5 and I don't recall seeing the other 4 versions?

> The Keystone II devices have a set of registers that are used to control
> the status of its peripherals. This node is intended to allow access to
> this functionality.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti-keystone-devctrl.txt   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
> new file mode 100644
> index 0000000..35f7a66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
> @@ -0,0 +1,19 @@
> +* Device tree bindings for Texas Instruments keystone device state control
> +
> +The Keystone II devices have a set of registers that are used to control
> +the status of its peripherals. This node is intended to allow access to
> +this functionality.
> +
> +Required properties:
> +
> +- compatible:		"ti,keystone-devctrl", "syscon"
> +
> +- reg:			contains offset/length value for pll controller
> +			registers space.

Why have you tabbed out all that way?

> +Example:
> +
> +devctrl: device-state-control {

This node needs an address:

devctrl: device-state-control at 02620000 {

> +	compatible = "ti,keystone-devctrl", "syscon";
> +	reg = <0x02620000 0x1000>;
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
