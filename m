From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 14 Nov 2013 11:10:35 -0800
Subject: [PATCH v3 0/8] Update Kona drivers to use clocks
Message-ID: <1384456243-27053-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series declares the clocks present on bcm11351 (aka bcm281xx) SoCs
to be fixed at the rates configured by development bootloaders and then
updates the Kona drivers to make use of clock calls where appropriate.

Changes in v3:
  - Updated the commit message for the UART DTS change
  - Added a patch to change the kona timer binding doc
  - Updated the commit message for the kona timer driver change
  - Updated the panic message in the kona timer driver
  - Added a patch to change the kona sdhci binding doc
  - Moved the SDHCI driver change earlier in the series
  - Removed unrelated change from SDHCI driver patch

Changes in v2:
  - Renamed bsc4_clk to pmu_bsc_clk

Tim Kryger (8):
  ARM: dts: Declare clocks as fixed on bcm11351
  ARM: dts: Specify clocks for UARTs on bcm11351
  Documentation: dt: kona-sdhci: Add clocks property
  ARM: dts: Specify clocks for SDHCIs on bcm11351
  mmc: sdhci-bcm-kona: Add basic use of clocks
  Documentation: dt: kona-timer: Add clocks property
  clocksource: kona: Add basic use of external clock
  ARM: dts: Specify clocks for timer on bcm11351

 .../devicetree/bindings/arm/bcm/kona-timer.txt     |   8 +-
 .../devicetree/bindings/mmc/kona-sdhci.txt         |   5 +
 arch/arm/boot/dts/bcm11351.dtsi                    | 111 ++++++++++++++++++++-
 drivers/clocksource/bcm_kona_timer.c               |  14 ++-
 drivers/mmc/host/sdhci-bcm-kona.c                  |  28 +++++-
 5 files changed, 156 insertions(+), 10 deletions(-)

-- 
1.8.0.1
