From: takasi-y@ops.dti.ne.jp (takasi-y at ops.dti.ne.jp)
Date: Tue, 8 Oct 2013 14:30:40 +0900
Subject: [PATCH v2 0/3] ARM: shmobile: kzm9d: migrate to common clock
 framework with DT
Message-ID: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series makes kzm9d to move to new clk implementation
 based on the common clock framework and device tree, when configured
 as a part of multi-platform.

These patches do not remove sh-clkfwk version, even on emev2.
Non multi-platform configuration still uses sh-clkfwk.

Should be applied and compiled on
 kernel/git/horms/renesas.git tag:renesas-devel-20131008

Confirmed for boot up to command prompt.
- kzm9d board / multi-platform + kzm9d configuration
- kzm9d board / kzm9d configuration for regression
for compilation
- ape6evm(non-multi-platform) configuration for regression.

Changes since v1:

Generally, simplified, depending on
 [PATCH 00/05] ARM: shmobile: KZM9D Multiplatform update
series posted recently by Magnus.

[PATCH 1/6] clocksource: em_sti: convert to clk_prepare/unprepare
[PATCH 2/6] serial8250-em: convert to clk_prepare/unprepare
Removed because the new base includes it.
Thank you for your review, Daniel, Greg, Laurent, and Magnus.

[PATCH 3/6] sh: clkfwk: Select sh-/common- clkfwk alternatively
Removed because "KZM9D Multiplatform update" had made this not needed.

[PATCH v2 1/3] clk: emev2: Add support for emev2 SMU clocks with DT
[PATCH v2 2/3] ARM: shmobile: emev2: Add clock tree description in DT
(was 3/6, 4/6)
Add @unit-address to smu in dts.
Reassemble patches to (.txt + .c) + .dts from .txt + (.c + .dts).
Only used when multi-platform configuration.
Extra blank line removed.

[PATCH v2 3/3] ARM: shmobile: kzm9d: Use common clock framework
(was 6/6)
No Kconfig modification because of "KZM9D Multiplatform update".


Takashi YOSHII (3):
  clk: emev2: Add support for emev2 SMU clocks with DT
  ARM: shmobile: emev2: Add clock tree description in DT
  ARM: shmobile: kzm9d: Use common clock framework

 .../devicetree/bindings/clock/emev2-clock.txt      |  98 +++++++++++++++++++
 arch/arm/boot/dts/emev2.dtsi                       |  84 +++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9d-reference.c     |   5 +-
