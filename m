From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 28 Jul 2014 22:44:36 -0700
Subject: [PATCH v3 00/15] Add Flexgen Clock support
In-Reply-To: <1405437631-23623-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1405437631-23623-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20140729054436.4906.44690@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gabriel FERNANDEZ (2014-07-15 08:20:16)
> Changes in v3:
>  - Change commit message
>  - Remove uncessary (void *) cast
>  - add a block diagram for flexgen clock binding documentation
> 
> Changes in v2:
>  - use static const for clkgen_pll_data and stm_fs tables (from
>    Peter Griffin review)
>  - add 326 and 333 Mhz frequencies
>  - cosmetic correction in st,clkgen-vcc.txt
>  - use of kcalloc instead of kzalloc in drivers/clk/st/clk-flexgen.c
> 
> The goal of this series is to add Flexgen clock support to ST SoCs.
> 
> A Flexgen clock is composed by:
>   - a clock cross bar (represented by a mux element)
>   - a pre and final dividers (represented by a divider and gate elements)

Applied to clk-next! I performed 's/drivers: //' on the $SUBJECT for
most of the patches.

Regards,
Mike

> 
> Tested on B2120 board.
> 
> Gabriel Fernandez (15):
>   clk: st: Update ST clock binding documentation
>   drivers: clk: st: use static const for stm_fs tables
>   drivers: clk: st: use static const for clkgen_pll_data tables
>   drivers: clk: st: Remove uncessary (void *) cast
>   clk: st: Adds Flexgen clock binding
>   drivers: clk: st: STiH407: Support for Flexgen Clocks
>   drivers: clk: st: STiH407: Support for A9 MUX Clocks
>   drivers: clk: st: STiH407: Support for clockgenA0
>   drivers: clk: st: Add polarity bit indication
>   drivers: clk: st: Add quadfs reset handling
>   drivers: clk: st: STiH407: Support for clockgenC0
>   drivers: clk: st: STiH407: Support for clockgenD0/D2/D3
>   drivers: clk: st: STiH407: Support for clockgenA9
>   drivers: clk: st: Update frequency tables for fs660c32 and fs432c65
>   drivers: clk: st: Use round to closest divider flag
> 
>  .../bindings/clock/st/st,clkgen-divmux.txt         |  28 +-
>  .../devicetree/bindings/clock/st/st,clkgen-mux.txt |   6 +-
>  .../devicetree/bindings/clock/st/st,clkgen-pll.txt |  17 +-
>  .../bindings/clock/st/st,clkgen-prediv.txt         |   8 +-
>  .../devicetree/bindings/clock/st/st,clkgen-vcc.txt |  34 ++-
>  .../devicetree/bindings/clock/st/st,clkgen.txt     |  59 ++--
>  .../devicetree/bindings/clock/st/st,flexgen.txt    | 119 ++++++++
>  .../devicetree/bindings/clock/st/st,quadfs.txt     |  15 +-
>  drivers/clk/st/Makefile                            |   2 +-
>  drivers/clk/st/clk-flexgen.c                       | 331 +++++++++++++++++++++
>  drivers/clk/st/clkgen-fsyn.c                       | 223 +++++++++++---
>  drivers/clk/st/clkgen-mux.c                        |  12 +-
>  drivers/clk/st/clkgen-pll.c                        |  94 +++++-
>  13 files changed, 828 insertions(+), 120 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/st/st,flexgen.txt
>  create mode 100644 drivers/clk/st/clk-flexgen.c
> 
> -- 
> 1.9.1
> 
