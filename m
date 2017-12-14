From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 14 Dec 2017 11:03:46 +0100
Subject: [PATCH v7 0/6] add clk controller driver for Meson-AXG SoC
In-Reply-To: <20171211141348.22048-1-yixun.lan@amlogic.com>
References: <20171211141348.22048-1-yixun.lan@amlogic.com>
Message-ID: <1513245826.32163.7.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 22:13 +0800, Yixun Lan wrote:
> Qiufang Dai (3):
>   clk: meson-axg: add clocks dt-bindings required header
>   clk: meson-axg: add clock controller drivers
>   arm64: dts: meson-axg: add clock DT info for Meson AXG SoC
> 
> Yixun Lan (3):
>   clk: meson: make the spinlock naming more specific
>   dt-bindings: clock: add compatible variant for the Meson-AXG
>   arm64: dts: meson-axg: switch uart_ao clock to CLK81
> 
>  .../bindings/clock/amlogic,gxbb-clkc.txt           |   7 +-
>  arch/arm64/Kconfig.platforms                       |   1 +
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |   2 +
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi         |  19 +-
>  drivers/clk/meson/Kconfig                          |   8 +
>  drivers/clk/meson/Makefile                         |   1 +
>  drivers/clk/meson/axg.c                            | 936 +++++++++++++++++++++
>  drivers/clk/meson/axg.h                            | 126 +++
>  drivers/clk/meson/clkc.h                           |   2 +-
>  drivers/clk/meson/gxbb.c                           | 112 +--
>  drivers/clk/meson/meson8b.c                        |  24 +-
>  include/dt-bindings/clock/axg-clkc.h               |  71 ++
>  12 files changed, 1234 insertions(+), 75 deletions(-)
>  create mode 100644 drivers/clk/meson/axg.c
>  create mode 100644 drivers/clk/meson/axg.h
>  create mode 100644 include/dt-bindings/clock/axg-clkc.h

Kevin, 

I took the first 4 patches through clk-meson. I left the last 2 for you.

I have applied the DT bindings update separately.
Let me know if you have dependency on these new bindings and need a tag.

Cheers
Jerome
