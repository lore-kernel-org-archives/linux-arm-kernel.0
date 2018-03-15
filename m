From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Mar 2018 19:36:38 +0800
Subject: [GIT PULL 4/6] i.MX device tree updates for 4.17
In-Reply-To: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1521113800-16401-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.17

for you to fetch changes up to f4be9b77fac3d8141add1d84e75199f0e0ddd5a3:

  ARM: dts: i.MX25: define SSI FIFO depth (2018-03-12 15:23:36 +0800)

----------------------------------------------------------------
i.MX device tree updates for 4.17:
 - New board support: phyBOARD-Mira i.MX6 boards; Advantech DMS-BA16
   i.MX6Q board; Toradex Colibri iMX6ULL boards.
 - ZII RDU board updates: add RAVE SP device; disable on-chip watchdog
   as the external watchdog is being used instead; improve USDHC node
   regarding to voltage and SDIO capability.
 - i.MX6UL/ULL updates: cpufreq clock cleanup; add IOMUXC_SNVS pins and
   missing daisy chain configurations; add more devices like WDOG3,
   UART8, PMU, architected timer etc.
 - Hummingboard updates: correct USBOTG-ID pin; remove mention of
   nonexistent node.
 - Fix compatibles of atmel eeprom devices.
 - A couple of improvements on i.MX25 pinfunc header regarding to eSDHC
   pins.
 - A bunch of patches from Fabio and Marco to fix DTC warnings seen with
   W=1 switch.
 - Remove GPU subsystem nodes, as they are not needed by the etnaviv
   driver anymore and have been removed from the binding.
 - Add FIFO depth definition for i.MX25 SSI devices.
 - Add missing '#sound-dai-cells' for sgtl5000 codec which is complained
   by DTC.
 - Miscellaneous and random updates.

----------------------------------------------------------------
Aapo Vienamo (1):
      ARM: dts: imx7d: cl-som-imx7: fix pinctrl_enet

Andrey Smirnov (2):
      ARM: dts: imx6: RDU2: Add RAVE SP device
      ARM: dts: imx51-zii-rdu1: Add node for RAVE SP device

Anson Huang (4):
      ARM: dts: imx6ul: remove unnecessary clocks for cpu-freq
      ARM: dts: imx6sx: add pu power domain support
      ARM: dts: imx6sx: add ARM power domain support
      ARM: dts: imx7s: add temperature monitor support

Bai Ping (1):
      ARM: dts: imx6ull: add additional pinfunc defines for i.MX 6ULL

Bartosz Golaszewski (3):
      ARM: dts: use 'atmel' as at24 manufacturer for imx6qdl-zii-rdu2
      ARM: dts: use 'atmel' as at24 manufacturer for imx6qdl-rex
      ARM: dts: fix the at24 compatible string in imx6q-h100

Baruch Siach (1):
      ARM: dts: hummingboard: Remove mention of nonexistent node

Beno?t Th?baudeau (2):
      ARM: dts: imx25-pinfunc: Use consistent naming for eSDHC
      ARM: dts: imx25-pinfunc: Always set SION for eSDHC CMD

Christian Hemp (2):
      ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6Quad/Dual RDK
      ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6 DualLight/Solo RDK

Enrico Scholz (1):
      ARM: dts: imx6: Add support for phyBOARD-Mira with i.MX 6QuadPlus

Fabio Estevam (15):
      ARM: dts: imx23: Pass unit address and reg to IOMUX node
      ARM: dts: imx28: Pass unit address and reg to IOMUX node
      ARM: dts: imx28-tx28: Pass unit address and reg to IOMUX node
      ARM: dts: imx28-apx4devkit: Pass unit address and reg to IOMUX node
      ARM: dts: imx28-cfa10049: Move i2cmux out of bus node
      ARM: dts: imx27-eukrea-mbimxsd27-baseboard: Pass missing unit address
      ARM: dts: imx27-eukrea-cpuimx27: Put the clock node directly into root
      ARM: dts: imx28-tx28: Pass the memory unit name
      ARM: dts: imx6: Pass memory unit-adress
      ARM: dts: imx5: Pass the memory unit-address
      ARM: dts: vf500: Remove skeleton.dtsi inclusion
      ARM: dts: vf: Add memory node unit name
      ARM: dts: vf500: Remove the zero length reg property
      ARM: dts: vf610m4: Remove skeleton.dtsi inclusion
      ARM: dts: vf610m4: Remove the zero length reg property

Fugang Duan (1):
      ARM: dts: imx6ul: update i.MX 6UltraLite iomux headers

Ian Ray (1):
      ARM: dts: imx6q-bx50v3: disable SD card

Jon Nettleton (1):
      ARM: dts: imx6qdl-hummingboard: fix USBOTG-ID pin

J?rg Krause (2):
      ARM: dts: imx6ul: rename mux mode name REF_CLK_32K to OSC32K_32K_OUT
      ARM: dts: imx6ul: add wdog3 node

Ken Lin (1):
      ARM: dts: imx: Add support for Advantech DMS-BA16

Lothar Wa?mann (2):
      ARM: dts: imx6ull: fix the imx6ull-14x14-evk configuration
      ARM: dts: imx6dl: remove 'lcdif' node

Lucas Stach (3):
      ARM: dts: imx6: RDU2: disable internal watchdog
      ARM: dts: imx6: RDU2: detail USDHC description
      ARM: dts: imx6: remove GPU subsystem nodes

Marco Franchi (5):
      ARM: dts: imx6ul-evk: Add support for mag3110 sensor
      ARM: dts: imx7d-sdb: Add support for mpl3115 sensor
      ARM: dts: imx: Pass empty memory size on board dts
      ARM: dts: imx: Remove empty memory size nodes
      ARM: dts: imx: Add memory node unit name

Martin Kaiser (1):
      ARM: dts: i.MX25: define SSI FIFO depth

Martyn Welch (1):
      ARM: dts: imx53-ppd: Add touchscreen reset line

Peter Senna Tschudin (1):
      ARM: dts: imx6q-bx50v3: Enable secure-reg-access

Rasmus Villemoes (1):
      ARM: dts: ls1021a: add nodes for on-chip ram

Rob Herring (1):
      ARM: dts: imx: Add missing #sound-dai-cells for sgtl5000 codec

Ryan Harkin (1):
      ARM: dts: imx7s-warp: enable uart6 on mikroBus

Sebastian Reichel (1):
      ARM: dts: imx53-ppd: use PMIC's TSI pins in adc mode

Shyam Saini (1):
      ARM: dts: imx6dl-icore-rqs: Fix invalid PHY address assignment for ethernet

Stefan Agner (8):
      ARM: dts: imx6ul: add interrupt of virt-capable GIC
      ARM: dts: imx6ul: add ARM architected timer
      ARM: dts: imx6ull: add IOMUXC SNVS instance
      ARM: dts: imx6ull: add UART8 support
      ARM: dts: imx6ull: add Toradex Colibri iMX6ULL support
      ARM: dts: imx6dl-colibri-eval-v3: Add chosen node
      ARM: dts: imx7: add CPU PMU support
      ARM: dts: imx7s: add spba-bus abstraction

Stefan Riedmueller (2):
      ARM: dts: imx6: Add initial support for phyCORE-i.MX 6 SOM
      ARM: dts: imx6: Add initial support for phyBOARD-Mira

 arch/arm/boot/dts/Makefile                         |   9 +-
 arch/arm/boot/dts/imx1-ads.dts                     |   2 +-
 arch/arm/boot/dts/imx1-apf9328.dts                 |   2 +-
 arch/arm/boot/dts/imx1.dtsi                        |   2 +-
 arch/arm/boot/dts/imx23-evk.dts                    |   2 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |   2 +-
 arch/arm/boot/dts/imx23-sansa.dts                  |   2 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |   2 +-
 arch/arm/boot/dts/imx23-xfi3.dts                   |   2 +-
 arch/arm/boot/dts/imx23.dtsi                       |   8 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   2 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |  12 +-
 arch/arm/boot/dts/imx25-karo-tx25.dts              |   2 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |  14 +-
 arch/arm/boot/dts/imx25-pinfunc.h                  |  72 ++-
 arch/arm/boot/dts/imx25.dtsi                       |   4 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |   2 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |  17 +-
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |   2 +-
 arch/arm/boot/dts/imx27-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   2 +-
 arch/arm/boot/dts/imx27.dtsi                       |   2 +-
 arch/arm/boot/dts/imx28-apf28.dts                  |   2 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |   6 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |   2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               | 130 ++---
 arch/arm/boot/dts/imx28-duckbill-2-485.dts         |   2 +-
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts     |   2 +-
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts         |   2 +-
 arch/arm/boot/dts/imx28-duckbill-2.dts             |   2 +-
 arch/arm/boot/dts/imx28-duckbill.dts               |   2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts       |   2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts       |   2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi       |   1 +
 arch/arm/boot/dts/imx28-evk.dts                    |   3 +-
 arch/arm/boot/dts/imx28-m28.dtsi                   |   2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |   2 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |   1 +
 arch/arm/boot/dts/imx28-sps1.dts                   |   2 +-
 arch/arm/boot/dts/imx28-ts4600.dts                 |   2 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |  34 +-
 arch/arm/boot/dts/imx28.dtsi                       |  20 +-
 arch/arm/boot/dts/imx31-bug.dts                    |   2 +-
 arch/arm/boot/dts/imx31.dtsi                       |   2 +-
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |   2 +-
 arch/arm/boot/dts/imx35-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx35.dtsi                       |   2 +-
 arch/arm/boot/dts/imx50-evk.dts                    |   2 +-
 arch/arm/boot/dts/imx50.dtsi                       |   2 +-
 arch/arm/boot/dts/imx51-apf51.dts                  |   2 +-
 arch/arm/boot/dts/imx51-babbage.dts                |   3 +-
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  |   2 +-
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |   2 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 |   2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  14 +
 arch/arm/boot/dts/imx51.dtsi                       |   2 +-
 arch/arm/boot/dts/imx53-ard.dts                    |   2 +-
 arch/arm/boot/dts/imx53-cx9020.dts                 |   2 +-
 arch/arm/boot/dts/imx53-m53.dtsi                   |   2 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |   1 +
 arch/arm/boot/dts/imx53-ppd.dts                    |  12 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |   3 +-
 arch/arm/boot/dts/imx53-smd.dts                    |   2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   2 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |   1 +
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |   1 +
 arch/arm/boot/dts/imx53-tx53.dtsi                  |   5 +
 arch/arm/boot/dts/imx53-usbarmory.dts              |   2 +-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |   1 +
 arch/arm/boot/dts/imx53.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6dl-apf6dev.dts               |   2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |   2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts       |   2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |   2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |   2 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |   9 +
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts         |   5 +
 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts  |  64 +++
 arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi        |   2 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts             |   2 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   2 +-
 arch/arm/boot/dts/imx6dl-ts4900.dts                |   5 +
 arch/arm/boot/dts/imx6dl-ts7970.dts                |   5 +
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts       |   2 +-
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts       |   2 +-
 arch/arm/boot/dts/imx6dl-wandboard.dts             |   2 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |  10 -
 arch/arm/boot/dts/imx6q-apf6dev.dts                |   2 +-
 arch/arm/boot/dts/imx6q-arm2.dts                   |   2 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |   2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |   8 +
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |   2 +-
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts          |   5 +
 arch/arm/boot/dts/imx6q-display5.dtsi              |   2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   2 +-
 arch/arm/boot/dts/imx6q-dms-ba16.dts               | 139 ++++++
 arch/arm/boot/dts/imx6q-evi.dts                    |   2 +-
 arch/arm/boot/dts/imx6q-gk802.dts                  |   2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   2 +-
 arch/arm/boot/dts/imx6q-h100.dts                   |   7 +-
 arch/arm/boot/dts/imx6q-marsboard.dts              |   2 +-
 arch/arm/boot/dts/imx6q-mccmon6.dts                |   2 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |   5 +
 arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts   |  72 +++
 arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts   |  72 +++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |   2 +-
 arch/arm/boot/dts/imx6q-pistachio.dts              |   2 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts                |   2 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |   2 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts                |   2 +-
 arch/arm/boot/dts/imx6q-ts4900.dts                 |   5 +
 arch/arm/boot/dts/imx6q-ts7970.dts                 |   5 +
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts        |   2 +-
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts        |   2 +-
 arch/arm/boot/dts/imx6q-wandboard.dts              |   2 +-
 arch/arm/boot/dts/imx6q-zii-rdu2.dts               |   5 +
 arch/arm/boot/dts/imx6q.dtsi                       |   5 -
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   5 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |   5 +
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi              |   1 +
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  10 +-
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       |   9 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |   8 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |   2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   2 +-
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi         | 390 +++++++++++++++
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi  | 279 +++++++++++
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |   2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   4 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |   2 +-
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi            |   2 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |  22 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   4 +-
 arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts  |  72 +++
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts       |   2 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts              |   5 +
 arch/arm/boot/dts/imx6sl-evk.dts                   |   2 +-
 arch/arm/boot/dts/imx6sl-warp.dts                  |   2 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |   2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |   2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |   2 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts   |   2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts        |   2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts     |   2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts         |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  20 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             | 480 +-----------------
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 499 +++++++++++++++++++
 arch/arm/boot/dts/imx6ul-geam.dts                  |   3 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi                |   2 +-
 arch/arm/boot/dts/imx6ul-litesom.dtsi              |   2 +-
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi              |   2 +-
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |   2 +-
 arch/arm/boot/dts/imx6ul-pinfunc.h                 | 169 ++++---
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   4 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |  31 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts            |   5 +-
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts      |  14 +
 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi     | 157 ++++++
 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi     |  23 +
 arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts |  14 +
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi        |  65 +++
 arch/arm/boot/dts/imx6ull-colibri.dtsi             | 553 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h           |  26 +
 arch/arm/boot/dts/imx6ull.dtsi                     |  32 ++
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |  54 +-
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi          |   2 +-
 arch/arm/boot/dts/imx7d-colibri.dtsi               |   2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   2 +-
 arch/arm/boot/dts/imx7d-pico.dtsi                  |   2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   7 +-
 arch/arm/boot/dts/imx7s-colibri.dtsi               |   2 +-
 arch/arm/boot/dts/imx7s-warp.dts                   |  18 +-
 arch/arm/boot/dts/imx7s.dtsi                       | 242 +++++----
 arch/arm/boot/dts/ls1021a.dtsi                     |  16 +
 arch/arm/boot/dts/vf500-colibri.dtsi               |   2 +-
 arch/arm/boot/dts/vf500.dtsi                       |   7 +-
 arch/arm/boot/dts/vf610-colibri.dtsi               |   2 +-
 arch/arm/boot/dts/vf610-cosmic.dts                 |   2 +-
 arch/arm/boot/dts/vf610-twr.dts                    |   2 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |   2 +-
 arch/arm/boot/dts/vf610m4-colibri.dts              |   2 +-
 arch/arm/boot/dts/vf610m4.dtsi                     |   9 +-
 201 files changed, 3312 insertions(+), 998 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dms-ba16.dts
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h
