From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 16 Sep 2010 13:50:25 +0200
Subject: [PATCH v6 1/7] wl12xx: make wl12xx.h common to both spi and sdio
In-Reply-To: <1284635762-12335-1-git-send-email-ohad@wizery.com>
References: <AANLkTikYd+TojQC-R+Vrdou6KSRwFNczBeTnsX7eTDn4@mail.gmail.com>
	<1284635762-12335-1-git-send-email-ohad@wizery.com>
Message-ID: <AANLkTim0VpLFSM3cqZ+P4+o+8v3-t1NNfi_-_qrqMkB+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Thu, Sep 16, 2010 at 1:16 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Move wl12xx.h outside of the spi-specific location,
> so it can be shared with both spi and sdio solutions.
>
> Update all users of spi/wl12xx.h accordingly
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---

This updates the first patch in the patchset.

Please tell me if you prefer me to resubmit the whole set.

Thanks,
Ohad.

> ?MAINTAINERS ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-omap2/board-omap3pandora.c ? ? | ? ?2 +-
> ?arch/arm/mach-omap2/board-rx51-peripherals.c | ? ?2 +-
> ?drivers/net/wireless/wl12xx/wl1251_sdio.c ? ?| ? ?2 +-
> ?drivers/net/wireless/wl12xx/wl1251_spi.c ? ? | ? ?2 +-
> ?drivers/net/wireless/wl12xx/wl1271_spi.c ? ? | ? ?2 +-
> ?include/linux/spi/wl12xx.h ? ? ? ? ? ? ? ? ? | ? 34 --------------------------
> ?include/linux/wl12xx.h ? ? ? ? ? ? ? ? ? ? ? | ? 34 ++++++++++++++++++++++++++
> ?8 files changed, 40 insertions(+), 40 deletions(-)
> ?delete mode 100644 include/linux/spi/wl12xx.h
> ?create mode 100644 include/linux/wl12xx.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14ab8ca..b656c14 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6416,7 +6416,7 @@ W: ? ? ? ?http://wireless.kernel.org
> ?T: ? ? git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
> ?S: ? ? Maintained
> ?F: ? ? drivers/net/wireless/wl12xx/wl1271*
> -F: ? ? include/linux/spi/wl12xx.h
> +F: ? ? include/linux/wl12xx.h
>
> ?WL3501 WIRELESS PCMCIA CARD DRIVER
> ?M: ? ? Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index dd3af2b..7ea1eb4 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -25,7 +25,7 @@
> ?#include <linux/spi/ads7846.h>
> ?#include <linux/regulator/machine.h>
> ?#include <linux/i2c/twl.h>
> -#include <linux/spi/wl12xx.h>
> +#include <linux/wl12xx.h>
> ?#include <linux/mtd/partitions.h>
> ?#include <linux/mtd/nand.h>
> ?#include <linux/leds.h>
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 9a5eb87..ce28a85 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -14,7 +14,7 @@
> ?#include <linux/input.h>
> ?#include <linux/input/matrix_keypad.h>
> ?#include <linux/spi/spi.h>
> -#include <linux/spi/wl12xx.h>
> +#include <linux/wl12xx.h>
> ?#include <linux/i2c.h>
> ?#include <linux/i2c/twl.h>
> ?#include <linux/clk.h>
> diff --git a/drivers/net/wireless/wl12xx/wl1251_sdio.c b/drivers/net/wireless/wl12xx/wl1251_sdio.c
> index c0b68b0..74ba9ce 100644
> --- a/drivers/net/wireless/wl12xx/wl1251_sdio.c
> +++ b/drivers/net/wireless/wl12xx/wl1251_sdio.c
> @@ -24,7 +24,7 @@
> ?#include <linux/mmc/sdio_func.h>
> ?#include <linux/mmc/sdio_ids.h>
> ?#include <linux/platform_device.h>
> -#include <linux/spi/wl12xx.h>
> +#include <linux/wl12xx.h>
> ?#include <linux/irq.h>
>
> ?#include "wl1251.h"
> diff --git a/drivers/net/wireless/wl12xx/wl1251_spi.c b/drivers/net/wireless/wl12xx/wl1251_spi.c
> index 334ded9..320de79 100644
> --- a/drivers/net/wireless/wl12xx/wl1251_spi.c
> +++ b/drivers/net/wireless/wl12xx/wl1251_spi.c
> @@ -24,7 +24,7 @@
> ?#include <linux/slab.h>
> ?#include <linux/crc7.h>
> ?#include <linux/spi/spi.h>
> -#include <linux/spi/wl12xx.h>
> +#include <linux/wl12xx.h>
>
> ?#include "wl1251.h"
> ?#include "wl1251_reg.h"
> diff --git a/drivers/net/wireless/wl12xx/wl1271_spi.c b/drivers/net/wireless/wl12xx/wl1271_spi.c
> index 4cb99c5..c3fdab7 100644
> --- a/drivers/net/wireless/wl12xx/wl1271_spi.c
> +++ b/drivers/net/wireless/wl12xx/wl1271_spi.c
> @@ -25,7 +25,7 @@
> ?#include <linux/module.h>
> ?#include <linux/crc7.h>
> ?#include <linux/spi/spi.h>
> -#include <linux/spi/wl12xx.h>
> +#include <linux/wl12xx.h>
> ?#include <linux/slab.h>
>
> ?#include "wl1271.h"
> diff --git a/include/linux/spi/wl12xx.h b/include/linux/spi/wl12xx.h
> deleted file mode 100644
> index a20bccf..0000000
> --- a/include/linux/spi/wl12xx.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/*
> - * This file is part of wl12xx
> - *
> - * Copyright (C) 2009 Nokia Corporation
> - *
> - * Contact: Luciano Coelho <luciano.coelho@nokia.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
> - *
> - */
> -
> -#ifndef _LINUX_SPI_WL12XX_H
> -#define _LINUX_SPI_WL12XX_H
> -
> -struct wl12xx_platform_data {
> - ? ? ? void (*set_power)(bool enable);
> - ? ? ? /* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
> - ? ? ? int irq;
> - ? ? ? bool use_eeprom;
> -};
> -
> -#endif
> diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
> new file mode 100644
> index 0000000..015687a
> --- /dev/null
> +++ b/include/linux/wl12xx.h
> @@ -0,0 +1,34 @@
> +/*
> + * This file is part of wl12xx
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + *
> + * Contact: Luciano Coelho <luciano.coelho@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#ifndef _LINUX_WL12XX_H
> +#define _LINUX_WL12XX_H
> +
> +struct wl12xx_platform_data {
> + ? ? ? void (*set_power)(bool enable);
> + ? ? ? /* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
> + ? ? ? int irq;
> + ? ? ? bool use_eeprom;
> +};
> +
> +#endif
> --
> 1.7.0.4
>
>
