From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 23 Sep 2017 16:14:00 +0200
Subject: [PATCH 0/3] soc: amlogic: Add Meson6/8/8b SoC Information driver
Message-ID: <20170923141403.20882-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit Amlogic SoC have some registers which contain some information
the SoC's major and version, as well as a "major version".
This patchset adds support for this register decoding and exposing with the
SoC bus infrastructure, with dt-bindings and DT node.

This is inspired by Neil's Meson GX socinfo driver, see [0]

All information was taken from Amlogic's 3.10 GPL kernel sources because
the public S805 datasheet from Hardkernel does not contain any relevant
information for these register blocks.


[0] http://lists.infradead.org/pipermail/linux-amlogic/2017-June/004187.html

Martin Blumenstingl (3):
  dt-bindings: Amlogic: add documentation for the SoC info register
    areas
  soc: amlogic: Add Meson6/Meson8/Meson8b/Meson8m2 SoC Information
    driver
  ARM: dts: meson: add SoC information nodes

 .../devicetree/bindings/arm/amlogic/analog-top.txt |  20 +++
 .../devicetree/bindings/arm/amlogic/assist.txt     |  17 ++
 .../devicetree/bindings/arm/amlogic/bootrom.txt    |  17 ++
 arch/arm/boot/dts/meson.dtsi                       |  10 ++
 arch/arm/boot/dts/meson8.dtsi                      |   5 +
 arch/arm/boot/dts/meson8b.dtsi                     |   5 +
 drivers/soc/amlogic/Kconfig                        |  10 ++
 drivers/soc/amlogic/Makefile                       |   1 +
 drivers/soc/amlogic/meson-mx-socinfo.c             | 175 +++++++++++++++++++++
 9 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/analog-top.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/assist.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/bootrom.txt
 create mode 100644 drivers/soc/amlogic/meson-mx-socinfo.c

-- 
2.14.1
