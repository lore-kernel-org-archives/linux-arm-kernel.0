From: carlo@caione.org (Carlo Caione)
Date: Mon, 15 Sep 2014 16:44:57 +0200
Subject: [PATCH 0/6] ARM: meson: initial support for MesonX SoCs
Message-ID: <1410792303-23275-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is taken from http://www.spinics.net/lists/devicetree/msg48979.html
and contains the preliminary support for MesonX-based SoCs.
I would like to get these merged for upcoming 3.18 merge window if there are no
concerns on this version.

Amlogic AML8726-MX (codename Meson6) is a highly integrated multimedia
application processor SoC for Multimedia Internet Device (MID), tablet
and Set Top Box (STB). It integrates a powerful CPU, a 2D/3D graphics
subsystem and a state-of-the-art video decoding engine together with
all major peripherals. It is manufactured by Amlogic, inc.

Amlogic doesn't release any documentation about their SoCs, so the code
has been reverse-engineered from the messy source code released at:

http://openlinux.amlogic.com:8000/download/ 

Carlo Caione (6):
  ARM: meson: debug: add debug UART for earlyprintk support
  ARM: meson: documentation: add bindings documentation
  ARM: meson: add basic support for MesonX SoCs
  ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200 DTSI/DTS
  ARM: meson: update multi_v7_defconfig
  MAINTAINERS: Add entry for the Amlogic MesonX SoCs

 Documentation/devicetree/bindings/arm/amlogic.txt  |   8 ++
 .../devicetree/bindings/arm/geniatech.txt          |   5 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |   6 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  14 ++-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/meson.dtsi                       | 105 +++++++++++++++++++++
 arch/arm/boot/dts/meson6-atv1200.dts               |  66 +++++++++++++
 arch/arm/boot/dts/meson6.dtsi                      |  78 +++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/include/debug/meson.S                     |  35 +++++++
 arch/arm/mach-meson/Kconfig                        |  13 +++
 arch/arm/mach-meson/Makefile                       |   1 +
 arch/arm/mach-meson/meson.c                        |  27 ++++++
 16 files changed, 365 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt
 create mode 100644 arch/arm/boot/dts/meson.dtsi
 create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
 create mode 100644 arch/arm/boot/dts/meson6.dtsi
 create mode 100644 arch/arm/include/debug/meson.S
 create mode 100644 arch/arm/mach-meson/Kconfig
 create mode 100644 arch/arm/mach-meson/Makefile
 create mode 100644 arch/arm/mach-meson/meson.c

-- 
1.9.1
