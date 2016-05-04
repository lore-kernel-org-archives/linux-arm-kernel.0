From: robh@kernel.org (Rob Herring)
Date: Tue, 3 May 2016 21:22:10 -0500
Subject: [RFC v6 1/3] gpio: dt-bindings: add wd,mbl-gpio bindings
In-Reply-To: <103bf8fceb426a9c3b09641ea989955e3ec1c7d4.1462104492.git.chunkeey@googlemail.com>
References: <cover.1462104492.git.chunkeey@googlemail.com>
 <103bf8fceb426a9c3b09641ea989955e3ec1c7d4.1462104492.git.chunkeey@googlemail.com>
Message-ID: <20160504022210.GA9913@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 01, 2016 at 02:18:37PM +0200, Christian Lamparter wrote:
> This patch adds the device tree bindings for the Western Digital's
> MyBook Live memory-mapped GPIO controllers.
> 
> The gpios will be supported by gpio-mmio code of the
> GPIO generic library.
> 
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> ---
>  .../devicetree/bindings/gpio/wd,mbl-gpio.txt       | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> new file mode 100644
> index 0000000..038c3a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> @@ -0,0 +1,38 @@
> +Bindings for the Western Digital's MyBook Live memory-mapped GPIO controllers.

Are these really product level GPIOs rather than some SOC's GPIOs 
(APM?)?

> +
> +The Western Digital MyBook Live has two memory-mapped GPIO controllers.
> +Both GPIO controller only have a single 8-bit data register, where GPIO
> +state can be read and/or written.
> +
> +Required properties:
> +	- compatible: should be "wd,mbl-gpio"
> +	- reg-names: must contain
> +		"dat" - data register
> +	- reg: address + size pairs describing the GPIO register sets;
> +		order must correspond with the order of entries in reg-names
> +	- #gpio-cells: must be set to 2. The first cell is the pin number and
> +			the second cell is used to specify the gpio polarity:
> +			0 = active high
> +			1 = active low
> +	- gpio-controller: Marks the device node as a gpio controller.
> +
> +Optional properties:
> +	- no-output: GPIOs are read-only.
> +
> +Examples:
> +	gpio0: gpio0 at e0000000 {
> +		compatible = "wd,mbl-gpio";
> +		reg-names = "dat";
> +		reg = <0xe0000000 0x1>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +	};
> +
> +	gpio1: gpio1 at e0100000 {
> +		compatible = "wd,mbl-gpio";
> +		reg-names = "dat";
> +		reg = <0xe0100000 0x1>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		no-output;
> +	};
> -- 
> 2.8.1
> 
