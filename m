From: nm@ti.com (Nishanth Menon)
Date: Mon, 16 Sep 2013 08:11:06 -0500
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
In-Reply-To: <1379277856-24571-4-git-send-email-sre@debian.org>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
Message-ID: <20130916131106.GA14873@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:44-20130915, Sebastian Reichel wrote:
> Add SSI device tree data for OMAP34xx and Nokia N900.
> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>  Documentation/devicetree/bindings/hsi/omap_ssi.txt | 73 ++++++++++++++++++++++
>  arch/arm/boot/dts/omap3-n900.dts                   |  8 +++
>  arch/arm/boot/dts/omap34xx.dtsi                    | 49 +++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hsi/omap_ssi.txt
> 
> diff --git a/Documentation/devicetree/bindings/hsi/omap_ssi.txt b/Documentation/devicetree/bindings/hsi/omap_ssi.txt
> new file mode 100644
> index 0000000..e3597eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hsi/omap_ssi.txt
> @@ -0,0 +1,73 @@
> +OMAP SSI controller bindings
> +
> +Required properties:
> +- compatible:		Should be set to the following value
> +                        ti,omap3-ssi (applicable to OMAP34xx devices)
> +- ti,hwmods:		Name of the hwmod associated to the controller, which
> +			is "ssi".
> +- reg:			Contains SSI register address range (base address and
> +			length).
> +- reg-names:		Contains the names of the address ranges. It's
> +                        expected, that "sys" and "gdd" address ranges are
> +			provided.
> +- interrupts: 		Contains the interrupt information for the controller.
> +- interrupt-names:      Contains the names of the interrupts. It's expected,
> +			that "gdd_mpu" is provided.
> +- ranges		Required as an empty node
> +- #address-cells	Should be set to <1>
> +- #size-cells		Should be set to <1>
> +
> +Each port is represented as a sub-node of the ti,omap3-ssi device.
> +
> +Required Port sub-node properties:
> +- compatible:		Should be set to the following value
> +                        ti,omap3-ssi-port (applicable to OMAP34xx devices)
> +- reg:			Contains port's register address range (base address
> +			and length).
> +- reg-names:		Contains the names of the address ranges. It's
> +                        expected, that "tx" and "rx" address ranges are
> +			provided.
> +- interrupt-parent	Should be a phandle for the interrupt controller
> +- interrupts:		Contains the interrupt information for the port.
> +- interrupt-names:	Contains the names of the interrupts. It's expected,
> +			that "mpu_irq0" and "mpu_irq1" are provided.
> +- ti,ssi-cawake-gpio:	Defines which GPIO pin is used to signify CAWAKE
> +			events for the port. This is an optional board-specific
> +			property. If it's missing the port will not be
> +			enabled.
> +
This belongs to patch which introduces SSI driver, no?
-- 
Regards,
Nishanth Menon
