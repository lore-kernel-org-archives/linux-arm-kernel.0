From: serveralex@gmail.com (=?UTF-8?q?Alexander=20M=C3=BCller?=)
Date: Tue, 10 May 2016 22:08:34 +0200
Subject: [PATCH 0/6] Enable ethernet support on Amlogic meson8b / Hardkernel
 ODROID-C1
Message-ID: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes a glitch in the pinctrl driver, adds clock gates
support and configures ethernet support via stmmac.

The previously sent patch "pinctrl: meson: Fix eth_tx_en bit index" is
also included in this patch series.

Alexander M?ller (6):
  pinctrl: meson: Fix eth_tx_en bit index
  ARM: DTS: Amlogic: Add ethernet pins
  ARM: clk: Amlogic: Add support for clock gates
  ARM: clk: Amlogic: Add clk81 clock gates
  ARM: DTS: Amlogic: Enable ethernet on meson8b
  ARM: DTS: Amlogic: Enable ethernet on ODROID-C1

 arch/arm/boot/dts/meson8b-odroidc1.dts   |  10 ++
 arch/arm/boot/dts/meson8b.dtsi           |  25 ++++
 drivers/clk/meson/clkc.c                 |  18 +++
 drivers/clk/meson/clkc.h                 |  18 +++
 drivers/clk/meson/meson8b-clkc.c         | 196 +++++++++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson8b.c  |   2 +-
 include/dt-bindings/clock/meson8b-clkc.h |  99 +++++++++++++++-
 7 files changed, 365 insertions(+), 3 deletions(-)

-- 
2.5.0
