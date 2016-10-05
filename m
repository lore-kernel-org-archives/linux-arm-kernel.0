From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 17:07:46 +0200
Subject: [PATCH 0/6] clk: oxnas: Rework driver to add support for OX820
Message-ID: <20161005150752.22618-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to to support the Oxford Semiconductor OX820 Soc clock gates,
rework the original driver with a structure inspired from the Qcom or Meson
drivers and using the new devm_clk_hw_register() call.

The first patches add dt-bindings include file to clarify the clock indices.

In future work, OX820 PLLs should also be handled by this driver.

Neil Armstrong (6):
  clk: oxnas: Add dt-bindings include file for OX810SE
  clk: oxnas: Add dt-bindings include file for OX820
  clk: oxnas: Rename to clk_oxnas_gate
  clk: oxnas: Refactor to make use of devm_clk_hw_register()
  clk: oxnas: Add OX820 Gate clocks
  dt-bindings: clk: oxnas,stdclk: Add OX820 bindings

 .../devicetree/bindings/clock/oxnas,stdclk.txt     |  19 +-
 drivers/clk/clk-oxnas.c                            | 232 ++++++++++++++-------
 include/dt-bindings/clock/oxsemi,ox810se.h         |  30 +++
 include/dt-bindings/clock/oxsemi,ox820.h           |  40 ++++
 4 files changed, 231 insertions(+), 90 deletions(-)
 create mode 100644 include/dt-bindings/clock/oxsemi,ox810se.h
 create mode 100644 include/dt-bindings/clock/oxsemi,ox820.h

-- 
2.7.0
