From: dianders@chromium.org (Doug Anderson)
Date: Fri, 19 Jun 2015 08:24:21 -0700
Subject: [PATCH] ARM: dts: rockchip: fix rk3288 watchdog irq
In-Reply-To: <1961157.dsytR1KvKa@phil>
References: <1961157.dsytR1KvKa@phil>
Message-ID: <CAD=FV=U3AQY1y6PJP4uBzqBgBkX3GdKtN7iLjGv62w4eZ3W2bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Jun 19, 2015 at 7:31 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> The watchdog irq is actually SPI 79, which translates to the original
> 111 in the manual where the SPI irqs start at 32.
> The current dw_wdt driver does not use the irq at all, so this issue
> never surfaced. Nevertheless fix this for a time we want to use the irq.
>
> Fixes: 2ab557b72d46 ("ARM: dts: rockchip: add core rk3288 dtsi")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Found while verifying the data for the quite similar rk3368 arm64 soc.
>
>  arch/arm/boot/dts/rk3288.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

* gpio0 shows up in TRM as 113
* gpio0 is in dts as SPI 81
* wdt shows up in TRM as 111
* so wdt should be in dts as SPI 79

...so yup.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
