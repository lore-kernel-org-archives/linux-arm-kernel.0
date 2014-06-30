From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Jun 2014 10:48:54 +0100
Subject: [PATCH v7 1/6] mfd: AXP20x: Add bindings documentation
In-Reply-To: <1404066237-20234-2-git-send-email-carlo@caione.org>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
 <1404066237-20234-2-git-send-email-carlo@caione.org>
Message-ID: <20140630094854.GY7262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 07:23:52PM +0100, Carlo Caione wrote:
> Bindings documentation for the AXP20x driver. In this file also
> sub-nodes are documented.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 93 ++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> new file mode 100644
> index 0000000..cc9e01b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -0,0 +1,93 @@
> +AXP202/AXP209 device tree bindings
> +
> +The axp20x family current members :-
> +axp202 (X-Powers)
> +axp209 (X-Powers)
> +
> +Required properties:
> +- compatible: "x-powers,axp202" or "x-powers,axp209"
> +- reg: The I2C slave address for the AXP chip
> +- interrupt-parent: The parent interrupt controller
> +- interrupts: Interrupt specifiers for interrupt sources

How many, what are they?

> +- interrupt-controller: axp20x has its own internal IRQs
> +- #interrupt-cells: Should be set to 1
> +- acin-supply: The input supply for LDO1
> +- vin2-supply: The input supply for DCDC2
> +- vin3-supply: The input supply for DCDC3
> +- ldo24in-supply: The input supply for LDO2, LDO4
> +- ldo3in-supply: The input supply for LDO3
> +- ldo5in-supply: The input supply for LDO5
> +
> +- regulators: A node that houses a sub-node for each regulator. The regulators are
> +	      bound using their name as listed here: dcdc2, dcdc3, ldo1, ldo2,
> +	      ldo3, ldo4, ldo5.  The bindings details of individual regulator
> +	      device can be found in:
> +	      Documentation/devicetree/bindings/regulator/regulator.txt with
> +	      the exception of x-powers,dcdc-freq
> +- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
> +		      (range: 750-1875). Default: 1.5MHz
> +
> +Optional properties for DCDCs:
> +- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO mode
> +			  Default: AUTO mode

When would I want to select PWM mode, and why should this be in the DT?

Thanks,
Mark.
