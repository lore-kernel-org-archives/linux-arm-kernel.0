From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Jul 2012 20:33:30 +0200
Subject: [PATCH 2/9] arm: mach-mvebu: add header
In-Reply-To: <1341243574-3258-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341243574-3258-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120702183330.GG1348@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/arch/arm/mach-mvebu/include/mach/uncompress.h
> @@ -0,0 +1,43 @@
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
> +#include <mach/armada-370-xp.h>
> +
> +#define UART_THR ((volatile unsigned char *)(ARMADA_370_XP_REGS_PHYS_BASE\
> +								+ 0x12000))
> +#define UART_LSR ((volatile unsigned char *)(ARMADA_370_XP_REGS_PHYS_BASE\
> +								+ 0x12014))
> +

Hi Thomas

What physical address does this come out to? All Orion platforms have
the serial port at the same place, 0xf1012000. If 370/XP is the same,
i suggest dropping this #include, hard code the address, and we share
the implementation for all SoCs. 

If however, the ASIC engineers have decided to move it, we need some
extra logic to handle different base addresses for Dove and 370/XP
which should be supportable in one kernel binary.

      Andrew
