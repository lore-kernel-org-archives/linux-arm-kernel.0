From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 13:53:39 +0100
Subject: [PATCH V5 2/3] Documentation: gpio: Add APM X-Gene SoC GPIO
 controller DTS binding
In-Reply-To: <1403823587-23404-3-git-send-email-fkan@apm.com>
References: <1403823587-23404-1-git-send-email-fkan@apm.com>
 <1403823587-23404-3-git-send-email-fkan@apm.com>
Message-ID: <20140630125339.GA21390@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 11:59:46PM +0100, Feng Kan wrote:
> Documentation for APM X-Gene SoC GPIO controller DTS binding.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  .../devicetree/bindings/gpio/gpio-xgene.txt          | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-xgene.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene.txt
> new file mode 100644
> index 0000000..bd5fd85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-xgene.txt
> @@ -0,0 +1,20 @@
> +APM X-Gene SoC GPIO controller bindings
> +
> +This is a gpio controller that is part of the flash controller.
> +This gpio controller controls a total of 48 gpios.
> +
> +Required properties:
> +- compatible: "apm,xgene-gpio" for X-Gene GPIO controller
> +- reg: Physical base address and size of the controller's registers

There is just the one bank?

> +- #gpio-cells: Should be two.
> +	- first cell is the pin number
> +	- second cell is used to specify optional parameters (unused)

Why is there an unused cell?

Why not just make this a single cell if the binding defines no valid
parameters?

> +- gpio-controller: Marks the device node as a GPIO controller.

No interrupts?

Thanks,
Mark.

> +
> +Example:
> +	gpio0: gpio0 at 1701c000 {
> +		compatible = "apm,xgene-gpio";
> +		reg = <0x0 0x1701c000 0x0 0x40>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
