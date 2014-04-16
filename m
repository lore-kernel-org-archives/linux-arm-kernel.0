From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Apr 2014 09:59:57 +0200
Subject: [PATCH 1/2] ahci: imx: use macros to define registers and bits
In-Reply-To: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140416075957.GR5969@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 10:41:42AM +0800, Shawn Guo wrote:
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 497c7ab..39629b4 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -28,11 +28,9 @@
>  #include <linux/libata.h>
>  #include "ahci.h"
>  
> -enum {
> -	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
> -	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
> -	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
> -};
> +#define IMX_SATA_TIMER1MS			0x00e0
> +#define IMX_SATA_P0PHYCR			0x0178
> +#define  P0PHYCR_TEST_PDDQ			(1 << 20)
Did you intentionally not namespace the bit mask?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
