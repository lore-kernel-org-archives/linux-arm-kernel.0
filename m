From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 10 Feb 2016 10:22:43 +0100
Subject: [PATCH v2 0/3] arm64: introduce the Alpine support
Message-ID: <1455096166-4899-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series introduces the support for the arm64 Alpine family from
Annapurna Labs, by adding a device tree for the Alpine v2 EVP. This
board has 4 Cortex A57 and a few nodes in its device tree for now.

You can find the series at:
https://github.com/atenart/linux.git 4.5-rc1/alpinev2-bringup

Antoine

Since v1:
  - Fixed the armv8-timer interrupts.
  - Added the GICV and GIVH ranges.
  - Added the GIC maintainance interrupt.
  - Moved the aliases to the dts file.
  - Fixed the pci node.
  - Added the arm,psci cpu_off and cpu_suspend functions.
  - Added the io-fabric bus.
  - Fixed the stdout-path.

Antoine Tenart (3):
  arm64: add Alpine SoC family
  arm64: dts: add the Alpine v2 EVP
  arm64: defconfig: enable the Alpine family

 arch/arm64/Kconfig.platforms             |   6 +
 arch/arm64/boot/dts/Makefile             |   1 +
 arch/arm64/boot/dts/al/Makefile          |   5 +
 arch/arm64/boot/dts/al/alpine-v2-evp.dts |  53 ++++++++
 arch/arm64/boot/dts/al/alpine-v2.dtsi    | 226 +++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig             |   1 +
 6 files changed, 292 insertions(+)
 create mode 100644 arch/arm64/boot/dts/al/Makefile
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2-evp.dts
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2.dtsi

-- 
2.7.0
