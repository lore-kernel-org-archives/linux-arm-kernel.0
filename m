From: lee.jones@linaro.org (Lee Jones)
Date: Sun, 18 Jan 2015 12:53:18 +0000
Subject: [PATCH 02/12] mfd: syscon: Add Atmel Matrix bus DT binding
 documentation
In-Reply-To: <1421252524-24452-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421252524-24452-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150118125318.GX3574@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Jan 2015, Alexandre Belloni wrote:

> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> The Matrix registers are provided to configure internal bus behavior on
> at91 SoCs.
> Some registers might be accessed by several drivers (e.g. to configure
> external memory bus timings), hence we declare this register set as a
> syscon device.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/mfd/atmel-matrix.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-matrix.txt

Applied, thanks.
 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-matrix.txt b/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
> new file mode 100644
> index 000000000000..e3ef50ca02a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel-matrix.txt
> @@ -0,0 +1,24 @@
> +* Device tree bindings for Atmel Bus Matrix
> +
> +The Bus Matrix registers are used to configure Atmel SoCs internal bus
> +behavior (master/slave priorities, undefined burst length type, ...)
> +
> +Required properties:
> +- compatible:		Should be one of the following
> +			"atmel,at91sam9260-matrix", "syscon"
> +			"atmel,at91sam9261-matrix", "syscon"
> +			"atmel,at91sam9263-matrix", "syscon"
> +			"atmel,at91sam9rl-matrix", "syscon"
> +			"atmel,at91sam9g45-matrix", "syscon"
> +			"atmel,at91sam9n12-matrix", "syscon"
> +			"atmel,at91sam9x5-matrix", "syscon"
> +			"atmel,sama5d3-matrix", "syscon"
> +- reg:			Contains offset/length value of the Bus Matrix
> +			memory region.
> +
> +Example:
> +
> +matrix: matrix at ffffec00 {
> +	compatible = "atmel,sama5d3-matrix", "syscon";
> +	reg = <0xffffec00 0x200>;
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
