From: dianders@chromium.org (Doug Anderson)
Date: Tue, 15 Jul 2014 21:13:10 -0700
Subject: [PATCH 2/6] ARM: rockchip: add debug uart used by rk3288
In-Reply-To: <2866950.oXmKFGy9mh@diego>
References: <1471578.ILeMmG2DL6@diego>
	<2866950.oXmKFGy9mh@diego>
Message-ID: <CAD=FV=W3aWeT3RP5_g9r8kV8ToeHfyn57JY-py2zGVW9DF_7RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Jul 15, 2014 at 4:00 PM, Heiko St?bner <heiko@sntech.de> wrote:
> The uarts on rk3288 are still compatible with the dw_8250, but located
> at a different position and need DEBUG_UART_8250_WORD enabled.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/Kconfig.debug | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 8f90595..f68def0 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -613,6 +613,14 @@ choice
>                   Say Y here if you want kernel low-level debugging support
>                   on Rockchip based platforms.
>
> +       config DEBUG_RK32_UART2

It's slightly confusing that you didn't rename the old "DEBUG_RK3X_UART2".

Other than that:

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
