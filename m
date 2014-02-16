From: plaes@plaes.org (Priit Laes)
Date: Sun, 16 Feb 2014 11:22:28 +0200
Subject: [linux-sunxi] [PATCH v6 4/8] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
In-Reply-To: <20140216051133.728.36386.stgit@dizzy-6.o2s.ch>
References: <20140216050933.728.25526.stgit@dizzy-6.o2s.ch>
 <20140216051133.728.36386.stgit@dizzy-6.o2s.ch>
Message-ID: <1392542548.11093.13.camel@chi.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?hel kenal p?eval, P, 16.02.2014 kell 06:11, kirjutas David
Lanzend?rfer:
> This is based on the driver Allwinner ships in their Android kernel sources.

[...]

> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -0,0 +1,876 @@
> +/*
> + * Driver for sunxi SD/MMC host controllers
> + * (C) Copyright 2014-2015 Reuuimlla Technology Co., Ltd.
> + * (C) Copyright 2014-2015 Aaron Maoye <leafy.myeh@reuuimllatech.com>
> + * (C) Copyright 2014-2015 O2S GmbH <www.o2s.ch>
> + * (C) Copyright 2014-2015 David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> + * (C) Copyright 2014-2015 Hans de Goede <hdegoede@redhat.com>

ETIMETRAVEL

[...]
> +++ b/drivers/mmc/host/sunxi-mmc.h
> @@ -0,0 +1,239 @@
> +/*
> + * Driver for sunxi SD/MMC host controllers
> + * (C) Copyright 2014-2015 Reuuimlla Technology Co., Ltd.
> + * (C) Copyright 2014-2015 Aaron Maoye <leafy.myeh@reuuimllatech.com>
> + * (C) Copyright 2014-2015 O2S GmbH <www.o2s.ch>
> + * (C) Copyright 2014-2015 David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> + * (C) Copyright 2014-2015 Hans de Goede <hdegoede@redhat.com>

ETIMETRAVEL

> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#ifndef __SUNXI_MCI_H__
> +#define __SUNXI_MCI_H__

__SUNXI_MMC_H__ 

> +
> +/* register offset define */

s/define/definitions

> +#define SDXC_REG_GCTRL	(0x00) /* SMC Global Control Register */
> +#define SDXC_REG_CLKCR	(0x04) /* SMC Clock Control Register */
> +#define SDXC_REG_TMOUT	(0x08) /* SMC Time Out Register */

[...]

> +#define SDXC_FIFO_RUN_ERROR		BIT(11)
> +#define SDXC_HARD_WARE_LOCKED	BIT(12)
s/HARD_WARE/HARDWARE

> +#define SDXC_START_BIT_ERROR	BIT(13)
> +#define SDXC_AUTO_COMMAND_DONE	BIT(14)
> +#define SDXC_END_BIT_ERROR		BIT(15)
> +#define SDXC_SDIO_INTERRUPT		BIT(16)
> +#define SDXC_CARD_INSERT		BIT(30)
> +#define SDXC_CARD_REMOVE		BIT(31)
> +#define SDXC_INTERRUPT_ERROR_BIT		(SDXC_RESPONSE_ERROR | SDXC_RESPONSE_CRC_ERROR | \
> +				 SDXC_DATA_CRC_ERROR | SDXC_RESPONSE_TIMEOUT | \
> +				 SDXC_DATA_TIMEOUT | SDXC_FIFO_RUN_ERROR | \
> +				 SDXC_HARD_WARE_LOCKED | SDXC_START_BIT_ERROR | \
> +				 SDXC_END_BIT_ERROR) /* 0xbbc2 */
same as above.

Also, you may want to rename SDXC_RESPONSE_* to SDXC_RESP_*, which looks
better next to the SDXC_DATA_* defines...
