From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Thu, 19 Dec 2013 11:47:42 +0100
Subject: [PATCH v7 0/2] ARM: mach-moxart: add MOXA ART SoC support
Message-ID: <1387450064-6598-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reason behind why fixed rate clock "ref12" couldn't be moved from
.dtsi to .dts:

There was nothing else in "clocks { .. }", the entire block was then
deleted from .dtsi.

If a skeleton "clocks { .. }" remain in .dtsi, the node can then be
moved to .dts, and of_clk_get() works again.

Changes since v6:

1. move fixed rate clock "ref12" from .dtsi to .dts
2. sort new entry alphabetically in arch/arm/Kconfig
3. rebase to next-20131219: arch/arm/Makefile arch/arm/Kconfig

Applies to next-20131219

Jonas Jensen (2):
  ARM: mach-moxart: add MOXA ART SoC platform files
  ARM: mach-moxart: add MOXA ART SoC device tree files

 Documentation/devicetree/bindings/arm/moxart.txt |  12 ++
 arch/arm/Kconfig                                 |   2 +
 arch/arm/Makefile                                |   1 +
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/moxart-uc7112lx.dts            | 117 ++++++++++++++++++
 arch/arm/boot/dts/moxart.dtsi                    | 148 ++++++++++++++++++++++
 arch/arm/configs/moxart_defconfig                | 149 +++++++++++++++++++++++
 arch/arm/mach-moxart/Kconfig                     |  31 +++++
 arch/arm/mach-moxart/Makefile                    |   3 +
 arch/arm/mach-moxart/moxart.c                    |  15 +++
 10 files changed, 479 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/moxart.txt
 create mode 100644 arch/arm/boot/dts/moxart-uc7112lx.dts
 create mode 100644 arch/arm/boot/dts/moxart.dtsi
 create mode 100644 arch/arm/configs/moxart_defconfig
 create mode 100644 arch/arm/mach-moxart/Kconfig
 create mode 100644 arch/arm/mach-moxart/Makefile
 create mode 100644 arch/arm/mach-moxart/moxart.c

-- 
1.8.2.1
