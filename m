From: dianders@chromium.org (Doug Anderson)
Date: Tue, 15 Jul 2014 21:41:26 -0700
Subject: [PATCH 3/6] ARM: Kconfig: set default gpio number for rockchip
 SoCs
In-Reply-To: <2242498.pAI32mTkmn@diego>
References: <1471578.ILeMmG2DL6@diego>
	<2242498.pAI32mTkmn@diego>
Message-ID: <CAD=FV=X_A09XF29Sb5Pq97aE9ehXqUR21rXFKaT2NB_P6N6yYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Jul 15, 2014 at 4:01 PM, Heiko St?bner <heiko@sntech.de> wrote:
> The new rk3288 needs a bigger gpio space, as it has 9 gpio banks.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 87b63fd..8d1dee0 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1574,6 +1574,7 @@ config ARCH_NR_GPIO
>         default 416 if ARCH_SUNXI
>         default 392 if ARCH_U8500
>         default 352 if ARCH_VT8500
> +       default 288 if ARCH_ROCKCHIP

Looks reasonable.  9 banks of 32 and that matches what's in the pinmux driver.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
