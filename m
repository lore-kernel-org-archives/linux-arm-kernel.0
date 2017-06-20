From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 20 Jun 2017 06:40:55 +0200
Subject: [PATCH v6 0/4] nvmem: upstream snvs_lpgpr driver
Message-ID: <20170620044059.16113-1-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

changes v6:
 - check if device is writable by reading GPR_SL and GPR_HL bits
 - use regmap_bulk_* functions instead of while() { regmap_read/write }
 - add patch for imx6ul

changes v5:
 - use dcfg->offset instead of priv->offset.

changes v4:
 - change dependencies in Kconfig
 - remove unused includes and order them alphabetically
 - set MODULE_LICENSE = GPL v2
 - remove unused int err variable

changes v3:
 - remove regmap and offset properties.

changes v2:
 - correct typos: Registe, parrent...

Oleksij Rempel (4):
  nvmem: dt: document SNVS LPGPR binding
  nvmem: add snvs_lpgpr driver
  ARM: dts: imx6qdl.dtsi: add "fsl,imx6q-snvs-lpgpr" node
  ARM: imx6ul: add "fsl,imx6ul-snvs-lpgpr" node

 .../devicetree/bindings/nvmem/snvs-lpgpr.txt       |  20 +++
 arch/arm/boot/dts/imx6qdl.dtsi                     |   4 +
 arch/arm/boot/dts/imx6ul.dtsi                      |   4 +
 drivers/nvmem/Kconfig                              |  10 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/snvs_lpgpr.c                         | 156 +++++++++++++++++++++
 6 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/snvs-lpgpr.txt
 create mode 100644 drivers/nvmem/snvs_lpgpr.c

-- 
2.11.0
