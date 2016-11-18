From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Nov 2016 18:47:15 +0000
Subject: [PATCH v2 2/6] mfd: dt: Add bindings for the Aspeed SoC Display
 Controller (GFX)
In-Reply-To: <1478097481-14895-3-git-send-email-andrew@aj.id.au>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-3-git-send-email-andrew@aj.id.au>
Message-ID: <20161118184715.GG19884@dell.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 03 Nov 2016, Andrew Jeffery wrote:

> The Aspeed SoC Display Controller is presented as a syscon device to
> arbitrate access by display and pinmux drivers. Video pinmux
> configuration on fifth generation SoCs depends on bits in both the
> System Control Unit and the Display Controller.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-gfx.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt

Same here.

> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt b/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
> new file mode 100644
> index 000000000000..aea5370efd97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
> @@ -0,0 +1,17 @@
> +* Device tree bindings for Aspeed SoC Display Controller (GFX)
> +
> +The Aspeed SoC Display Controller primarily does as its name suggests, but also
> +participates in pinmux requests on the g5 SoCs. It is therefore considered a
> +syscon device.
> +
> +Required properties:
> +- compatible:		"aspeed,ast2500-gfx", "syscon"
> +- reg:			contains offset/length value of the GFX memory
> +			region.
> +
> +Example:
> +
> +gfx: display at 1e6e6000 {
> +	compatible = "aspeed,ast2500-gfx", "syscon";
> +	reg = <0x1e6e6000 0x1000>;
> +};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
