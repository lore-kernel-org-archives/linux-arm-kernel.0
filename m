From: zhang.lyra@gmail.com (zhang.lyra at gmail.com)
Date: Mon, 29 Sep 2014 20:04:47 +0800
Subject: [PATCH 0/6] Add Spreadtrum Shark64 SoC support
Message-ID: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "chunyan.zhang" <chunyan.zhang@spreadtrum.com>

Spreadtrum is a rapid growing chip vendor providing smart phone total solutions. 
Shark64 is nominated as a SoC infrastructure that supports 4G/3G/2G standards based on ARMv8 multiple core architecture.

This patchset adds shark64 supports in arm64 device tree and implements the basic earlycon serial driver.

chunyan.zhang (6):
  Documentation: DT: Add bindings for Spreadtrum serial
  arm64: Add DTS support for Spreadtrum's Shark64 SoC
  arm64: dts/Makefile: Add support for Spreadtrum's Shark64 SoC.
  arm64: Add support for Spreadtrum's Shark64 SoC in Kconfig and defconfig
  tty/serial: add Spreadtrum's serial earlycon
  Documentation: Add entry for Spreadtrum's Shark64 SoC

 Documentation/devicetree/bindings/arm/sprd.txt     |    6 ++
 .../devicetree/bindings/serial/of-serial.txt       |    1 +
 arch/arm64/Kconfig                                 |    5 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/sprd_shark64.dts               |  110 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/tty/serial/Kconfig                         |   12 +++
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/serial_sprd_early.c             |   64 ++++++++++++
 9 files changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
 create mode 100644 arch/arm64/boot/dts/sprd_shark64.dts
 create mode 100644 drivers/tty/serial/serial_sprd_early.c

-- 
1.7.9.5
