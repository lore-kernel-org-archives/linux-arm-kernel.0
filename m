From: jan.tuerk@emtrion.com (jan.tuerk at emtrion.com)
Date: Fri, 20 Apr 2018 14:50:47 +0200
Subject: [PATCH v3 0/6] Add basic support for emtrion emCON-MX6 modules
In-Reply-To: <20171220134710.64479-2-jan.tuerk@emtrion.com>
References: <20171220134710.64479-2-jan.tuerk@emtrion.com>
Message-ID: <20180420125108.14197-1-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

Changes for v3:
  [PATCH v3 1/6] drm/panel: Add support for the EDT ETM0700G0BDH6
    - moved Documentation into seperate commit ([PATCH v3/6])

  [PATCH v3 2/6] drm/panel: Add support for the EDT ETM0700G0EDH6
	- new Patch, adding additionally compatible for the new hardware type

  [PATCH v3 3/6] dt-bindings: display: Document the EDT et* displays in one file.
	- new Patch, as requested by Rob Herring document the EDT Displays in a single file

  [PATCH v3 4/6] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
    - Unchanged
  [PATCH v3 5/6] ARM: dts: Add support for emtrion emCON-MX6 series
	- change License Header to SPDX + dual-license without licence text.
    - coding-style fixes
  [PATCH v3 6/6] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
	- Rebased and merged

 Documentation/devicetree/bindings/arm/emtrion.txt  |  13 +
 .../bindings/display/panel/edt,et-series.txt       |  39 +
 .../bindings/display/panel/edt,et057090dhu.txt     |   7 -
 .../bindings/display/panel/edt,et070080dh6.txt     |  10 -
 .../bindings/display/panel/edt,etm0700g0dh6.txt    |  10 -
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-emcon-avari.dts           | 224 ++++++
 arch/arm/boot/dts/imx6dl-emcon.dtsi                |  27 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6q-emcon-avari.dts            | 224 ++++++
 arch/arm/boot/dts/imx6q-emcon.dtsi                 |  27 +
 arch/arm/boot/dts/imx6qdl-emcon.dtsi               | 838 +++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   3 +
 drivers/gpu/drm/panel/panel-simple.c               |  18 +
 14 files changed, 1416 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6q-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi

-- 
2.11.0
