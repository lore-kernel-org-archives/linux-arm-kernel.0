From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Nov 2011 14:22:33 +0900
Subject: [PATCH 5/5] ARM: restart: plat-samsung: remove plat/reset.h and
 s5p_reset_hook
In-Reply-To: <E1RN6xd-0001ad-7r@rmk-PC.arm.linux.org.uk>
References: <20111106175457.GK12913@n2100.arm.linux.org.uk>
 <E1RN6xd-0001ad-7r@rmk-PC.arm.linux.org.uk>
Message-ID: <04f201cc9dd6$6b5beb10$4213c130$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> Now that s5p_reset_hook is unused, we can get rid of plat/reset.h and
> the s5p_reset_hook code in plat/system-reset.h.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> ---
>  arch/arm/plat-samsung/include/plat/reset.h        |   16 ----------------
>  arch/arm/plat-samsung/include/plat/system-reset.h |   11 -----------
>  2 files changed, 0 insertions(+), 27 deletions(-)
>  delete mode 100644 arch/arm/plat-samsung/include/plat/reset.h
> 
> diff --git a/arch/arm/plat-samsung/include/plat/reset.h b/arch/arm/plat-
> samsung/include/plat/reset.h
> deleted file mode 100644
> index 32ca517..0000000
> --- a/arch/arm/plat-samsung/include/plat/reset.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* linux/arch/arm/plat-samsung/include/plat/reset.h
> - *
> - * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com/
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -#ifndef __PLAT_SAMSUNG_RESET_H
> -#define __PLAT_SAMSUNG_RESET_H __FILE__
> -
> -extern void (*s5p_reset_hook)(void);
> -
> -#endif /* __PLAT_SAMSUNG_RESET_H */
> diff --git a/arch/arm/plat-samsung/include/plat/system-reset.h
b/arch/arm/plat-
> samsung/include/plat/system-reset.h
> index a448e99..73d7808 100644
> --- a/arch/arm/plat-samsung/include/plat/system-reset.h
> +++ b/arch/arm/plat-samsung/include/plat/system-reset.h
> @@ -14,18 +14,7 @@
> 
>  #include <plat/watchdog-reset.h>
> 
> -void (*s5p_reset_hook)(void);
> -
>  static void arch_reset(char mode, const char *cmd)
>  {
> -	/* SWRESET support in s5p_reset_hook() */
> -
> -	if (s5p_reset_hook)
> -		s5p_reset_hook();
> -
> -	/* Perform reset using Watchdog reset
> -	 * if there is no s5p_reset_hook()
> -	 */
> -
>  	arch_wdt_reset();
>  }
> --
> 1.7.4.4
