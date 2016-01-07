From: linux.amoon@gmail.com (Anand Moon)
Date: Thu, 7 Jan 2016 22:40:22 +0530
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable NEON, accelerated
 crypto and cpufreq stats
In-Reply-To: <1452132905-8587-1-git-send-email-k.kozlowski@samsung.com>
References: <1452132905-8587-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CANAwSgTJ1Gx8zHKp3F=VAwfLh-n1fs1Yd+hdc-o76tPY6L2h0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 7 January 2016 at 07:45, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> Enable the kernel NEON mode and asm/NEON accelerated crypto algorithms
> which should bring performance benefits on Exynos SoCs. Enable these as
> modules because they are optional, not essential anyhow for platform
> booting nor related directly to Exynos Soc. All accelerated algorithms
> pass booting self-tests on Odroid XU4 (Exynos5422) and Trats2 (Exynos4412).
>
> Additionally enable cpufreq statistics as they are useful for debugging.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 24dcd2bb1215..0aee1e035be9 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -26,12 +26,14 @@ CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
>  CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT_DETAILS=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_ARM_EXYNOS_CPUIDLE=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
> +CONFIG_KERNEL_MODE_NEON=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> @@ -238,7 +240,11 @@ CONFIG_DEBUG_RT_MUTEXES=y
>  CONFIG_DEBUG_SPINLOCK=y
>  CONFIG_DEBUG_MUTEXES=y
>  CONFIG_DEBUG_USER=y
> -CONFIG_CRYPTO_SHA256=y
> +CONFIG_ARM_CRYPTO=y
> +CONFIG_CRYPTO_SHA1_ARM_NEON=m
> +CONFIG_CRYPTO_SHA256_ARM=m
> +CONFIG_CRYPTO_SHA512_ARM=m
> +CONFIG_CRYPTO_AES_ARM_BS=m
>  CONFIG_CRC_CCITT=y
>  CONFIG_FONTS=y
>  CONFIG_FONT_7x14=y
> --
> 1.9.1
>

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Best Regards,
-Anand Moon
