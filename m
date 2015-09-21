From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Sep 2015 10:10:28 -0500
Subject: [PATCH v4 resend 1/2] ARM: dts: Add binding documentation for
 AXP20x pmic usb power supply
In-Reply-To: <1442752773-22635-2-git-send-email-hdegoede@redhat.com>
References: <1442752773-22635-1-git-send-email-hdegoede@redhat.com>
 <1442752773-22635-2-git-send-email-hdegoede@redhat.com>
Message-ID: <56001DE4.6060901@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2015 07:39 AM, Hans de Goede wrote:
> Add binding documentation for the usb power supply part of the AXP20x pmic.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes in v2:
> -Split out into a separate patch from the actual driver commit
> Changes in v4:
> -s/usb_power_supply/usb-power-supply/ in the dts example code
> ---
>  .../bindings/power_supply/axp20x_usb_power.txt     | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> new file mode 100644
> index 0000000..862f4a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/axp20x_usb_power.txt
> @@ -0,0 +1,34 @@
> +AXP20x USB power supply
> +
> +Required Properties:
> +-compatible: "x-powers,axp202-usb-power-supply"
> +
> +This node is a subnode of the axp20x PMIC.
> +
> +Example:
> +
> +axp209: pmic at 34 {
> +	compatible = "x-powers,axp209";
> +	reg = <0x34>;
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	regulators {
> +		x-powers,dcdc-freq = <1500>;
> +
> +		vdd_cpu: dcdc2 {
> +			regulator-always-on;
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1450000>;
> +			regulator-name = "vdd-cpu";
> +		};
> +
> +		...
> +	};
> +
> +	usb-power-supply: usb-power-supply {
> +		compatible = "x-powers,axp202-usb-power-supply";
> +	};
> +};
> 
