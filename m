From: aneesh@ti.com (Aneesh V)
Date: Thu, 19 Jan 2012 19:58:38 +0530
Subject: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF and DDR
In-Reply-To: <1324303533-17458-1-git-send-email-aneesh@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Message-ID: <1326983321-319-1-git-send-email-aneesh@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an RFC to add new device tree bindings for DDR memories and
EMIF - TI's DDR SDRAM controller. 

The first patch adds bindings for DDR memories. Currently,
we have added properties for only DDR3 and LPDDR2 memories.
However, the binding can be easily extended to describe
other types such as DDR2 in the future.

The second patch provides the bindings for the EMIF controller.

The final patch provides DT data for EMIF controller instances
in OMAP4 and LPDDR2 memories attached to them on various boards.

Thanks to Rajendra for answering my numerous queries on device tree.

This is a re-post of the RFC that was posted to devicetree-discuss ml,
now sent to a larger audience and looping out an internal list.
Please ignore the previous version.

Aneesh V (3):
  dt: device tree bindings for DDR memories
  dt: device tree bindings for TI's EMIF sdram controller
  arm/dts: EMIF and lpddr2 device tree data for OMAP4 boards

 Documentation/devicetree/bindings/ddr/ddr.txt      |  114 ++++++++++++++++++++
 .../devicetree/bindings/ddr/ddr_timings.txt        |   62 +++++++++++
 .../bindings/memory-controllers/ti/emif.txt        |   64 +++++++++++
 arch/arm/boot/dts/omap-common-devices.dtsi         |   63 +++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   13 +++
 arch/arm/boot/dts/omap4-sdp.dts                    |   13 +++
 arch/arm/boot/dts/omap4.dtsi                       |   19 ++++
 7 files changed, 348 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ddr/ddr.txt
 create mode 100644 Documentation/devicetree/bindings/ddr/ddr_timings.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/omap-common-devices.dtsi
