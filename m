From: edgar.righi@lsitec.org.br (Edgar Bernardi Righi)
Date: Tue, 4 Sep 2018 12:34:24 -0300
Subject: [PATCH v2 00/03] Add clock driver for Actions Semi S500 SoC
Message-ID: <CADHB5bAFM=Qs6f0zf6iQuYfmT-ErSwG3-2mTsLnL-MCCUw1FhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds clock support for Actions Semi Owl series S500 SoC
with relevant clock bindings and device tree info.
Updates from v1 to v2:
SoC supports were organized in alphabetical manner.
"_DELAY" suffixes were removed.
Patch generation format changed.
Commits were rebased on top of Saravanan's patches.
Changed patches ordering.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>

---
 arch/arm/boot/dts/owl-s500-cubieboard6.dts     |   8 +-
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts |   8 +-
 arch/arm/boot/dts/owl-s500-sparky.dts          |   8 +-
 arch/arm/boot/dts/owl-s500.dtsi                |  24 ++
 drivers/clk/actions/Kconfig                    |   5 +
 drivers/clk/actions/Makefile                   |   1 +
 drivers/clk/actions/owl-pll.c                  |   2 +-
 drivers/clk/actions/owl-pll.h                  |  15 +-
 drivers/clk/actions/owl-s500.c                 | 524 +++++++++++++++++++++++++
 drivers/clk/actions/owl-s700.c                 |  18 +-
 drivers/clk/actions/owl-s900.c                 |  18 +-
 include/dt-bindings/clock/actions,s500-cmu.h   |  78 ++++
 12 files changed, 664 insertions(+), 45 deletions(-)
 create mode 100644 drivers/clk/actions/owl-s500.c
 create mode 100644 include/dt-bindings/clock/actions,s500-cmu.
