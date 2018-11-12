From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 12:57:33 -0600
Subject: [PATCH 1/3] dt-bindings: gpio: add sama5d2 PIOBU support
In-Reply-To: <1541603580-17448-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
 <1541603580-17448-2-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <5bea0ec9.1c69fb81.db750.9b4e@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 03:12:32PM +0000, Andrei.Stefanescu at microchip.com wrote:
> This patch describes the compatible and the device tree
> bindings necessary for the sama5d2 PIOBU GPIO
> controller driver.

Bindings describe the h/w, not drivers.

> 
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
> ---
>  .../bindings/gpio/gpio-sama5d2-piobu.txt           | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> new file mode 100644
> index 0000000..791ac51
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-sama5d2-piobu.txt
> @@ -0,0 +1,23 @@
> +GPIO controller for SAMA5D2 PIOBU pins.
> +
> +This pins have the property of not losing their voltage
> +during Backup/Self-refresh mode.
> +
> +These bindings should be set to a node in the dtsi file.
> +
> +Required properties:
> +- compatible:		"syscon", "microchip,sama5d2-piobu"

Why the syscon?

syscon should be last if it remains.

> +- #gpio-cells:		There are 2. The pin number is the
> +			first, the second represents additional
> +			parameters such as GPIO_ACTIVE_HIGH/LOW.
> +- gpio-controller:	Marks the port as GPIO controller.

No interrupt capability?

> +
> +Example:
> +
> +	secumod at fc040000 {

gpio at ...

> +		compatible = "syscon", "microchip,sama5d2-piobu";
> +		reg = <0xfc040000 0x100>;
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> -- 
> 2.7.4
> 
