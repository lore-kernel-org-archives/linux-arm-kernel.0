From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 12 Mar 2015 20:53:02 +0900
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable CPU idle
In-Reply-To: <1424854103-11028-1-git-send-email-k.kozlowski@samsung.com>
References: <1424854103-11028-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <02c201d05cbb$18522220$48f66660$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski wrote:
> 
> Current Exynos CPU idle driver supports entering AFTR (Arm Off, Top
> Running) mode on Exynos 4210 (coupled), Exynos 4x12 and Exynos 5250.
> Enable it in default configuration to reduce energy consumption.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 70e5d0bdb4e4..7e0622a36da9 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -26,6 +26,8 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200
> init=/linuxrc mem=256M"
> +CONFIG_CPU_IDLE=y
> +CONFIG_ARM_EXYNOS_CPUIDLE=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
>  CONFIG_PM=y
> --

OK, will apply.

Thanks,
Kukjin
