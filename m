From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 7 May 2014 13:20:44 +0300
Subject: [PATCH v2 0/4] clk: Add clock driver for DRA7 ATL (Audio Tracking
 Logic)
Message-ID: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes since v1:
- ATL binding documentation and driver has been separated.

Audio Tracking Logic is designed to be used by HD Radio applications to
synchronize the audio output clocks to the baseband clock. ATL can be also
used to track errors between two reference clocks (BWS, AWS) and generate a modulated
clock output which averages to some desired frequency.
In essence ATL is generating a clock to be used by an audio codec and also
to be used by the SoC as MCLK.

The series will correct atl related clock names, adds binding documentation and
corresponding driver for the ATL and integrates the ATL clock into the clock
tree.

V1 of the ATL series:
https://lkml.org/lkml/2014/4/2/238

Regards,
Peter
---
Peter Ujfalusi (4):
  ARM: dts: dra7xx-clocks: Correct name for atl clkin3 clock
  dt:/bindings: DRA7 ATL (Audio Tracking Logic) clock bindings
  clk: ti: Driver for DRA7 ATL (Audio Tracking Logic)
  ARM: DTS: dra7/dra7xx-clocks: ATL related changes

 .../devicetree/bindings/clock/ti/dra7-atl.txt      |  97 +++++++
 arch/arm/boot/dts/dra7.dtsi                        |  11 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  38 +--
 drivers/clk/ti/Makefile                            |   3 +-
 drivers/clk/ti/clk-7xx.c                           |   2 +-
 drivers/clk/ti/clk-dra7-atl.c                      | 313 +++++++++++++++++++++
 include/dt-bindings/clk/ti-dra7-atl.h              |  40 +++
 7 files changed, 483 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/dra7-atl.txt
 create mode 100644 drivers/clk/ti/clk-dra7-atl.c
 create mode 100644 include/dt-bindings/clk/ti-dra7-atl.h

-- 
1.9.2
