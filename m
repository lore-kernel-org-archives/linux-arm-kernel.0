From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  3 Jan 2018 13:57:18 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.16
In-Reply-To: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
References: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1514959040-9992-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.16

for you to fetch changes up to 84a82ef70e1eb2a7a90bc19eed27cb27a8e4c54c:

  ARM: dts: imx7s: Avoid using label in unit address and reg (2017-12-27 10:52:39 +0800)

----------------------------------------------------------------
i.MX device tree changes for 4.16:
 - A few random updates for vf610-zii board: correct switch EEPROM size,
   enable edma1, correct GPIO expander interrupt, add PHYs for switch2
   device.
 - LS1021A device tree updates: add reboot and QSPI device nodes, label
   USB controllers, specify interrupt-affinity for PMU, fix TMR_FIPER1
   setting, enable esdhc device, add Moxa UC-8410A board support.
 - A bunch of patches from Fabio: fix reg - unit address mismatches,
   remove leading zero in unit address, move regulators out of
   simple-bus, move nodes with no reg property out of bus, remove extra
   clock cell, add missing phy-cells to usb-nop-xceiv, etc.
 - A couple series from Hummingboard developers: re-organise device tree
   files for better handling various board versions, and then add the
   new hummingboard2 board support on top of that.
 - Disable AC'97 input pins pad and add support for powering off for
   imx6qdl-udoo board.
 - Convert from fbdev to drm bindings for imx6sx-sdb and imx6sl-evk
   board.
 - Add device tree for Variscite DART-MX6 SoM and Carrier-board support.
 - Add new board support of TS-4600 and TS-7970 from Technologic
   Systems.
 - A series from Stefan to update imx7-colibri device tree and then add
   new version of Toradex Colibri iMX7D board with eMMC support.
 - Other random updates on various board support.

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: dts: vf610-zii-dev-c: Fix switch EEPROM size

Esben Haabendal (2):
      ARM: dts: ls1021a: Add label to USB controllers
      ARM: dts: ls1021a: Specify interrupt-affinity for pmu node

Fabio Estevam (41):
      ARM: dts: imx6qdl-wandboard-revd1: Make EDID functional
      ARM: dts: imx6sx: Fix the PCI representation
      ARM: dts: imx6sx-sdb: Rearrange the regulators node
      ARM: dts: imx6sx-sdb: Add PCIe support
      ARM: dts: imx6qdl-sabreauto: Pass the DDC I2C bus
      ARM: dts: imx6qdl-sabreauto: Add CEC support
      ARM: dts: imx53-cx9020: Fix the Ethernet PHY reset GPIO polarity
      ARM: dts: imx53: Move nodes which have no reg property out of bus
      ARM: dts: imx6: Move nodes which have no reg property out of bus
      ARM: dts: imx6: Add unit address and reg for the anatop nodes
      ARM: dts: imx6dl: Pass the reg properties for mipi nodes
      ARM: dts: imx6dl: Remove unneeded label and unit address
      ARM: dts: imx7: Move nodes which have no reg property out of bus
      ARM: dts: imx7d: Fix pcie node warnings
      ARM: dts: imx7s: Add unit address and reg for the anatop nodes
      ARM: dts: vfxxx: Move nodes which have no reg property out of bus
      ARM: dts: imx6sx: Fix spba-bus unit address
      ARM: dts: vf500: Fix interrupt-controller unit address
      ARM: dts: imx51-ts4800: Fix syscon and touschscreen nodes
      ARM: dts: imx51-zii-rdu1: Add the unit addresses in sysled
      ARM: dts: imx53-m53: Remove unneeded reg property
      ARM: dts: imx53-tx53-x03x: Move display node out of 'soc'
      ARM: dts: imx6qdl-apf6dev: Move regulators out of simple-bus
      ARM: dts: imx6qdl-aristainetos: Move regulators out of simple-bus
      ARM: dts: imx6qdl-aristainetos: Move display node out of 'soc'
      ARM: dts: imx6qdl-apalis: Remove unneeded reg property
      ARM: dts: imx6qdl-colibri: Remove unneeded reg property
      ARM: dts: imx6q-h100: Remove unneeded unit address
      ARM: dts: imx6qdl-nitrogen6_max: Remove unneeded unit address
      ARM: dts: imx6ul-14x14-evk: Move regulators out of simple-bus
      ARM: dts: imx6qdl-zii-rdu2: Remove device_type from PCI subnode
      ARM: dts: imx51-babbage: Pass the USB PHY regulator
      ARM: dts: imx6sx: Fix PCI non-prefetchable memory range
      ARM: dts: imx6sx: Add support for PCI power domain
      dt-bindings: imx-gpcv2: Fix the unit address
      ARM: dts: ls1021a-qds: Remove extra clock cell
      ARM: dts: ls1021a-twr: Remove extra clock cell
      ARM: dts: imx51-babbage: Fix the 26MHz clock modelling
      ARM: dts: imx6qdl-hummingboard2: Remove leading zero in unit address
      ARM: dts: imx51-zii-rdu1: Add missing #phy-cells to usb-nop-xceiv
      ARM: dts: imx7s: Avoid using label in unit address and reg

Jon Nettleton (1):
      ARM: dts: imx6qdl: add HummingBoard2 boards

Lucas Stach (10):
      ARM: dts: imx6: RDU2: add i210 node
      ARM: dts: imx: rdu1: cosmetic changes to the audio nodes
      ARM: dts: imx6: RDU2: add alias for RTC
      ARM: dts: imx6*-hummingboard2: fix formatting
      ARM: dts: imx6*-hummingboard2: add SGTL5000 VDDD supply
      ARM: dts: imx6*-hummingboard2: remove LDB node
      ARM: dts: imx6*-hummingboard2: fix PCIe reset polarity
      ARM: dts: imx6*-hummingboard2: remove non-mainline property from RTC
      ARM: dts: imx6*-hummingboard2: remove redundant PWM disables
      ARM: dts: imx6*-hummingboard2: rework regulators

Maciej S. Szmigiero (2):
      ARM: dts: imx6qdl-udoo: disable AC'97 input pins pad drivers
      ARM: dts: imx6qdl-udoo: add support for powering off

Marco Franchi (4):
      ARM: dts: imx53-tx53: Fix 'ethernet-phy at 0' node with unit name and no reg property
      ARM: dts: imx6sx-sdb: Convert from fbdev to drm bindings
      ARM: dts: imx6sl-evk: Rearrange the regulators node
      ARM: dts: imx6sl-evk: Convert from fbdev to drm bindings

Mathieu Malaterre (1):
      ARM: imx: dts: Use lower case for bindings notation

Michael Tretter (1):
      ARM: dts: imx6q-h100: use usdhc2 VSELECT

Neil Armstrong (5):
      ARM: dts: imx6qdl-pinfunc: Add missing MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT
      dt-bindings: Add vendor prefix for Solomon Goldentek Display Corporation
      dt-bindings: display: Add bindings for SGD GKTW70SDAE4SE Panel
      ARM: dts: imx6qdl: Add Variscite DART-MX6 SoM support
      ARM: dts: imx6q: Add Variscite DART-MX6 Carrier-board support

Oleksij Rempel (1):
      ARM: dts: imx6: add snvs-lpgpr node

Otavio Salvador (1):
      ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions

Patrick Bruenn (1):
      ARM: dts: imx53: add srtc node

Prabhakar Kushwaha (1):
      ARM: dts: ls1021aqds: Add nand node for ifc controller

Rasmus Villemoes (2):
      ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc node
      ARM: dts: ls1021a: add reboot node to .dtsi

Rob Herring (1):
      ARM: dts: imx: Add missing #phy-cells to usb-nop-xceiv

Russell King (31):
      ARM: dts: imx6qdl: SolidRun: remove redundant regulators node
      ARM: dts: imx6qdl: SolidRun: move AR8035 into microsom
      ARM: dts: imx6qdl-microsom: rename to imx6qdl-sr-som
      ARM: dts: imx6qdl: SolidRun: move microsom includes into .dts
      ARM: dts: imx6qdl-sr-som: use real iomuxc values for ethernet
      ARM: dts: imx6qdl-sr-som: split out Broadcom Wi-Fi support
      ARM: dts: imx6qdl-sr-som-brcm: rename sdio clock
      ARM: dts: imx6qdl-sr-som: add 3.3V vcc regulator
      ARM: dts: imx6qdl-sr-som: add support for TI Wi-Fi
      ARM: dts: imx6qdl-sr-som: add support for eMMC
      ARM: dts: imx6qdl-hummingboard: add SD card regulator
      ARM: dts: imx6qdl: SolidRun: rename regulators to match schematic
      ARM: dts: imx6qdl: SolidRun: fix node names
      ARM: dts: imx6qdl: SolidRun: add v1.5 som without eMMC
      ARM: dts: imx6qdl: SolidRun: add v1.5 som with eMMC
      ARM: dts: imx6qdl-cubox-i: update GPIO specification
      ARM: dts: imx6*-hummingboard2: remove ar8035 include
      ARM: dts: imx6qdl-hummingboard2: rename microsom include
      ARM: dts: imx6*-hummingboard2: move microsom includes into .dts
      ARM: dts: imx6*-hummingboard2: add Broadcom Wi-Fi include
      ARM: dts: imx6*-hummingboard2: fix SD card detect
      ARM: dts: imx6*-hummingboard2: use proper gpio flags definitions
      ARM: dts: imx6*-hummingboard2: convert to more conventional vmmc-supply
      ARM: dts: imx6*-hummingboard2: split out eMMC support
      ARM: dts: imx6qdl-hummingboard2: add PWM3 support
      ARM: dts: imx6qdl-hummingboard2: add v1.5 som without eMMC
      ARM: dts: imx6qdl-hummingboard2: add v1.5 som with eMMC
      ARM: dts: imx6qdl-hummingboard2: rename regulators to match schematic
      ARM: dts: vf610-zii-dev: enable edma1
      ARM: dts: vf610-zii-dev-rev-b: fix interrupt for GPIO expander
      ARM: dts: vf610-zii-dev-rev-b: add PHYs for switch2

SZ Lin (2):
      ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC
      ARM: dts: ls1021a: add support for Moxa UC-8410A open platform

Sebastien Bourdelin (4):
      of: documentation: add bindings documentation for TS-7970
      ARM: dts: TS-7970: add basic device tree
      of: documentation: add bindings documentation for TS-4600
      ARM: dts: TS-4600: add basic device tree

Stefan Agner (10):
      ARM: dts: colibri/apalis: use correct compatible for RTC
      ARM: dts: imx7-colibri: move and rename USB Host power regulator
      ARM: dts: imx7-colibri: make sure multiplexed pins are not active
      ARM: dts: imx7-colibri: mux pull-ups where appropriate
      ARM: dts: imx7-colibri: use NAND_CE1 as GPIO
      ARM: dts: imx7-colibri: specify cpu-supply
      ARM: dts: imx7-colibri: specify usdhc1 supplies
      ARM: dts: imx7-colibri: specify backlight GPIO
      ARM: dts: imx7-colibri: add MCP2515 CAN controller
      ARM: dts: imx7: add Toradex Colibri iMX7D 1GB (eMMC) support

Troy Kisky (1):
      ARM: dts: imx: name the interrupts for the fec ethernet driver

Vanessa Maegima (1):
      ARM: dts: imx7d-pico-pi: Separate into cpu and baseboard dts

Yangbo Lu (1):
      ARM: dts: ls1021a: fix the value of TMR_FIPER1

yinbo.zhu (1):
      ARM: dts: ls1021a: Enable the esdhc

 .../devicetree/bindings/arm/technologic.txt        |  11 +
 .../bindings/display/panel/sgd,gktw70sdae4se.txt   |  41 ++
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |   4 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |  22 +-
 arch/arm/boot/dts/imx25.dtsi                       |   2 +
 arch/arm/boot/dts/imx27-pdk.dts                    |   1 +
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   1 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   1 +
 arch/arm/boot/dts/imx28-ts4600.dts                 |  79 +++
 arch/arm/boot/dts/imx35.dtsi                       |   2 +
 arch/arm/boot/dts/imx51-babbage.dts                |  77 ++-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   1 +
 arch/arm/boot/dts/imx51-ts4800.dts                 |   6 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  12 +-
 arch/arm/boot/dts/imx51.dtsi                       |   1 +
 arch/arm/boot/dts/imx53-cx9020.dts                 |   2 +-
 arch/arm/boot/dts/imx53-m53.dtsi                   |   1 -
 arch/arm/boot/dts/imx53-tx53-x03x.dts              | 232 ++++----
 arch/arm/boot/dts/imx53-tx53.dtsi                  |  14 +-
 arch/arm/boot/dts/imx53.dtsi                       |  48 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |  50 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |  48 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |   2 +-
 arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts  |  52 ++
 arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts       |  51 ++
 arch/arm/boot/dts/imx6dl-cubox-i.dts               |   2 +
 .../boot/dts/imx6dl-hummingboard-emmc-som-v15.dts  |  53 ++
 arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dts  |  52 ++
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |   2 +
 .../boot/dts/imx6dl-hummingboard2-emmc-som-v15.dts |  55 ++
 arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dts |  54 ++
 arch/arm/boot/dts/imx6dl-hummingboard2.dts         |  53 ++
 arch/arm/boot/dts/imx6dl-pinfunc.h                 |   1 +
 arch/arm/boot/dts/imx6dl-ts7970.dts                |  50 ++
 arch/arm/boot/dts/imx6dl.dtsi                      |  12 +-
 arch/arm/boot/dts/imx6q-apalis-eval.dts            |   2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      |   2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |   2 +-
 arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts   |  60 +++
 arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts        |  59 ++
 arch/arm/boot/dts/imx6q-cubox-i.dts                |   2 +
 arch/arm/boot/dts/imx6q-display5.dtsi              |   2 +-
 arch/arm/boot/dts/imx6q-h100.dts                   |  33 +-
 .../boot/dts/imx6q-hummingboard-emmc-som-v15.dts   |  61 +++
 arch/arm/boot/dts/imx6q-hummingboard-som-v15.dts   |  60 +++
 arch/arm/boot/dts/imx6q-hummingboard.dts           |   2 +
 .../boot/dts/imx6q-hummingboard2-emmc-som-v15.dts  |  63 +++
 arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dts  |  62 +++
 arch/arm/boot/dts/imx6q-hummingboard2.dts          |  61 +++
 arch/arm/boot/dts/imx6q-pinfunc.h                  |   1 +
 arch/arm/boot/dts/imx6q-ts7970.dts                 |  54 ++
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts     | 235 ++++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   1 -
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |  44 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |  73 ++-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |  76 ++-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |   1 -
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |  72 +--
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        | 103 ++--
 arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi  |  72 +++
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       | 540 +++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |  10 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  17 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   9 +
 ...6qdl-microsom.dtsi => imx6qdl-sr-som-brcm.dtsi} |  41 +-
 arch/arm/boot/dts/imx6qdl-sr-som-emmc.dtsi         |  70 +++
 arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi           | 170 ++++++
 ...dl-microsom-ar8035.dtsi => imx6qdl-sr-som.dtsi} |  36 +-
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi              | 594 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  25 +-
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi            | 503 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi     |   5 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |  14 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     | 161 +++---
 arch/arm/boot/dts/imx6sl-evk.dts                   | 133 +++--
 arch/arm/boot/dts/imx6sl.dtsi                      |  48 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  | 220 ++++----
 arch/arm/boot/dts/imx6sx.dtsi                      |  93 ++--
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  19 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |  49 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi        |  39 +-
 arch/arm/boot/dts/imx7-colibri.dtsi                | 116 +++-
 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts   |  19 +
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi          |  21 +
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts        |  13 +-
 arch/arm/boot/dts/imx7d-colibri.dtsi               |   4 +
 arch/arm/boot/dts/imx7d-pico-pi.dts                | 181 +++++++
 .../boot/dts/{imx7d-pico.dts => imx7d-pico.dtsi}   | 133 -----
 arch/arm/boot/dts/imx7d.dtsi                       |  22 +-
 arch/arm/boot/dts/imx7s.dtsi                       | 133 ++---
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts        | 241 +++++++++
 arch/arm/boot/dts/ls1021a-qds.dts                  |   7 +-
 arch/arm/boot/dts/ls1021a-twr.dts                  |   6 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |  30 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |   2 +-
 arch/arm/boot/dts/vf500.dtsi                       |   2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |  20 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |   4 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |   4 +
 arch/arm/boot/dts/vfxxx.dtsi                       |  10 +-
 101 files changed, 5005 insertions(+), 1058 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt
 create mode 100644 arch/arm/boot/dts/imx28-ts4600.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard2-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-ts7970.dts
 create mode 100644 arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard2-emmc-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard2.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ts7970.dts
 create mode 100644 arch/arm/boot/dts/imx6q-var-dt6customboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
 rename arch/arm/boot/dts/{imx6qdl-microsom.dtsi => imx6qdl-sr-som-brcm.dtsi} (85%)
 create mode 100644 arch/arm/boot/dts/imx6qdl-sr-som-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi
 rename arch/arm/boot/dts/{imx6qdl-microsom-ar8035.dtsi => imx6qdl-sr-som.dtsi} (84%)
 create mode 100644 arch/arm/boot/dts/imx6qdl-ts7970.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-var-dart.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-pico-pi.dts
 rename arch/arm/boot/dts/{imx7d-pico.dts => imx7d-pico.dtsi} (71%)
 create mode 100644 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
