From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 May 2010 09:10:51 +0200
Subject: [PATCH 14/16] arm/mx3/mx31_3ds: fold board header in its only user
In-Reply-To: <1274730951-29106-14-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>
	<1274730951-29106-14-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100525071051.GH17272@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 09:55:49PM +0200, Uwe Kleine-K?nig wrote:
> Moreover remove unused definitions.

The patch does not match the subject. Are there hunks missing?

Sascah

> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mx3/mach-mx31_3ds.c |   41 +++++++++++++++++++++++++++++++-----
>  1 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
> index f54af1e..7ec2e81 100644
> --- a/arch/arm/mach-mx3/mach-mx31_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
> @@ -41,12 +41,41 @@
>  #include <mach/spi.h>
>  #include "devices.h"
>  
> -/*!
> - * @file mx31_3ds.c
> - *
> - * @brief This file contains the board-specific initialization routines.
> - *
> - * @ingroup System
> +/* Definitions for components on the Debug board */
> +
> +/* Base address of CPLD controller on the Debug board */
> +#define DEBUG_BASE_ADDRESS		CS5_IO_ADDRESS(MX3x_CS5_BASE_ADDR)
> +
> +/* LAN9217 ethernet base address */
> +#define LAN9217_BASE_ADDR		MX3x_CS5_BASE_ADDR
> +
> +/* CPLD config and interrupt base address */
> +#define CPLD_ADDR			(DEBUG_BASE_ADDRESS + 0x20000)
> +
> +/* status, interrupt */
> +#define CPLD_INT_STATUS_REG		(CPLD_ADDR + 0x10)
> +#define CPLD_INT_MASK_REG		(CPLD_ADDR + 0x38)
> +#define CPLD_INT_RESET_REG		(CPLD_ADDR + 0x20)
> +/* magic word for debug CPLD */
> +#define CPLD_MAGIC_NUMBER1_REG		(CPLD_ADDR + 0x40)
> +#define CPLD_MAGIC_NUMBER2_REG		(CPLD_ADDR + 0x48)
> +/* CPLD code version */
> +#define CPLD_CODE_VER_REG		(CPLD_ADDR + 0x50)
> +/* magic word for debug CPLD */
> +#define CPLD_MAGIC_NUMBER3_REG		(CPLD_ADDR + 0x58)
> +
> +/* CPLD IRQ line for external uart, external ethernet etc */
> +#define EXPIO_PARENT_INT	IOMUX_TO_IRQ(MX31_PIN_GPIO1_1)
> +
> +#define MXC_EXP_IO_BASE		(MXC_BOARD_IRQ_START)
> +#define MXC_IRQ_TO_EXPIO(irq)	((irq) - MXC_EXP_IO_BASE)
> +
> +#define EXPIO_INT_ENET		(MXC_EXP_IO_BASE + 0)
> +
> +#define MXC_MAX_EXP_IO_LINES	16
> +
> +/*
> + * This file contains the board-specific initialization routines.
>   */
>  
>  static int mx31_3ds_pins[] = {
> -- 
> 1.7.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
