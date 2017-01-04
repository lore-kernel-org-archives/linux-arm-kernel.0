From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Jan 2017 11:36:08 +0000
Subject: [PATCH v4 2/5] mfd: dt: ranges, #address-cells and #size-cells
 as optional properties
In-Reply-To: <20161220071535.27542-3-andrew@aj.id.au>
References: <20161220071535.27542-1-andrew@aj.id.au>
 <20161220071535.27542-3-andrew@aj.id.au>
Message-ID: <20170104113608.GC27589@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Dec 2016, Andrew Jeffery wrote:

> Whilst describing a device and not a bus, simple-mfd is modelled on
> simple-bus where child nodes are iterated and registered as platform
> devices. Some complex devices, e.g. the Aspeed LPC controller, can
> benefit from address space mapping such that child nodes can use the
> regs property to describe their resource offsets within the
> multi-function device.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/mfd.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/mfd.txt b/Documentation/devicetree/bindings/mfd/mfd.txt
> index f1fceeda12f1..bcb6abb9d413 100644
> --- a/Documentation/devicetree/bindings/mfd/mfd.txt
> +++ b/Documentation/devicetree/bindings/mfd/mfd.txt
> @@ -25,6 +25,16 @@ Optional properties:
>    be used. In the latter case the child devices will be determined by the
>    operating system.
>  
> +- ranges: Describes the address mapping relationship to the parent. Should set
> +  the child's base address to 0, the physical address within parent's address
> +  space, and the length of the address map.
> +
> +- #address-cells: Specifies the number of cells used to represent physical base
> +  addresses. Must be present if ranges is used.
> +
> +- #size-cells: Specifies the number of cells used to represent the size of an
> +  address. Must be present if ranges is used.
> +
>  Example:
>  
>  foo at 1000 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
