From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 11 Jun 2012 19:11:56 +0200
Subject: [PATCH v2 1/8] arm: mach-mvebu: add header
In-Reply-To: <1339433585-28087-2-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <1339433585-28087-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20120611171156.GA19927@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/mach-mvebu/include/mach/uncompress.h b/arch/arm/mach-mvebu/include/mach/uncompress.h
> new file mode 100644
> index 0000000..3642997
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/include/mach/uncompress.h
> @@ -0,0 +1,41 @@
> +/*
> + * Marvell Armada SoC kernel uncompression UART routines
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Lior Amsalem <alior@marvell.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <mach/mvebu.h>
> +
> +#define UART_THR ((volatile unsigned char *)(MVEBU_REGS_PHYS_BASE + 0x12000))
> +#define UART_LSR ((volatile unsigned char *)(MVEBU_REGS_PHYS_BASE + 0x12014))

All Orion's place the UART at the same physical address. So i've got
this on my TODO list, to have one implementation in plat-orion.

However, you have moved away from plat-orion, so i wounder were would
be a good place to have this?

   Andrew
