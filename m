From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 Mar 2016 05:26:39 +0100
Subject: [PATCH 3/4] arm64: dts: Add dts files for LG Electronics's lg1312
 SoC
In-Reply-To: <1457323800-26904-4-git-send-email-chanho.min@lge.com>
References: <1457323800-26904-1-git-send-email-chanho.min@lge.com>
 <1457323800-26904-4-git-send-email-chanho.min@lge.com>
Message-ID: <201603070526.40020.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 March 2016, Chanho Min wrote:
> +
> +       chosen {
> +               bootargs = "root=/dev/nfs ip=dhcp";
> +       };

Can you add a stdout-path property as well, to make the console work?

Please also include an aliases node in the .dts file.

> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#define ARMV8_TIMER_IRQ_TYPE	(GIC_CPU_MASK_RAW(0x0f) | IRQ_TYPE_LEVEL_LOW)

I would leave out the macro here and instead just open-code this in the place it
is used.

	Arnd
