From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 3 Apr 2012 18:33:28 -0400
Subject: [PATCH] ARM: S3C24XX: fix missing common.h in mach-s3c24xx/
In-Reply-To: <1332980074-4614-1-git-send-email-kgene.kim@samsung.com>
References: <1332980074-4614-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAP=VYLp-FwEu2AY9wWY7vygmjtZ30AMD=0h8+VtuNVZF2xtTYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 28, 2012 at 8:14 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch fixes missing mach-s3c24xx/common.h which has been
> lost when regarding s3c24xx directories merged.

Just checking that the updated version of this patch is headed
in for 3.4 -- we are still seeing the failure in linux-next builds
and it would be nice to close out the build regressions in there
as quickly as possible, since they tend to mask other regressions
from being seen.

Thanks,
Paul.
--

>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-s3c24xx/common.h | ? 23 +++++++++++++++++++++++
> ?1 files changed, 23 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-s3c24xx/common.h
>
> diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
> new file mode 100644
> index 0000000..a7cd62f
> --- /dev/null
> +++ b/arch/arm/mach-s3c24xx/common.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com
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
> +
> +#endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
> --
> 1.7.2.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
