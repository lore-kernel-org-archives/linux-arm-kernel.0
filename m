From: jan.tuerk@emtrion.com (jan.tuerk at emtrion.com)
Date: Fri, 27 Apr 2018 15:24:35 +0200
Subject: [PATCH v4 0/7] Add basic support for emtrion emCON-MX6 modules
In-Reply-To: <20180420125108.14197-1-jan.tuerk@emtrion.com>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
Message-ID: <20180427132445.3458-1-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

Changes for v4:
  - re-arrange the Patch-series to match the DT-submitting-patches
  - Additional patch for the Documentation of the new DT-bindings

[PATCH v4 1/7] dt-bindings: display: Document the EDT et* displays in one file.
  - no change (re-arranged 3/6 => 1/7)

[PATCH v4 2/7] drm/panel: Add support for the EDT ETM0700G0BDH6
  - no change (re-arranged 1/6 => 2/7)

[PATCH v4 3/7] drm/panel: Add support for the EDT ETM0700G0EDH6
  - no change (re-arranged 2/6 => 3/7)

[PATCH v4 4/7] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
  - no change

[PATCH v4 5/7] dt-bindings: arm: Document emtrion emCON-MX6 bindings
  - separate patch for the emtrion emCON-MX6 DT-bindings

[PATCH v4 6/7] ARM: dts: Add support for emtrion emCON-MX6 series
  - alphabetically sort the DT
  - moved duplicated Avari baseboard code into separate file.

[PATCH v4 7/7] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
  - unchaged

 Documentation/devicetree/bindings/arm/emtrion.txt  |  13 +
 .../bindings/display/panel/edt,et-series.txt       |  39 +
 .../bindings/display/panel/edt,et057090dhu.txt     |   7 -
 .../bindings/display/panel/edt,et070080dh6.txt     |  10 -
 .../bindings/display/panel/edt,etm0700g0dh6.txt    |  10 -
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx6dl-emcon-avari.dts           |  17 +
 arch/arm/boot/dts/imx6dl-emcon.dtsi                |  28 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6q-emcon-avari.dts            |  17 +
 arch/arm/boot/dts/imx6q-emcon.dtsi                 |  28 +
 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi         | 208 ++++++
 arch/arm/boot/dts/imx6qdl-emcon.dtsi               | 826 +++++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig               |   3 +
 drivers/gpu/drm/panel/panel-simple.c               |  18 +
 15 files changed, 1200 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,et-series.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et057090dhu.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,et070080dh6.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm0700g0dh6.txt
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6q-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi

-- 
2.11.0
