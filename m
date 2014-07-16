From: dianders@chromium.org (Doug Anderson)
Date: Wed, 16 Jul 2014 12:57:21 -0700
Subject: [PATCH 4/6] ARM: rockchip: enable support for RK3288 SoCs
In-Reply-To: <4355781.cnmcVo5AVu@diego>
References: <1471578.ILeMmG2DL6@diego>
	<4355781.cnmcVo5AVu@diego>
Message-ID: <CAD=FV=Vp2GqwEsLt5n5176ZRvDgNLSYFSUC6G+7pV6cuATuFTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Jul 15, 2014 at 4:01 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Enable HAVE_ARM_ARCH_TIMER and add a rockchip,rk3288 compatible.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-rockchip/Kconfig    | 1 +
>  arch/arm/mach-rockchip/rockchip.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index e4564c2..d168669 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -6,6 +6,7 @@ config ARCH_ROCKCHIP
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_GIC
>         select CACHE_L2X0
> +       select HAVE_ARM_ARCH_TIMER

Do we want to think about allowing someone to enable the A9-based
Rockchip SoCs separately than the A12-based ones?  I know it doesn't
hurt to have the arch timer code present on A9 SoCs (it will figure
things out at runtime), but people trying to build an A9-based system
might not want the extra code?

Anyway, I don't feel strongly about it, so:

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
