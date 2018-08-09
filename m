From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Aug 2018 04:57:48 +0200
Subject: [PATCH v2 3/7] drivers: gpio: Add support for GPIOs over Moxtet
 bus
In-Reply-To: <20180809022037.12001-4-marek.behun@nic.cz>
References: <20180809022037.12001-1-marek.behun@nic.cz>
 <20180809022037.12001-4-marek.behun@nic.cz>
Message-ID: <20180809025748.GD6884@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
> @@ -0,0 +1,31 @@
> +Turris Mox Moxtet GPIO expander
> +
> +Required properties:
> + - compatible		: Should be "cznic,moxtet-gpio".
> + - gpio-controller	: Marks the device node as a GPIO controller.
> + - #gpio-cells		: Should be two. For consumer use see gpio.txt.
> + - moxtet,input-mask	: Bitmask. Those bits which correspond to input GPIOs
> +			  when read from Moxtet bus should be set here.
> +			  For example if bit 0 and bit 3 are input GPIO bits,
> +			  this should be set to 0x9.
> +			  Since there are only 4 input bits, 0xf is max value.
> + - moxtet,output-mask	: Bitmask. Those bits which correspond to output GPIOs
> +			  when written to Moxtet bus should be set here.
> +			  For example if bit 1 and bit 6 are output GPIO bits,
> +			  this should be set to 0x41.
> +			  Since there are at most 8 output bits, 0xff is max
> +			  value.

Lets see what Rob says, but i don't know if it should be so generic.

The SFP module probably has GPO's for tx-disable and rate-select, and
GPI for mod-def0, LOS. So you can have a compatible for this, and have
the bit masks associated to the compatible string. Don't put the masks
in the device tree.

   Andrew
