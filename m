From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 29 Mar 2012 16:28:31 +0400
Subject: [PATCH] ARM: S3C24XX: fix missing common.h in mach-s3c24xx/
In-Reply-To: <1332980074-4614-1-git-send-email-kgene.kim@samsung.com>
References: <1332980074-4614-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4F74556F.10704@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 29-03-2012 4:14, Kukjin Kim wrote:

> This patch fixes missing mach-s3c24xx/common.h which has been
> lost when regarding s3c24xx directories merged.

> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
> ---
>   arch/arm/mach-s3c24xx/common.h |   23 +++++++++++++++++++++++
>   1 files changed, 23 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-s3c24xx/common.h

> diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
> new file mode 100644
> index 0000000..a7cd62f
> --- /dev/null
> +++ b/arch/arm/mach-s3c24xx/common.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Common Header for S3C24XX SoCs
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_S3C24XX_COMMON_H
> +#define __ARCH_ARM_MACH_S3C24XX_COMMON_H
> +
> +#ifdef CONFIG_CPU_S3C2410
> +void s3c2410_restart(char mode, const char *cmd);
> +#endif
> +
> +#ifdef CONFIG_CPU_S3C244X
> +void s3c244x_restart(char mode, const char *cmd);
> +#endif

    Those #ifdef's around function prototypes are not necessary.

> +
> +#endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */

WBR, Sergei
