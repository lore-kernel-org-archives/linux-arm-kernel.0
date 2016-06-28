From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Jun 2016 15:56:33 -0500
Subject: [PATCH 2/6] ARM: dts: nuc900: Add nuc970 dts files
In-Reply-To: <1466851042-22239-3-git-send-email-vw@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
 <1466851042-22239-3-git-send-email-vw@iommu.org>
Message-ID: <20160628205633.GN3737@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 06:37:18PM +0800, Wan Zongshun wrote:
> This patch is to add dts support for nuc970 platform.
> 
> Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
>  .../devicetree/bindings/arm/nuvoton/nuc970.txt     |  30 +++
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/nuc970-evb.dts                   |  20 ++
>  arch/arm/boot/dts/nuc970.dtsi                      |  93 ++++++++
>  include/dt-bindings/clock/nuc970-clock.h           | 233 +++++++++++++++++++++
>  5 files changed, 377 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt
>  create mode 100644 arch/arm/boot/dts/nuc970-evb.dts
>  create mode 100644 arch/arm/boot/dts/nuc970.dtsi
>  create mode 100644 include/dt-bindings/clock/nuc970-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt b/Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt
> new file mode 100644
> index 0000000..df8637a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/nuvoton/nuc970.txt
> @@ -0,0 +1,30 @@
> +Nuvoton NUC970 SoC platform Device Tree Bindings
> +------------------------------------------
> +
> +Boards with the NUC970 SoC shall have the following properties:
> +
> +Root node required properties:
> +- compatible: Should be "nuvoton,nuc970evb", "nuvoton,nuc970"
> +
> +Timer required properties:

This should go in bindings/timer/

> +- compatible: Should be "nuvoton,tmr"

Needs an SoC specific compatible string

> +- reg: Should contain registers location and length
> +- interrupts: hwirq is direct mapping to irq number
> +- clocks: phandle to input clock.
> +
> +Clock required properties:

This should go in bindings/clock/

> +- compatible: Should be "nuvoton,clk"

SoC specific...

> +- reg: Should contain registers location and length
> +
> +Interrupt-controller required properties

And so on...

> +- compatible: Should be "nuvoton,aic"
> +- reg: Should contain registers location and length
> +- interrupt-cells: set to 1
> +
> +GCR register required properties:
> +- compatible: Should be "nuvoton,gcr"
> +- reg: Should contain registers location and length
> +
> +Uart required properties:
> +- compatible: Should be "nuvoton,nuc970-uart"
> +- reg: Should contain registers location and length
