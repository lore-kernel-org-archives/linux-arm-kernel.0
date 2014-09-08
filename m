From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Sep 2014 10:52:50 -0700
Subject: [PATCH 10/11] ARM: rockchip: enable cpufreq-related options
In-Reply-To: <1409958374-30937-11-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
 <1409958374-30937-11-git-send-email-heiko@sntech.de>
Message-ID: <CAD=FV=X_+pmz5+eizYmHcWzKbq7h-1P=W2Lt2s2NOkP=KFzN9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Sep 5, 2014 at 4:06 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Enable ARCH_HAS_CPUFREQ and ARCH_HAS_OPP.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-rockchip/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index d168669..007e9dd 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -2,6 +2,8 @@ config ARCH_ROCKCHIP
>         bool "Rockchip RK2928 and RK3xxx SOCs" if ARCH_MULTI_V7
>         select PINCTRL
>         select PINCTRL_ROCKCHIP
> +       select ARCH_HAS_CPUFREQ
> +       select ARCH_HAS_OPP
>         select ARCH_HAS_RESET_CONTROLLER
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_GIC

This patch might be useful to folks trying to pick patches on older
kernels, but I don't think we want it to land upstream.  See:

19682f7 ARM: Remove ARCH_HAS_CPUFREQ config option
78c5e0b PM / OPP: Remove ARCH_HAS_OPP

-Doug
