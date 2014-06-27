From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 27 Jun 2014 15:24:57 +0200
Subject: [PATCH v2 00/14] Add Flexgen Clock support
Message-ID: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
 - use static const for clkgen_pll_data and stm_fs tables (from
   Peter Griffin review)
 - add 326 and 333 Mhz frequencies
 - cosmetic correction in st,clkgen-vcc.txt
 - use of kcalloc instead of kzalloc in drivers/clk/st/clk-flexgen.c

The goal of this series is to add Flexgen clock support to ST SoCs.

A Flexgen clock is composed by:
  - a clock cross bar (represented by a mux element)
  - a pre and final dividers (represented by a divider and gate elements)

Tested on B2120 board.

Gabriel Fernandez (14):
  clk: st: Update ST clock binding documentation
  drivers: clk: st: use static const for stm_fs tables
  drivers: clk: st: use static const for clkgen_pll_data tables
  clk: st: Adds Flexgen clock binding
  drivers: clk: st: STiH407: Support for Flexgen Clocks
  drivers: clk: st: STiH407: Support for A9 MUX Clocks
  drivers: clk: st: STiH407: Support for clockgenA0
  drivers: clk: st: Add polarity bit indication
  drivers: clk: st: Add quadfs reset handling
  drivers: clk: st: STiH407: Support for clockgenC0
  drivers: clk: st: STiH407: Support for clockgenD0/D2/D3
  drivers: clk: st: STiH407: Support for clockgenA9
  drivers: clk: st: Update frequency tables for fs660c32 and fs432c65
  drivers: clk: st: Use round to closest divider flag

 .../bindings/clock/st/st,clkgen-divmux.txt         |  28 +-
 .../devicetree/bindings/clock/st/st,clkgen-mux.txt |   6 +-
 .../devicetree/bindings/clock/st/st,clkgen-pll.txt |  17 +-
 .../bindings/clock/st/st,clkgen-prediv.txt         |   8 +-
 .../devicetree/bindings/clock/st/st,clkgen-vcc.txt |  34 ++-
 .../devicetree/bindings/clock/st/st,clkgen.txt     |  59 ++--
 .../devicetree/bindings/clock/st/st,flexgen.txt    |  48 +++
 .../devicetree/bindings/clock/st/st,quadfs.txt     |  15 +-
 drivers/clk/st/Makefile                            |   2 +-
 drivers/clk/st/clk-flexgen.c                       | 332 +++++++++++++++++++++
 drivers/clk/st/clkgen-fsyn.c                       | 211 +++++++++++--
 drivers/clk/st/clkgen-mux.c                        |  12 +-
 drivers/clk/st/clkgen-pll.c                        |  94 +++++-
 13 files changed, 750 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/st/st,flexgen.txt
 create mode 100644 drivers/clk/st/clk-flexgen.c

-- 
1.9.1
