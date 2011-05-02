From: kostap@gmail.com (Konstantin Porotchkin)
Date: Mon, 2 May 2011 17:56:48 +0300
Subject: [PATCH 1/2] Moving Marvell Dove platform defaults to ARMv7
In-Reply-To: <1302173382-25577-1-git-send-email-kostap@marvell.com>
References: <1302173382-25577-1-git-send-email-kostap@marvell.com>
Message-ID: <BANLkTikCBDCYr6BHz4zWPvHfuAQ+eCtvNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Nico,

I believe the past two patches were OK. Are you going to integrate them?

Thank you for your help
Konstantin

On Thu, Apr 7, 2011 at 1:49 PM, Konstantin Porotchkin
<kostap@marvell.com> wrote:
> Disabled legacy support for ARMv6 archtecture on Dove platform.
> Latest Dove HW uses only ARMv7 model.
>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
> ?arch/arm/Kconfig ? ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/configs/dove_defconfig | ? ?2 --
> ?2 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 599e163..e9d9a4f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -463,7 +463,7 @@ config ARCH_IXP4XX
>
> ?config ARCH_DOVE
> ? ? ? ?bool "Marvell Dove"
> - ? ? ? select CPU_V6K
> + ? ? ? select CPU_V7
> ? ? ? ?select PCI
> ? ? ? ?select ARCH_REQUIRE_GPIOLIB
> ? ? ? ?select GENERIC_CLOCKEVENTS
> diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
> index 54bf5ee..d7c3cfa 100644
> --- a/arch/arm/configs/dove_defconfig
> +++ b/arch/arm/configs/dove_defconfig
> @@ -8,8 +8,6 @@ CONFIG_MODULE_UNLOAD=y
> ?# CONFIG_BLK_DEV_BSG is not set
> ?CONFIG_ARCH_DOVE=y
> ?CONFIG_MACH_DOVE_DB=y
> -CONFIG_CPU_V6=y
> -CONFIG_CPU_32v6K=y
> ?CONFIG_NO_HZ=y
> ?CONFIG_HIGH_RES_TIMERS=y
> ?CONFIG_AEABI=y
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
