From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 12 May 2014 18:06:28 +0200
Subject: [PATCH 00/12] Add Flexgen Clock support
Message-ID: <1399910800-12847-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this series is to add Flexgen clock support to ST SoCs.

A Flexgen clock is composed by:
  - a clock cross bar (represented by a mux element)
  - a pre and final dividers (represented by a divider and gate elements)

Tested on B2020 board.

Gabriel Fernandez (12):
  clk: st: Update ST clock binding documentation
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

 .../devicetree/bindings/clock/st/st,clkgen-mux.txt |   2 +-
 .../devicetree/bindings/clock/st/st,clkgen-pll.txt |   5 +-
 .../devicetree/bindings/clock/st/st,clkgen.txt     |  25 +-
 .../devicetree/bindings/clock/st/st,flexgen.txt    |  48 +++
 .../devicetree/bindings/clock/st/st,quadfs.txt     |   3 +
 drivers/clk/st/Makefile                            |   2 +-
 drivers/clk/st/clk-flexgen.c                       | 332 +++++++++++++++++++++
 drivers/clk/st/clkgen-fsyn.c                       | 175 ++++++++++-
 drivers/clk/st/clkgen-mux.c                        |  12 +-
 drivers/clk/st/clkgen-pll.c                        |  64 ++++
 10 files changed, 647 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/st/st,flexgen.txt
 create mode 100644 drivers/clk/st/clk-flexgen.c

-- 
1.9.1
