From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 27 Mar 2018 11:21:49 +0200
Subject: [PATCH 0/3] clk: meson: drop unnecessary AO clock flags
In-Reply-To: <20180326081809.49493-1-yixun.lan@amlogic.com>
References: <20180326081809.49493-1-yixun.lan@amlogic.com>
Message-ID: <1522142509.2632.42.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-03-26 at 16:18 +0800, Yixun Lan wrote:
>   This first two patches will drop unnecessary flags for
> the AO clock driver.
>   The third DTS patch is a follow-up fix for the second patch,
> and I've tested them on P200, P212, Q200, S400 boards.
> 
>  Note: this patch series was made on top of patch [0]
> 
> [0] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan at amlogic.com
> 
> Yixun Lan (3):
>   clk: meson: drop CLK_SET_RATE_PARENT flag
>   clk: meson: drop CLK_IGNORE_UNUSED flag
>   ARM64: dts: meson: fix clock source of the pclk for UART_AO

Please add patch 1 and 2 to the next version of your clkc_ao series

Patch 3 should sent independently to Kevin, with note warning about the
different dependencies (see comment in patch 3)

> 
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 4 ++--
>  drivers/clk/meson/axg-aoclk.c               | 1 -
>  drivers/clk/meson/gxbb-aoclk.c              | 1 -
>  5 files changed, 6 insertions(+), 8 deletions(-)
> 
