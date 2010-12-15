From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 16:31:11 +0100
Subject: [PATCH 1/7] msm: io: I/O register definitions for MSM8960
In-Reply-To: <1292384961-8851-2-git-send-email-stepanm@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-2-git-send-email-stepanm@codeaurora.org>
Message-ID: <201012151631.11574.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, Stepan Moskovchenko wrote:
> diff --git a/arch/arm/mach-msm/include/mach/msm_iomap.h b/arch/arm/mach-msm/include/mach/msm_iomap.h
> index 8e24dd8..4154a0a 100644
> --- a/arch/arm/mach-msm/include/mach/msm_iomap.h
> +++ b/arch/arm/mach-msm/include/mach/msm_iomap.h
> @@ -49,6 +49,8 @@
>  #include "msm_iomap-8x50.h"
>  #elif defined(CONFIG_ARCH_MSM8X60)
>  #include "msm_iomap-8x60.h"
> +#elif defined(CONFIG_ARCH_MSM8960)
> +#include "msm_iomap-8960.h"
>  #else
>  #include "msm_iomap-7x00.h"
>  #endif

As a general comment, try to make the config options like this nonexclusive,
so you can build kernels to run on multiple CPUs.

In this particular case, it's rather confusing, because one would assume
that MSM8960 is a subset of MSM8X60!

	Arnd
