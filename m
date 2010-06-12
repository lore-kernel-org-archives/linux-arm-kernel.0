From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 12 Jun 2010 17:16:58 +0800
Subject: [PATCH 3/3] wm97xx_batt: Remove redundant header file
In-Reply-To: <1275613654-23918-3-git-send-email-marek.vasut@gmail.com>
References: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
	<1275613654-23918-3-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTimb6TqQLLHDLI_qInwScZUQpYIDxNymE8SUh_9J@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 4, 2010 at 9:07 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?include/linux/wm97xx_batt.h | ? 16 ----------------
> ?1 files changed, 0 insertions(+), 16 deletions(-)
> ?delete mode 100644 include/linux/wm97xx_batt.h
>
> diff --git a/include/linux/wm97xx_batt.h b/include/linux/wm97xx_batt.h
> deleted file mode 100644
> index a1d6419..0000000
> --- a/include/linux/wm97xx_batt.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#ifndef _LINUX_WM97XX_BAT_H
> -#define _LINUX_WM97XX_BAT_H
> -
> -#include <linux/wm97xx.h>
> -
> -#warning This file will be removed soon, use wm97xx.h instead!
> -
> -#define wm97xx_batt_info wm97xx_batt_pdata
> -
> -#ifdef CONFIG_BATTERY_WM97XX
> -void wm97xx_bat_set_pdata(struct wm97xx_batt_info *data);
> -#else
> -static inline void wm97xx_bat_set_pdata(struct wm97xx_batt_info *data) {}
> -#endif
> -
> -#endif

A git grep of wm97xx_batt.h shows:

drivers/power/wm97xx_battery.c:/* The interface is deprecated, as well
as linux/wm97xx_batt.h */

So you may want to remove that part as well. Otherwise looks good to me.
