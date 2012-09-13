From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Sep 2012 15:20:54 -0500
Subject: [PATCH v3 2/5] Documentation: add description of DT binding for
 the gpio-mvebu driver
In-Reply-To: <1347551658-24449-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347551658-24449-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <50524026.20104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 10:54 AM, Thomas Petazzoni wrote:
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> ---

Grant is pretty much offline right now.

Acked-by: Rob Herring <rob.herring@calxeda.com>

>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |   45 ++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> new file mode 100644
> index 0000000..595be9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> @@ -0,0 +1,45 @@
> +* Marvell EBU GPIO controller
> +
> +Required properties:
> +
> +- compatible : Should be "marvell,orion-gpio", "marvell,mv78200-gpio"
> +  or "marvell,armadaxp-gpio". "marvell,orion-gpio" should be used for
> +  Orion, Kirkwood, Dove, Discovery (except MV78200) and Armada
> +  370. "marvell,mv78200-gpio" should be used for the Discovery
> +  MV78200. "marvel,armadaxp-gpio" should be used for all Armada XP
> +  SoCs (MV78230, MV78260, MV78460).
> +
> +- reg: Address and length of the register set for the device. Only one
> +  entry is expected, except for the "marvell,armadaxp-gpio" variant
> +  for which two entries are expected: one for the general registers,
> +  one for the per-cpu registers.
> +
> +- interrupts: The list of interrupts that are used for all the pins
> +  managed by this GPIO bank. There can be more than one interrupt
> +  (example: 1 interrupt per 8 pins on Armada XP, which means 4
> +  interrupts per bank of 32 GPIOs).
> +
> +- interrupt-controller: identifies the node as an interrupt controller
> +
> +- #interrupt-cells: specifies the number of celles needed to encode an
> +   interrupt source
> +
> +- gpio-controller: marks the device node as a gpio controller
> +
> +- ngpios: number of GPIOs this controller has
> +
> +- #gpio-cells: Should be two. The first is the pin number. The second
> +   is reserved for flags, unused at the moment.
> +
> +Example:
> +
> +		gpio0: gpio at d0018100 {
> +			compatible = "marvell,armadaxp-gpio";
> +			reg = <0xd0018100 0x40>,
> +			    <0xd0018800 0x30>;
> +			ngpios = <32>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			interrupts = <16>, <17>, <18>, <19>;
> +		};
> 
