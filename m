From: lho@apm.com (Loc Ho)
Date: Fri, 21 Jun 2013 12:17:34 -0600
Subject: [PATCH v2 0/3] clk: Add APM X-Gene SoC clock driver
Message-ID: <1371838657-6018-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APM X-Gene SoC clock driver support. Reference,
PCP PLL, SoC PCP, and Ethernet clocks are defined via the DTS.

-v2: 
 * Make depends on ARM64
 * Fix duplicate registration

-v1 - Initial post

Loc Ho (3):
  clk: Add APM X-Gene SoC clock driver for reference, PLL, and device
    clocks.
  clk: arm64: Add DTS clock entry for APM X-Gene Storm SoC.
  Documentation: Add documentation for APM X-Gene clock binding.

 Documentation/devicetree/bindings/clock/xgene.txt |   90 ++++
 arch/arm64/boot/dts/apm-storm.dtsi                |   75 +++
 drivers/clk/Kconfig                               |    7 +
 drivers/clk/Makefile                              |    1 +
 drivers/clk/clk-xgene.c                           |  536 +++++++++++++++++++++
 5 files changed, 709 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xgene.txt
 create mode 100644 drivers/clk/clk-xgene.c
