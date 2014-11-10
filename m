From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Nov 2014 09:55:02 +0000
Subject: [PATCH v2 04/11] mfd: syscon: Add Atmel SMC binding doc
In-Reply-To: <1415203287-21517-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415203287-21517-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141110095502.GH21424@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Nov 2014, Boris Brezillon wrote:

> The SMC registers are used to configure Atmel EBI (External Bus Interface)
> to interface with standard memory devices (NAND, NOR, SRAM or specialized
> devices like FPGAs).
> 
> Declare this memory region as a syscon, so that different drivers can
> configure the SMC interface (mostly timing configuration) according to
> their need.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-smc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-smc.txt b/Documentation/devicetree/bindings/mfd/atmel-smc.txt
> new file mode 100644
> index 0000000..0c0cc3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-smc.txt
> @@ -0,0 +1,19 @@
> +* Device tree bindings for Atmel SMC (Static Memory Controller)
> +
> +The SMC registers are used to configure Atmel EBI (External Bus Interface)
> +to interface with standard memory devices (NAND, NOR, SRAM or specialized
> +devices like FPGAs).
> +
> +Required properties:
> +- compatible:		should be one of the following
> +			"atmel,at91sam9260-smc", "syscon"
> +			"atmel,sama5d3-smc", "syscon"
> +- reg:			contains offset/length value of the SMC memory
> +			region.

I'd be happier if the sentences started with uppercase letters, but
nothing too offensive or controversial here:

Acked-by: Lee Jones <lee.jones@linaro.org>

> +Example:
> +
> +smc: smc at ffffc000 {
> +	compatible = "atmel,sama5d3-smc", "syscon";
> +	reg = <0xffffc000 0x1000>;
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
