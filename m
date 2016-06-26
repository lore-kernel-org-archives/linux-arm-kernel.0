From: stefan@agner.ch (Stefan Agner)
Date: Sun, 26 Jun 2016 01:47:50 -0700
Subject: [PATCH v2 0/5] ARM: dts: imx7d: add i.MX 7Solo and Colibri iMX7S/D dts
Message-ID: <20160626084755.21925-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two SoC's i.MX 7Solo and i.MX 7Dual are very similar, but there
are some differences worth dividing the current i.MX 7Dual base device
tree. This patchset adds new base device tree imx7s.dtsi which is meant
to be used for i.MX 7Solo boards. Note that the SoC _family_ is called
imx7d/IMX7D throughout the kernel.

The third patch uses the new PMIC device tree binding (merge pending,
bindings have been acked by Rob Herring):
https://lkml.org/lkml/2016/6/25/212

Changes since v1:
- Add additional commit before recreating imx7d.dtsi to keep diffstat nice
- Define SD-card detect to be GPIO_ACTIVE_LOW
- Use compatible toradex,colibri-imx7(s|d)-eval-v3 (with dashes and v3)
- Various device tree properties fixed/altered as suggested by Shawn
- Specify 1P0D regulator supply

Stefan Agner (5):
  ARM: imx: add support for i.MX 7Solo
  ARM: dts: imx7d: use imx7s.dtsi as base device tree
  ARM: dts: imx7d: recreate imx7d.dtsi with i.MX 7Dual specifics
  ARM: dts: imx7d: move input header into base device tree
  ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D support

 arch/arm/boot/dts/Makefile                  |   4 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 148 +++++
 arch/arm/boot/dts/imx7-colibri.dtsi         | 571 +++++++++++++++++
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts     |   1 -
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts |  66 ++
 arch/arm/boot/dts/imx7d-colibri.dtsi        |  54 ++
 arch/arm/boot/dts/imx7d-nitrogen7.dts       |   1 -
 arch/arm/boot/dts/imx7d-sdb.dts             |   1 -
 arch/arm/boot/dts/imx7d.dtsi                | 923 ++--------------------------
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts |  51 ++
 arch/arm/boot/dts/imx7s-colibri.dtsi        |  50 ++
 arch/arm/boot/dts/imx7s.dtsi                | 881 ++++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx7d.c              |   1 +
 13 files changed, 1873 insertions(+), 879 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s.dtsi

-- 
2.8.3
