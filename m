From: lho@apm.com (Loc Ho)
Date: Wed, 26 Jun 2013 11:56:08 -0600
Subject: [PATCH v5 0/3] clk: Add APM X-Gene SoC clock driver
Message-ID: <1372269371-22992-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds APM X-Gene SoC clock driver support. Reference,
PCP PLL, SoC PCP, and Ethernet clocks are defined via the DTS.

-v5:
 * Remove duplicate code for soc/pcp clk init function
 * Remove un-used flags field from structure
 * Merge error handler code for device clock init function
 * Update binding documentation

-v4:
 * Remove flags from DTS and check status instead
 * Change DTS reg entry to be identified by reg-names property

-v3:
 * Make DTS compatible type for SoC PLL and PCP PLL
 * Make use of of_iomap instead direct ioremap call
 * Make kzalloc with variable instead structure
 * Remove DTS binding for fixed-clock and fixed_factor_clock
 * Remove unnecessary arch_initcall

-v2:
 * Make depends on ARM64
 * Fix duplicate registration

-v1 - Initial post 

Loc Ho (3):
  clk: Add APM X-Gene SoC clock driver for reference, PLL, and device
    clocks.
  clk: arm64: Add DTS clock entry for APM X-Gene Storm SoC with
    reference to
  Documentation: Add documentation for APM X-Gene clock binding with
    PLL and

 Documentation/devicetree/bindings/clock/xgene.txt |  111 +++++
 arch/arm64/boot/dts/apm-storm.dtsi                |   75 +++
 drivers/clk/Kconfig                               |    7 +
 drivers/clk/Makefile                              |    1 +
 drivers/clk/clk-xgene.c                           |  521 +++++++++++++++++++++
 5 files changed, 715 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/xgene.txt
 create mode 100644 drivers/clk/clk-xgene.c
