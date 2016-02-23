From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 23 Feb 2016 09:03:08 +0900
Subject: [PATCH 2/3] ARM: EXYNOS: remove unused register offset definition
In-Reply-To: <1456135396-17767-3-git-send-email-pankaj.dubey@samsung.com>
References: <1456135396-17767-1-git-send-email-pankaj.dubey@samsung.com>
 <1456135396-17767-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <56CBA1BC.4050003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.02.2016 19:03, Pankaj Dubey wrote:
> This patch cleans up map.h by removing unused register offset
> and changing EXYNOS4 to EXYNOS in header comment section.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/map.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index 351e839..c48ba4f 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -2,7 +2,7 @@
>   * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com/
>   *
> - * EXYNOS4 - Memory map definitions
> + * EXYNOS - Memory map definitions
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -14,12 +14,6 @@
>  
>  #include <plat/map-base.h>
>  
> -/*
> - * EXYNOS4 UART offset is 0x10000 but the older S5P SoCs are 0x400.
> - * So need to define it, and here is to avoid redefinition warning.
> - */
> -#define S3C_UART_OFFSET			(0x10000)
> -
>  #include <plat/map-s5p.h>

This does not look good. The S3C_UART_OFFSET is used in plat/map-s5p.h.

Best regards,
Krzysztof
