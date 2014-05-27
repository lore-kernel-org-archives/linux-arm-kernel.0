From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 May 2014 10:24:28 +0100
Subject: [Patch v7 3/7] mfd: ti-keystone-devctrl: add bindings for device
 state control
In-Reply-To: <1400859812-5761-4-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400859812-5761-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400859812-5761-4-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <20140527092428.GH5875@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The Keystone II devices have a set of registers that are used to control
> the status of its peripherals. This node is intended to allow access to
> this functionality.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Acked-by: Lee Jones <lee.jones@linaro.org>

> ---
>  .../devicetree/bindings/mfd/ti-keystone-devctrl.txt   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
> new file mode 100644
> index 0000000..20963c7
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
> +- reg:			contains offset/length value for device state control
> +			registers space.
> +
> +Example:
> +
> +devctrl: device-state-control at 0x02620000 {
> +	compatible = "ti,keystone-devctrl", "syscon";
> +	reg = <0x02620000 0x1000>;
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
