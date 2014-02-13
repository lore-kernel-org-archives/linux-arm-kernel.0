From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Feb 2014 07:26:43 -0600
Subject: [PATCH 02/18] arm64: GICv3 device tree binding documentation
In-Reply-To: <1391607050-540-3-git-send-email-marc.zyngier@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
 <1391607050-540-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAL_JsqJMTztbjMRj1_MDevbRHVt8FoSPKLUkXEiqKx1jkzpNOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 5, 2014 at 7:30 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Add the necessary documentation to support GICv3.
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/gic-v3.txt | 81 ++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/gic-v3.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/gic-v3.txt b/Documentation/devicetree/bindings/arm/gic-v3.txt
> new file mode 100644
> index 0000000..93852f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/gic-v3.txt
> @@ -0,0 +1,81 @@
> +* ARM Generic Interrupt Controller, version 3
> +
> +AArch64 SMP cores are often associated with a GICv3, providing private
> +peripheral interrupts (PPI), shared peripheral interrupts (SPI),
> +software generated interrupts (SGI), and locality-specific peripheral
> +Interrupts (LPI).
> +
> +Main node required properties:
> +
> +- compatible : should at least contain  "arm,gic-v3".
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. Must be a single cell with a value of at least 3.
> +
> +  The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
> +  interrupts. Other values are reserved for future use.
> +
> +  The 2nd cell contains the interrupt number for the interrupt type.
> +  SPI interrupts are in the range [0-987]. PPI interrupts are in the
> +  range [0-15].
> +
> +  The 3rd cell is the flags, encoded as follows:
> +       bits[3:0] trigger type and level flags.
> +               1 = edge triggered
> +               2 = edge triggered (deprecated, for compatibility with GICv2)
> +               4 = level triggered
> +               8 = level triggered (deprecated, for compatibility with GICv2)

I don't really think compatibility is needed here. I'd just list 1 and 4.

> +
> +  Cells 4 and beyond are reserved for future use. Where the 1st cell
> +  has a value of 0 or 1, cells 4 and beyond act as padding, and may be
> +  ignored. It is recommended that padding cells have a value of 0.

What future use? LPIs I suppose.

Otherwise, looks fine to me:

Acked-by: Rob Herring <robh@kernel.org>

Rob
