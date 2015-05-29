From: jun.nie@linaro.org (Jun Nie)
Date: Fri, 29 May 2015 10:35:46 +0800
Subject: [PATCH v5 0/4] Add basic ZTE zx296702 SOC support
Message-ID: <1432866950-5344-1-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes vs v4:
  - Fix issues in clock driver that Stephen found.
  - Remove initramfs in defconfig to avoid overriding test config.
  - Drop patches that already merged into ARM next/soc.

Jun Nie (4):
  dt-bindings: Add #defines for ZTE ZX296702 clocks
  clk: zx: add clock support to zx296702
  ARM: dts: zx: add an initial zx296702 dts and doc
  ARM: zx: Add basic defconfig support for ZX296702

 Documentation/devicetree/bindings/arm/zte.txt      |  15 +
 .../devicetree/bindings/clock/zx296702-clk.txt     |  35 ++
 Documentation/devicetree/bindings/serial/pl011.txt |   2 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/zx296702-ad1.dts                 |  48 ++
 arch/arm/boot/dts/zx296702.dtsi                    | 139 +++++
 arch/arm/configs/zx_defconfig                      | 129 ++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zte/Makefile                           |   2 +
 drivers/clk/zte/clk-pll.c                          | 184 ++++++
 drivers/clk/zte/clk-zx296702.c                     | 657 +++++++++++++++++++++
 drivers/clk/zte/clk.h                              |  32 +
 include/dt-bindings/clock/zx296702-clock.h         | 170 ++++++
 14 files changed, 1415 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/clock/zx296702-clk.txt
 create mode 100644 arch/arm/boot/dts/zx296702-ad1.dts
 create mode 100644 arch/arm/boot/dts/zx296702.dtsi
 create mode 100644 arch/arm/configs/zx_defconfig
 create mode 100644 drivers/clk/zte/Makefile
 create mode 100644 drivers/clk/zte/clk-pll.c
 create mode 100644 drivers/clk/zte/clk-zx296702.c
 create mode 100644 drivers/clk/zte/clk.h
 create mode 100644 include/dt-bindings/clock/zx296702-clock.h

-- 
1.9.1
