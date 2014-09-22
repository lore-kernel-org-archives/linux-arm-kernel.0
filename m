From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Mon, 22 Sep 2014 10:04:49 +0530
Subject: [PATCH v5 0/8] arch: arm64: Enable support for Samsung Exynos7 SoC
Message-ID: <1411360497-17958-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v4:
- Fixed comments from Tomasz Figa:
	- Changed the namespace prefix from exynos to samsung
	- Defined bindings to take all input clocks
	- Sorted the Kconfig entries alphabetically in clock Makefile
	- Used consistent 1 tab line breaks across the clock file
	- Statically initialized the samsung_cmu_info struct
- Enabled exynos7 in the arm64 defconfig as per Catalin Marinas' comment.
- Added Kukjin Kim's ack along with Thomas Abraham's tested and reviewed tags.

Changes since v3:
- Removed aliases for serial controllers from dtsi file and moved it
  into board specific dts file as suggested by Arnd.
- Based this series on Robert Richter's patches for adding vendor
  device tree sub-directories for arm64.
  http://comments.gmane.org/gmane.linux.kbuild.devel/12131

This patchset supports the new Exynos7 Samsung SoC based on Cortex-A57.
Exynos7 is a System-On-Chip (SoC) that is based on 64-bit ARMv8 RISC
processor.

The following patches are tested based on linux-next tree (20140919).
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/

Following patches are required for this series:
1- "tty/serial: fix config dependencies for samsung serial"
   https://www.mail-archive.com/linux-samsung-soc <at> vger.kernel.org/msg36208.html
2- "dts, kbuild: Implement support for dtb vendor subdirs" patchset 
   http://comments.gmane.org/gmane.linux.kbuild.devel/12131

Alim Akhtar (2):
  arm64: exynos7: Enable ARMv8 based Exynos7 (SoC) support
  arm64: Enable Exynos7 SOC in the defconfig

Naveen Krishna Chatradhi (5):
  clk: samsung: add support for 145xx and 1460x PLLs
  clk: samsung: Factor out the common code to clk.c
  clk: samsung: Add fixed_factor_clocks field to struct exynos_cmu_info
  clk: samsung: add initial clock support for Exynos7 SoC
  arm64: dts: Add initial device tree support for EXYNOS7

Pankaj Dubey (1):
  arm64: dts: add <dt-bindings/> symlink

 .../devicetree/bindings/clock/exynos7-clock.txt    |  67 ++++
 arch/arm64/Kconfig                                 |  12 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/exynos/Makefile                |   5 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  39 ++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            | 183 +++++++++
 arch/arm64/boot/dts/include/dt-bindings            |   1 +
 arch/arm64/configs/defconfig                       |   4 +
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-exynos5260.c               | 185 ++-------
 drivers/clk/samsung/clk-exynos7.c                  | 425 +++++++++++++++++++++
 drivers/clk/samsung/clk-pll.c                      |  25 +-
 drivers/clk/samsung/clk-pll.h                      |   4 +
 drivers/clk/samsung/clk.c                          |  98 +++++
 drivers/clk/samsung/clk.h                          |  37 ++
 include/dt-bindings/clock/exynos7-clk.h            |  49 +++
 16 files changed, 972 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos7-clock.txt
 create mode 100644 arch/arm64/boot/dts/exynos/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi
 create mode 120000 arch/arm64/boot/dts/include/dt-bindings
 create mode 100644 drivers/clk/samsung/clk-exynos7.c
 create mode 100644 include/dt-bindings/clock/exynos7-clk.h

-- 
2.1.0
