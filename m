From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun,  5 Oct 2014 23:59:12 +0200
Subject: [PATCH v2 0/7] ARM: meson: add support for Meson8
Message-ID: <1412546359-15062-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset introduces support for Amlogic Meson8, which is a family
of quad-core Cortex-A9 SoCs used in tablets and set-top boxes.

Changes since v1:
 - reused the existing DT machine definition and renamed it to be more
   generic
 - added L2 cache support

Beniamino Galvani (7):
  ARM: meson: add meson8 support
  ARM: dts: add dtsi for Amlogic Meson8 SoCs
  ARM: dts: add dts for Tronsmart S89 Elite TV box
  of: add vendor prefix for Tronsmart
  ARM: document Tronsmart compatible properties
  ARM: meson: document meson8 compatible properties
  ARM: meson: enable L2 cache

 Documentation/devicetree/bindings/arm/amlogic.txt  |  8 +-
 .../devicetree/bindings/arm/tronsmart.txt          |  7 ++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/meson.dtsi                       |  7 ++
 arch/arm/boot/dts/meson6.dtsi                      |  2 +
 arch/arm/boot/dts/meson8-vega-s89e.dts             | 65 +++++++++++++++
 arch/arm/boot/dts/meson8.dtsi                      | 92 ++++++++++++++++++++++
 arch/arm/mach-meson/Kconfig                        |  6 ++
 arch/arm/mach-meson/meson.c                        | 10 ++-
 9 files changed, 191 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tronsmart.txt
 create mode 100644 arch/arm/boot/dts/meson8-vega-s89e.dts
 create mode 100644 arch/arm/boot/dts/meson8.dtsi

-- 
1.9.1
