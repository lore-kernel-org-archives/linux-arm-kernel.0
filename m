From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Dec 2017 09:45:59 -0800
Subject: [RFC PATCH 2/3] pinctrl: sunxi: introduce DT-based generic driver
In-Reply-To: <20171113012523.2328-3-andre.przywara@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
 <20171113012523.2328-3-andre.przywara@arm.com>
Message-ID: <20171201174559.GR28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andre Przywara <andre.przywara@arm.com> [171113 01:28]:
> This driver (shim) allows to fully describe an Allwinner pin controller
> and its GPIO ports in device tree nodes.
> It will read some newly introduced properties to build a table
> describing the pins and their routing. This table matches those that we
> have hardcoded for various SoCs in the kernel so far.
> After this table has been created, it will be handed over to the actual
> pinctrl driver, which registers it with the pinctrl subsystem.

Hmm so how come you're not using GENERIC_PINCTRL_GROUPS and
GENERIC_PINMUX_FUNCTIONS that we now have?

These together with the #pinctrl-cells property should make things
quite easy and should also simplify your binding hopefully.

Regards,

Tony
