From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Jun 2012 10:47:15 +0200
Subject: [PATCH v4 3/9] arm: mach-mvebu: add source files
In-Reply-To: <1340699313-29331-4-git-send-email-gregory.clement@free-electrons.com>
References: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
 <1340699313-29331-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120626084715.GC25625@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
> new file mode 100644
> index 0000000..2e98cd4
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/system-controller.c
> @@ -0,0 +1,103 @@
> +/*
> + * System controller support for Armada 370 and XP platforms.
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Lior Amsalem <alior@marvell.com>
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * The Armada 370 and Armada XP SoCs both have a range of
> + * miscellaneous registers, that do not belong to a particular device,
> + * but rather provide system-level features. This basic
> + * system-controller driver provides a device tree binding for those
> + * registers, and implements utility functions offering various
> + * features related to those registers.
> + *
> + * For now, the feature set is limited to restarting the platform by a
> + * soft-reset, but it might be extended in the future.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>
> +
> +static void __iomem *system_controller_base;
> +static void __iomem *reset_base;
> +static unsigned long rstoutn_mask_reset_out_en;
> +
> +/* System controller registers */
> +#define ARMADA_370_XP_RESET_OFFSET		  0x60
> +#define OTHER_MVEBU_RESET_OFFSET		 0x108
> +#define MVEBU_RSTOUTN_MASK_OFFSET		   0x0
> +#define   OTHER_MVEBU_RSTOUTN_MASK_RESET_OUT_EN	   0x4
> +#define   ARMADA_370_XP_RSTOUTN_MASK_RESET_OUT_EN  0x1
> +#define MVEBU_SYSTEM_SOFT_RESET_OFFSET		   0x4
> +#define   MVEBU_SYSTEM_SOFT_RESET		   0x1
> +
> +#define OTHER_MVEBU_VARIANT	1
> +#define ARMADA_370_XP_VARIANT	2

Hi Gregory

Rather than OTHER, could you call this ORION?

I think it will then work on Orion5x, dove, kirkwood and mv78xx0.

I will try to test this on Orion5x and Kirkwood.

  Thanks
	Andrew
