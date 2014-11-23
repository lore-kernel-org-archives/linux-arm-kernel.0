From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Sun, 23 Nov 2014 13:35:05 +0530
Subject: [PATCH] arm64: enable ARCH_HAS_BANDGAP config
In-Reply-To: <1415968254-5182-1-git-send-email-a.kesavan@samsung.com>
References: <1415968254-5182-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAGOxZ52o-O+=PCsGRfKEGGc0NUg_M+z5_UmbrjBwvW8+x3c22w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

On Fri, Nov 14, 2014 at 6:00 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> Some of the existing thermal drivers (ti and exynos) have a dependency on
> ARCH_HAS_BANDGAP. Activate ARCH_HAS_BANDGAP config entry for ARM64 so that
> these drivers may be re-used.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
HAS_BANDGAP was added to ARM to indicate that arch supports a bandgap
device like a thermal management unit, so this looks good to me.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/Kconfig |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5bb1900..7c452e4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -139,6 +139,9 @@ config KERNEL_MODE_NEON
>  config FIX_EARLYCON_MEM
>         def_bool y
>
> +config ARCH_HAS_BANDGAP
> +       def_bool y
> +
>  source "init/Kconfig"
>
>  source "kernel/Kconfig.freezer"
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Regards,
Alim
