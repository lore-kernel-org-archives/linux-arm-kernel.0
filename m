From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 18 Jun 2017 23:55:21 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.13
In-Reply-To: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
References: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1497801323-6389-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.13

for you to fetch changes up to d8710c3fb912574709166bba24f4c64162ab832c:

  ARM: dts: imx6q-cm-fx6: add sdio wifi/bt nodes (2017-06-17 21:17:04 +0800)

----------------------------------------------------------------
The i.MX device tree updates for 4.13:
 - New board support: Gateworks Ventana GW5600, Technexion Pico i.MX7D
   Board.
 - A series from Alexandre Belloni to correct the vendor prefix for
   rv4162 compatible.
 - A patch-set from Andrey Smirnov ot enable PCIe support for i.MX7 and
   imx7d-sdb board.
 - Increase the SGTL5000 LRCLK pad strength to fix a random audio
   channel swapping seen on imx6qdl-wandboard and imx6qdl-colibri
   boards.
 - Clean up non-existing property 'enable-active-low' from fixed
   regulator device nodes.
 - Correct GPIO polarity for Ethernet PHY and PCI reset lines, even
   though device drivers do not use the polarity for now.
 - Add Wifi and Bluetooth support for imx7d-sdb board.
 - Adopt the i.MX6Q/DL DT to the new and more flexible GPC binding.
 - Update zii-rdu2 device tree source to use #include "..." for local
   inclusion.
 - A series from Philipp Zabel and Steve Longerbeam to enable video
   capture support for imx6qdl platforms.
 - A number of small random updates on various board support.

----------------------------------------------------------------
Alexandre Belloni (3):
      ARM: dts: imx6qdl-nitrogen6_max: fix rv4162 compatible
      ARM: dts: imx6qdl-nitrogen6_som2: fix rv4162 compatible
      ARM: dts: imx7d-nitrogen7: fix rv4162 compatible

Andrew Lunn (1):
      ARM: dts: vf610-zii: Add switch eeprom-length properties

Andrey Smirnov (6):
      ARM: dts: imx: Reintroduce 'anatop-enable-bit' where appropriate
      ARM: dts: imx7s: Add node for GPC
      ARM: dts: imx7s: Mark 'gpr' compatible with i.MX6 variant
      ARM: dts: imx7d-sdb: Add GPIO expander node
      ARM: dts: imx7d: Add node for PCIe controller
      ARM: dts: imx7d-sdb: Enable PCIe peripheral

Christopher Spinrath (1):
      ARM: dts: imx6q-cm-fx6: add sdio wifi/bt nodes

Fabio Estevam (15):
      ARM: dts: imx6qdl-wandboard: Fix audio channel swap
      ARM: dts: imx6qdl-colibri: Fix audio channel swap
      ARM: dts: imx6sx-sdb: Properly model the ARM and SOC regulator supplies
      ARM: dts: imx7s-warp: Pass 'no-1-8-v' property to the eMMC
      ARM: dts: imx6: Fix BCM43xx node name
      ARM: dts: imx7d-pico: Add watchdog support
      ARM: dts: imx7d-pico: Pass 'no-1-8-v' property to the eMMC
      ARM: dts: imx23-sansa: Remove 'enable-active-low' property
      ARM: dts: tx6: Remove 'enable-active-low' property
      ARM: dts: imx7: Fix typo in watchdog pin name
      ARM: dts: imx: Fix Ethernet PHY reset polarity
      ARM: dts: imx7d-sdb: Adjust the regulator nodes
      ARM: dts: imx7d-sdb: Add Wifi support
      ARM: dts: imx7d-sdb: Add Bluetooth support
      ARM: dts: imx6: Fix PCI GPIO reset polarity

Javier Martinez Canillas (1):
      ARM: dts: imx: Add generic compatible string for I2C EEPROM

Lucas Stach (2):
      ARM: dts: imx6: adopt DT to new GPC binding
      ARM: dts: imx6qp: add specific compatible for GPC

Masahiro Yamada (1):
      ARM: dts: imx6: use #include "..." to include local DT

Philipp Zabel (2):
      ARM: dts: imx6qdl: add multiplexer controls
      ARM: dts: imx6qdl: Add video multiplexers, mipi_csi, and their connections

Stefan Agner (2):
      ARM: dts: imx7: add USDHC NAND and IPG clock to SDHC instances
      ARM: dts: imx7: use 3 PWM cells

Steve Longerbeam (9):
      ARM: dts: imx6qdl: Add compatible, clocks, irqs to MIPI CSI-2 node
      ARM: dts: imx6qdl: add capture-subsystem device
      ARM: dts: imx6qdl-sabrelite: remove erratum ERR006687 workaround
      ARM: dts: imx6-sabrelite: add OV5642 and OV5640 camera sensors
      ARM: dts: imx6-sabresd: add OV5642 and OV5640 camera sensors
      ARM: dts: imx6-sabreauto: create i2cmux for i2c3
      ARM: dts: imx6-sabreauto: add reset-gpios property for max7310_b
      ARM: dts: imx6-sabreauto: add pinctrl for gpt input capture
      ARM: dts: imx6-sabreauto: add the ADV7180 video decoder

Tim Harvey (2):
      ARM: dts: imx: ventana: fix DTC warnings
      ARM: dts: imx: add Gateworks Ventana GW5600 support

Vanessa Maegima (1):
      ARM: dts: imx7d-pico: Add initial support

Yuantian Tang (1):
      ARM: dts: ls1021a: update the clockgen node

 arch/arm/boot/dts/Makefile                        |   3 +
 arch/arm/boot/dts/imx23-sansa.dts                 |   7 +-
 arch/arm/boot/dts/imx25-karo-tx25.dts             |   2 +-
 arch/arm/boot/dts/imx25-pdk.dts                   |   2 +-
 arch/arm/boot/dts/imx25.dtsi                      |   1 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi   |   2 +-
 arch/arm/boot/dts/imx28-cfa10037.dts              |   2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts              |   2 +-
 arch/arm/boot/dts/imx28-cfa10057.dts              |   2 +-
 arch/arm/boot/dts/imx28-cfa10058.dts              |   2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts      |   2 +-
 arch/arm/boot/dts/imx28-evk.dts                   |   4 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                |   2 +-
 arch/arm/boot/dts/imx50-evk.dts                   |   2 +-
 arch/arm/boot/dts/imx50.dtsi                      |   1 +
 arch/arm/boot/dts/imx51-apf51.dts                 |   2 +-
 arch/arm/boot/dts/imx53-mba53.dts                 |   2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi           |   2 +-
 arch/arm/boot/dts/imx53-smd.dts                   |   2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi               |   2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                 |   2 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi       |   2 +-
 arch/arm/boot/dts/imx6dl-gw560x.dts               |  55 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts            |   2 +-
 arch/arm/boot/dts/imx6dl-sabrelite.dts            |   5 +
 arch/arm/boot/dts/imx6dl-sabresd.dts              |   5 +
 arch/arm/boot/dts/imx6dl.dtsi                     | 189 ++++++
 arch/arm/boot/dts/imx6q-ba16.dtsi                 |   2 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                |  43 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts           |   4 +-
 arch/arm/boot/dts/imx6q-evi.dts                   |   2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts              |   7 +-
 arch/arm/boot/dts/imx6q-gw560x.dts                |  59 ++
 arch/arm/boot/dts/imx6q-novena.dts                |   4 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts             |   5 +
 arch/arm/boot/dts/imx6q-sabresd.dts               |   5 +
 arch/arm/boot/dts/imx6q-utilite-pro.dts           |   2 +-
 arch/arm/boot/dts/imx6q-zii-rdu2.dts              |   4 +-
 arch/arm/boot/dts/imx6q.dtsi                      | 127 +++-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi            |   2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi      |   4 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi            |   1 +
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi             |   5 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi             |   5 -
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi             | 749 ++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi    |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi      |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi     |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi         |   2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi      |   2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi          | 131 +++-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi          | 152 ++++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi            | 116 +++-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                |   5 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi          |   3 +-
 arch/arm/boot/dts/imx6qdl.dtsi                    |  60 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts             |   4 +-
 arch/arm/boot/dts/imx6qp.dtsi                     |   4 +
 arch/arm/boot/dts/imx6sl.dtsi                     |   3 +
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts          |   4 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                  |   8 +
 arch/arm/boot/dts/imx6sx.dtsi                     |   3 +
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi             |   2 +-
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts      |   2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi               |   7 +-
 arch/arm/boot/dts/imx6ul.dtsi                     |   1 +
 arch/arm/boot/dts/imx7-colibri.dtsi               |   2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts             |   6 +-
 arch/arm/boot/dts/imx7d-pico.dts                  | 403 ++++++++++++
 arch/arm/boot/dts/imx7d-pinfunc.h                 |   6 +-
 arch/arm/boot/dts/imx7d-sdb.dts                   | 133 +++-
 arch/arm/boot/dts/imx7d.dtsi                      |  37 ++
 arch/arm/boot/dts/imx7s-warp.dts                  |   3 +-
 arch/arm/boot/dts/imx7s.dtsi                      |  50 +-
 arch/arm/boot/dts/ls1021a.dtsi                    |  90 +--
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts         |   2 +
 78 files changed, 2361 insertions(+), 226 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-gw560x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw560x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw560x.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-pico.dts
