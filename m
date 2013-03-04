From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Mon, 4 Mar 2013 12:04:20 -0300
Subject: [PATCH v2 0/3] clock driver for sunxi
In-Reply-To: <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <BLU0-SMTP106AB001CEF49227B7DB3F68AFA0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 25/02/13 11:44, Emilio L?pez escribi?:
> Hello everyone,
> 
> This patchset adds basic clock support for sunxi devices. Currently, it
> implements support for the two oscillators, the main PLL, the CPU mux,
> its three divisor clocks and APB1. With this in place, it is possible to
> write a cpufreq driver and have it work, and with a little more code,
> represent the UART clocks correctly (I will be sending a separate
> patchset for this).
> 
> I have tested this driver successfully on a Cubieboard (A10, sun4i)
> using the cpufreq driver from the linux-sunxi tree after minor
> modifications (the clock names are not the same).
> 
> Any feedback will be highly appreciated
> 
> Thanks,
> 
> Emilio
> 
> Overview of changes from v1:
>   * Implement APB1
>   * Add missing glue for driver that got dropped on torvalds/master
>   * Drop "fixed gate" code and implement it with two clocks as suggested
>     by Gregory
> 
> Emilio L?pez (3):
>   clk: arm: sunxi: Add a new clock driver for sunxi SOCs
>   arm: sunxi: Add clock definitions for the new clock driver
>   arm: sunxi: Add useful information about sunxi clocks
> 
>  Documentation/arm/sunxi/clocks.txt                |  56 ++++
>  Documentation/devicetree/bindings/clock/sunxi.txt |  44 +++
>  arch/arm/boot/dts/sunxi.dtsi                      |  83 ++++-
>  drivers/clk/Makefile                              |   1 +
>  drivers/clk/sunxi/Makefile                        |   5 +
>  drivers/clk/sunxi/clk-factors.c                   | 180 +++++++++++
>  drivers/clk/sunxi/clk-factors.h                   |  27 ++
>  drivers/clk/sunxi/clk-sunxi.c                     | 362 ++++++++++++++++++++++
>  drivers/clocksource/sunxi_timer.c                 |   4 +-
>  include/linux/clk/sunxi.h                         |  22 ++
>  10 files changed, 779 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/arm/sunxi/clocks.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/sunxi.txt
>  create mode 100644 drivers/clk/sunxi/Makefile
>  create mode 100644 drivers/clk/sunxi/clk-factors.c
>  create mode 100644 drivers/clk/sunxi/clk-factors.h
>  create mode 100644 drivers/clk/sunxi/clk-sunxi.c
>  create mode 100644 include/linux/clk/sunxi.h
> 

Hello Mike,

Can I get your review on this patchset? We would like to get the base
driver merged early for 3.10, so I can continue working on new features
we will be needing for other drivers while knowing the foundations are
good to go.

Thanks!

Emilio
