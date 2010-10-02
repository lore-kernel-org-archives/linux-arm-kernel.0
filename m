From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 02 Oct 2010 19:59:52 +0900
Subject: [PATCH] ARM: S5PV210: Fix build error on pm
In-Reply-To: <1285978797-7964-1-git-send-email-sbkim73@samsung.com>
References: <1285978797-7964-1-git-send-email-sbkim73@samsung.com>
Message-ID: <014901cb6220$f2806f50$d7814df0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> This patch fixes build error by S3C2410 PM
> Suspend debug option due to undefined address
> 
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  arch/arm/mach-s5pv210/include/mach/map.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> s5pv210/include/mach/map.h
> index bd9afd5..9722042 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -57,6 +57,9 @@
> 
>  #define S5P_SZ_UART		SZ_256
> 
> +#define S3C_VA_UARTx(x)		(S3C_VA_UART + (S3C_PA_UART &
> 0xfffff) \
> +				+ ((x) * S3C_UART_OFFSET))
> +

In the case of S5PV210, no need to plus '(S3C_PA_UART & 0xfffff)'.
It is needed to keep the UART virtual address aligned to an 1MiB boundary
for the boot process to work.

In here, already aligned..so no need it.

>  #define S5PV210_PA_SROMC	(0xE8000000)
> 
>  #define S5PV210_PA_CFCON	(0xE8200000)
> --
> 1.6.2.5

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
