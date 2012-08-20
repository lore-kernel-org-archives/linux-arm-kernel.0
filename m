From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 20 Aug 2012 13:43:20 +0200
Subject: [PATCH] ARM: Kirkwood: Iomega_IX2_200 DT support Signed-off-by:
 Alan M Butler <alanbutty12@gmail.com>
In-Reply-To: <1d07faa52b5ca4453c7eaa7c9decb01af92ee648.1345459608.git.alanbutty12@gmail.com>
References: <cover.1345459608.git.alanbutty12@gmail.com>
 <1d07faa52b5ca4453c7eaa7c9decb01af92ee648.1345459608.git.alanbutty12@gmail.com>
Message-ID: <20120820114320.GB26837@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan

Overall this is looking good.

Just a few minor comments below.

> diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> new file mode 100644
> index 0000000..0c78752
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> @@ -0,0 +1,79 @@
> +/*
> + * arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> + *
> + * Iomega StorCenter ix2-200
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/irq.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/ata_platform.h>
> +#include <linux/mv643xx_eth.h>
> +#include <linux/ethtool.h>
> +#include <net/dsa.h>
> +#include <linux/gpio.h>
> +#include <linux/leds.h>
> +#include <linux/i2c.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/kirkwood.h>
> +#include "common.h"
> +#include "mpp.h"

It would be good to remove all the unneeded include files.

> +
> +static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
> +	.phy_addr       = MV643XX_ETH_PHY_NONE,
> +	.speed          = SPEED_1000,
> +	.duplex         = DUPLEX_FULL,
> +};

It is somewhat unusual to have this configuration, 1000 full. Is this
a hardware limitation? Or is the port connected to an internal switch?
Maybe add a comment why its hard coded.

      Andrew
