From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 May 2013 09:26:51 -0600
Subject: [PATCH 2/5] ARM: dts: OMAP2+: create a DT header for GPIO
In-Reply-To: <1369232864-14460-3-git-send-email-florian.vaussard@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-3-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <519CE3BB.3040704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 08:27 AM, Florian Vaussard wrote:
> Define the OMAP_GPIO macro to conveniently use GPIO inside OMAP DT.
> For example:
> 
> 	gpios = <&gpio6 3 0>;  /* GPIO 163 */
> 
> can be replaced by
> 
> 	gpios = OMAP_GPIO(163, 0);

> diff --git a/include/dt-bindings/gpio/omap-gpio.h b/include/dt-bindings/gpio/omap-gpio.h

> +#define OMAP_GPIO_0_BANK        gpio1
> +#define OMAP_GPIO_1_BANK        gpio1
> +#define OMAP_GPIO_2_BANK        gpio1
> +#define OMAP_GPIO_3_BANK        gpio1

There are a /lot/ of those. Is this really worth it?

If the OMAP GPIO HW is already represented as a bunch of separate DT
nodes which represent separate GPIO blocks, then I would have thought
the syntax <&gpioN M 0> more directly represents what would be found in
the HW manual? If not, surely the DT should have a single node to
represent a single GPIO controller, which just happens to internally
support a bunch of register arrays.
