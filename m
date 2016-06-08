From: stefan@agner.ch (Stefan Agner)
Date: Tue,  7 Jun 2016 19:37:06 -0700
Subject: [PATCH 0/3] ARM: dts: imx7d: add i.MX 7Solo and Colibri iMX7S/D dts
Message-ID: <20160608023709.32090-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two SoC's i.MX 7Solo and i.MX 7Dual are very similar, but there
are some differences worth dividing the current i.MX 7Dual base device
tree. This patchset adds new base device tree imx7s.dtsi which is meant
to be used for i.MX 7Solo boards. Note that the SoC _family_ is called
imx7d/IMX7D throughout the kernel.

The third patch uses the new PMIC device tree binding (merge pending):
http://thread.gmane.org/gmane.linux.kernel/2238118

Stefan Agner (3):
  ARM: dts: imx7d: create i.MX 7Solo base device tree
  ARM: dts: imx7d: move input header into base device tree
  ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D support

 arch/arm/boot/dts/Makefile                  |   4 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 149 +++++
 arch/arm/boot/dts/imx7-colibri.dtsi         | 568 +++++++++++++++++
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts     |   1 -
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts |  66 ++
 arch/arm/boot/dts/imx7d-colibri.dtsi        |  54 ++
 arch/arm/boot/dts/imx7d-nitrogen7.dts       |   1 -
 arch/arm/boot/dts/imx7d-sdb.dts             |   1 -
 arch/arm/boot/dts/imx7d.dtsi                | 923 ++--------------------------
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts |  51 ++
 arch/arm/boot/dts/imx7s-colibri.dtsi        |  50 ++
 arch/arm/boot/dts/imx7s.dtsi                | 881 ++++++++++++++++++++++++++
 12 files changed, 1870 insertions(+), 879 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s.dtsi

-- 
2.8.3
