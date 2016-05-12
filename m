From: joel@jms.id.au (Joel Stanley)
Date: Thu, 12 May 2016 16:04:24 +0930
Subject: [PATCH] ARM: aspeed: adapt defconfigs for new CONFIG_PRINTK_TIME
In-Reply-To: <1462969128-4070058-1-git-send-email-arnd@arndb.de>
References: <1462969128-4070058-1-git-send-email-arnd@arndb.de>
Message-ID: <CACPK8XeUTSF=c2jdmkQiQn2kfnVxvD00Cq_rj=COP7yL1-P-+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 9:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Commit 94ea9c7a579f ("lib, switch CONFIG_PRINTK_TIME to int") changes
> the type of CONFIG_PRINTK_TIME and adapts all existing defconfig files,
> while we add two new defconfig files with d0bc3483da87 ("arm/configs:
> Add Aspeed defconfig"), with the old type.
>
> This changes the two new defconfig files to match the other ones.
> As a result, we get harmless warnings for the arm-soc defconfig
> branch by itself, but everything will work when 4.7-rc1 is out.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I've applied this one to avoid introducing warnings in linux-next.
> I could have sorted out the ordering as well to avoid warnings
> in arm-soc/for-next, but it doesn't seem worth it as we are not
> regressing here.

Thanks Arnd.

Acked-by: Joel Stanley <joel@jms.id.au>

>
>  arch/arm/configs/aspeed_g4_defconfig | 2 +-
>  arch/arm/configs/aspeed_g5_defconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
> index ca39c04fec6b..b6e54ee9bdbd 100644
> --- a/arch/arm/configs/aspeed_g4_defconfig
> +++ b/arch/arm/configs/aspeed_g4_defconfig
> @@ -58,7 +58,7 @@ CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_FIRMWARE_MEMMAP=y
>  CONFIG_FANOTIFY=y
> -CONFIG_PRINTK_TIME=y
> +CONFIG_PRINTK_TIME=1
>  CONFIG_DYNAMIC_DEBUG=y
>  CONFIG_STRIP_ASM_SYMS=y
>  CONFIG_PAGE_POISONING=y
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 4f366b0370e9..892605167357 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -59,7 +59,7 @@ CONFIG_SERIAL_OF_PLATFORM=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_FIRMWARE_MEMMAP=y
>  CONFIG_FANOTIFY=y
> -CONFIG_PRINTK_TIME=y
> +CONFIG_PRINTK_TIME=1
>  CONFIG_DYNAMIC_DEBUG=y
>  CONFIG_STRIP_ASM_SYMS=y
>  CONFIG_PAGE_POISONING=y
> --
> 2.7.0
>
