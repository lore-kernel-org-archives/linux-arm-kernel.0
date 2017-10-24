From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Oct 2017 20:20:43 +0800
Subject: [GIT PULL 2/4] i.MX device tree updates for 4.15
In-Reply-To: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
References: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1508847645-9191-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.15

for you to fetch changes up to 27e1acb759e0409ee140f3bdaf5c70c5582ddf91:

  ARM: dts: imx53-tx53: fix interrupt flags (2017-10-24 14:23:58 +0800)

----------------------------------------------------------------
i.MX device tree updates for 4.15:
 - New board support: i.MX51 ZII RDU1, i.MX53 GE Healthcare PPD, i.MX6
   TX modules for MB7 from  Ka-Ro Electronics, i.MX6 Wandboard revd1
   variants, i.MX6 LWN DISPLAY5 board, Pistachio i.MX6Q board, i.MX6SX
   Vining-2000 board.
 - Use the 'vpcie-supply' property for PCIe device for boards
   imx6qdl-sabresd, imx6q-novena and imx6q-cm-fx6.
 - A series from Jagan Teki to update imx6qdl-icore board with audio,
   touch and CAN support.
 - Switch to nvmem for accessing OCOTP from tempmon for i.MX6SX and add
   tempmon support for i.MX6UL.
 - A bunch of patches from Lothar Wa?mann updating Ka-Ro i.MX28, i.MX53
   and i.MX6 TX modules.
 - Fix DTC warnings in i.MX device trees, dropping leading zeros from
   unit address, correcting display nodes notation and display port
   names, fixing nodes with unit name and no reg property.
 - Other random device updates for various board support.

----------------------------------------------------------------
Christoph Fritz (1):
      ARM: dts: imx6sx: add vining-2000 board support

Christopher Spinrath (1):
      ARM: dts: imx6q-utilite-pro: add HDMI CEC pinctrl

Fabien Lahoudere (1):
      ARM: dts: imx53: Add GE Healthcare PPD

Fabio Estevam (12):
      ARM: dts: imx6qdl-sabresd: Use the 'vpcie-supply' property
      ARM: dts: imx6qdl-sabresd: Add CEC support
      ARM: dts: imx25-pdk: Add touchscreen support
      ARM: dts: imx6qdl-wandboard: Add support for the revd1 variants
      ARM: dts: imx6q-novena: Use the 'vpcie-supply' property
      ARM: dts: imx6q-cm-fx6: Use the 'vpcie-supply' property
      ARM: dts: imx6qp-wandboard-revd1: Add sata support
      ARM: dts: imx6ul-pico-hobbit: Fix the 'interrupts' property
      ARM: dts: imx6sx-softing-vining-2000: Fix the 'interrupt-parent' property
      ARM: dts: imx35-eukrea-mbimxsd35-baseboard: Fix the 'cd-gpios' property
      ARM: dts: imx50: Pass the 'dma-cells' property
      ARM: dts: imx25-eukrea-mbimxsd25-baseboard: Fix the 'cd-gpios' property

Jagan Teki (5):
      ARM: dts: imx6qdl-icore: Add Sound card support
      ARM: dts: imx6qdl-icore-rqs: Move Sound nodes to dtsi
      ARM: dts: imx6qdl-icore-rqs: Switch to use simple-audio-card
      ARM: dts: imx6dl-icore: Add touchscreen node
      ARM: dts: imx6qdl-icore-rqs: Add CAN nodes

Leonard Crestez (2):
      ARM: dts: imx6sx: Use nvmem-cells for tempmon
      ARM: dts: imx6ul: Add imx6ul-tempmon

Lothar Wa?mann (23):
      ARM: dts: imx28-tx28: Relicense the TX28 dts file under GPLv2/X11
      ARM: dts: imx28-tx28: remove the regulators bus
      ARM: dts: imx28-tx28: add trickle-charge config for DS1339
      ARM: dts: imx53-tx53: Relicense the TX53 dts files under GPLv2/X11
      ARM: dts: imx53-tx53: remove the regulators bus
      ARM: dts: imx53-tx53: remove obsolete eeti,egalax_ts
      ARM: dts: imx53-tx53: add trickle-charge config for DS1339
      ARM: dts: imx53-tx53: use explicit pad_ctl settings for I2C pins
      ARM: dts: imx53-tx53: add support for I2C bus recovery
      ARM: dts: imx6-tx6: update model property to match current module HW revision
      ARM: dts: imx6-tx6: remove obsolete eeti,egalax_ts
      ARM: dts: imx6-tx6: remove obsolete ipu1 alias
      ARM: dts: imx6-tx6: add trickle-charge config for DS1339
      ARM: dts: imx6-tx6: improve ethernet related pinctrl setup
      ARM: dts: imx6-tx6: specify ethernet phy reset post-delay
      ARM: dts: imx6-tx6: convert to using simple-audio-card
      ARM: dts: imx6-tx6: add support for I2C bus recovery
      ARM: dts: imx6-tx6: move display configuration to .dtsi file
      ARM: dts: imx6-tx6: add a .dtsi file for the MB7 baseboard
      ARM: dts: imx: add support for TX6QP
      ARM: dts: imx: add support for TX6 modules on MB7 baseboard
      ARM: dts: imx28-tx28: fix interrupt flags
      ARM: dts: imx53-tx53: fix interrupt flags

Lucas Stach (3):
      ARM: dts: imx6: RDU2: disable over-current detection on USB H1
      ARM: dts: imx6: RDU2: disallow RMI4 device sleep
      ARM: dts: imx: add ZII RDU1 board

Lukasz Majewski (1):
      ARM: dts: display5: Device tree description of LWN's DISPLAY5 board

Marco Franchi (9):
      ARM: dts: imx6ul: Remove leading zeroes from unit addresses
      ARM: dts: imx6qdl: Remove leading zeroes from unit addresses
      ARM: dts: imx: Fix incorrect display nodes notation
      ARM: dts: imx51: Fix inconsistent display port names
      ARM: dts: imx51-apf51dev: Fix 'backlight at bl1' node with unit name and no reg property
      ARM: dts: imx51-ts4800: Fix 'port at 0' node with unit name and no reg property
      ARM: dts: imx53: Fix 'usbphy at x' node with unit name and no reg property
      ARM: dts: imx53-m53evk: Fix 'led_gpio at 0' node with unit name and no reg property
      ARM: dts: imx53-qsb-common: Fix 'led_gpio7_7 at 0' node with unit name and no reg property

Martyn Welch (1):
      dt-bindings: misc: achc: Add device tree binding for GE ACHC

Philipp Zabel (1):
      ARM: dts: imx6ul-14x14-evk: switch lcdif pixel clock to video pll

Tim Harvey (1):
      ARM: dts: imx: ventana: remove container node from iomuxc nodes

Vanessa Maegima (1):
      ARM: dts: imx7d-pico: Add Wifi support

YuanCheng Cheng (1):
      ARM: dts: Add initial Pistachio i.mx6q board support.

 Documentation/devicetree/bindings/misc/ge-achc.txt |   26 +
 arch/arm/boot/dts/Makefile                         |   20 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |    2 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |    8 +
 arch/arm/boot/dts/imx28-tx28.dts                   |  175 ++--
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |    2 +-
 arch/arm/boot/dts/imx50.dtsi                       |    1 +
 arch/arm/boot/dts/imx51-apf51dev.dts               |   10 +-
 arch/arm/boot/dts/imx51-babbage.dts                |   12 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 |    8 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |  834 ++++++++++++++++
 arch/arm/boot/dts/imx51.dtsi                       |    4 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |    4 +-
 arch/arm/boot/dts/imx53-mba53.dts                  |    2 +-
 arch/arm/boot/dts/imx53-ppd.dts                    | 1042 ++++++++++++++++++++
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |    4 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |   84 +-
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |  114 +--
 arch/arm/boot/dts/imx53-tx53.dtsi                  |  166 ++--
 arch/arm/boot/dts/imx53.dtsi                       |    4 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |    2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |    2 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-icore.dts                 |    9 +
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          |   74 +-
 arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts         |   48 +
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts             |  171 +---
 arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts         |   48 +
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts             |  171 +---
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts             |  161 +--
 arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts         |   48 +
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts             |  170 +---
 arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts         |   48 +
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts             |  132 +--
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts         |  215 +---
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts       |   22 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   16 +-
 arch/arm/boot/dts/imx6q-apalis-eval.dts            |    2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      |    2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |    2 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |    5 +-
 .../dts/imx6q-display5-tianma-tm070-1280x768.dts   |   51 +
 arch/arm/boot/dts/imx6q-display5.dtsi              |  596 +++++++++++
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |  215 ++--
 arch/arm/boot/dts/imx6q-icore-rqs.dts              |   24 -
 arch/arm/boot/dts/imx6q-novena.dts                 |    2 +-
 arch/arm/boot/dts/imx6q-pistachio.dts              |  693 +++++++++++++
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       |   74 +-
 arch/arm/boot/dts/imx6q-tx6q-1010.dts              |  163 +--
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       |   74 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts              |  162 +--
 arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts          |   48 +
 arch/arm/boot/dts/imx6q-tx6q-1036.dts              |  170 +---
 arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts          |   48 +
 arch/arm/boot/dts/imx6q-tx6q-1110.dts              |  134 +--
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts          |  222 +----
 arch/arm/boot/dts/imx6q-utilite-pro.dts            |    8 +
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts        |   26 +
 arch/arm/boot/dts/imx6q.dtsi                       |   16 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |    2 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  300 +++---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  370 ++++---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  356 ++++---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  384 ++++----
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |  182 ++--
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |  174 ++--
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |   94 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |   97 ++
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |    2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |    2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   10 +-
 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi             |  252 +++++
 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi            |  286 ++++++
 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi             |   99 ++
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |  104 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi     |  196 ++++
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |    3 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  178 ++--
 arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts        |   48 +
 arch/arm/boot/dts/imx6qp-tx6qp-8037.dts            |   86 ++
 arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts        |   57 ++
 arch/arm/boot/dts/imx6qp-tx6qp-8137.dts            |   90 ++
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts       |   26 +
 arch/arm/boot/dts/imx6qp.dtsi                      |    2 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts   |  572 +++++++++++
 arch/arm/boot/dts/imx6sx.dtsi                      |   13 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |    2 +
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |    2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |    2 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |  161 +--
 arch/arm/boot/dts/imx7d-pico.dts                   |   39 +
 94 files changed, 7269 insertions(+), 3526 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/ge-achc.txt
 create mode 100644 arch/arm/boot/dts/imx51-zii-rdu1.dts
 create mode 100644 arch/arm/boot/dts/imx53-ppd.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dts
 create mode 100644 arch/arm/boot/dts/imx6q-display5.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-pistachio.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-wandboard-revd1.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-lvds.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8037.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-tx6qp-8137.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
