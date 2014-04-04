From: gsi@denx.de (Gerhard Sittig)
Date: Fri, 4 Apr 2014 21:17:57 +0200
Subject: [PATCH v4 1/3] i2c: cadence: Document device tree bindings
In-Reply-To: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140404191757.GR11339@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-04-03 at 10:59 -0700, Soren Brinkmann wrote:
> 
> Add device tree binding documentation for the Cadence I2C controller.
> 
> [ ... ]
> 
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> @@ -0,0 +1,21 @@
> +Binding for the Cadence I2C controller
> +
> +Required properties:
> +  compatible: Compatibility string. Must be 'cdns,i2c-r1p10'.
> +  clocks: From common clock bindings. Phandle to input clock.

the usual complaint:  'clocks' items are not just phandles (your
example even suggests this); either adjust the description to
something correct, or just refer to the common clock bindings to
not duplicate their description

but I guess the I2C controller's binding should explicitly state
which clocks are required, and you might want to consider
'clock-names', too

> +
> +Optional properties:
> +  clock-frequency: Desired operating frequency, in Hz, of the bus (actual may
> +		   be lower). Defaults to 400000 if not specified.

is the value default a feature of the Linux implementation, or
consciously designed to be in the binding spec?  and I agree that
the default should be the standard I2C speed instead of fast mode

> +
> +Example:
> +
> +	i2c at e0004000 {
> +		compatible = "cdns,i2c-r1p10";
> +		clocks = <&clkc 38>;
> +		interrupts = <0 25 4>;
> +		reg = <0xE0004000 0x1000>;
> +		clock-frequency = <400000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};

use lower case hex digits, consider symbolic identifiers for
clocks and interrupt flags

the example has many more properties than the binding describes,
the additional items aren't even optional -- you might want to
refer to a few more common or general bindings


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
