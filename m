From: viresh.kumar@linaro.org (viresh kumar)
Date: Thu, 4 Oct 2012 14:22:58 +0530
Subject: [PATCH] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
References: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAOh2x=k3aX2VOsNTjgCT8r1Re5T66emvhSmA_MBfS0JmSN9Uqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2012 at 2:20 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>  arch/arm/plat-spear/Kconfig    | 2 ++

> diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
> index 4404f82..a090ea3 100644
> --- a/arch/arm/plat-spear/Kconfig
> +++ b/arch/arm/plat-spear/Kconfig
> @@ -14,6 +14,8 @@ config ARCH_SPEAR13XX
>         select CPU_V7
>         select USE_OF
>         select HAVE_SMP
> +       select HAVE_ARM_SCU if SMP
> +       select HAVE_ARM_TWD if LOCAL_TIMERS
>         select MIGHT_HAVE_CACHE_L2X0
>         select PINCTRL
>         help

For SPEAr:
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
