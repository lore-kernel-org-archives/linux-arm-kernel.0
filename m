From: tony@atomide.com (Tony Lindgren)
Date: Thu,  1 Sep 2016 08:45:20 -0700
Subject: [GIT PULL 2/3] omap dts updates for v4.9 merge window
In-Reply-To: <pull-1472744519-445833>
References: <pull-1472744519-445833>
Message-ID: <pull-1472744519-445833-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.9/dt-pt1-signed

for you to fetch changes up to 5c4d9f0d49b0c3beda734687248fc74542566ee9:

  ARM: dts: dra7: Add missing unit name to memory nodes (2016-08-31 07:40:28 -0700)

----------------------------------------------------------------
DTS related changes for omaps for v4.9 merge window:

- Update elm phandle for am335x

- Fix overo NAND gpmc ranges, this has always been broken so it can
  wait for the merge window

- Fix NAND and use NAND ready pin for logicpd gpmc, this can wait too
  as it's been using the older configration since the dts got added

- A series of dtc warning fixes for unit names

- Keep dcdc3, 5 and 6 enabled during suspend on am347x boards

- Disable DDR regulator during rtc-only/poweroff mode for am437x boards

- Remove redundant regulator compatibles for am437x boards

- Increas QSPI max frequency for dra7 boards

- Enable QSPI for am57xx-idk-common

- Enable am335x-wega audio support

- Workaround for i845 for dra7

- Update binding for logicpd boards

- Add gpio-decoder nodes for am335x-icev2 board

- Add linux,pci-domain property for dra7

- Fix dra7 clock data gmac_gmii_ref_clk_div and related clock tree
  entries, these can wait for merge window as Ethernet works on dra7

- A series of changes to drop skeleton.dtsi because of dtc warnings

----------------------------------------------------------------
Adam Ford (3):
      ARM: dts: logicpd-torpedo-som: Provide NAND ready pin
      ARM: dts: logicpd-somlv: Fix NAND device nodes
      ARM: dts: Add LogicPD DM37/AM37 Torpedo and SOM-LV

Grygorii Strashko (1):
      ARM: dts: dra7: cpsw: fix clocks tree

J.D. Schroeder (1):
      ARM: dts: dra7: Fix clock data for gmac_gmii_ref_clk_div

Javier Martinez Canillas (33):
      ARM: dts: omap3/am4372: add missing unit name to ocp node
      ARM: dts: omap3: overo: add missing unit name for lcd35 display
      ARM: dts: am335x/am437x: remove unneeded unit name for gpio-matrix-keypad
      ARM: dts: am335x/am437x: remove unneeded unit name for fixed regulators
      ARM: dts: da850/dm81x: remove unneeded unit name for fixed regulators
      ARM: dts: omap3/dra62x: remove unneeded unit name for fixed regulators
      ARM: dts: am335x/am437x: remove unneeded unit name for gpio-keys nodes
      ARM: dts: omap3/4: remove unneeded unit name for gpio-keys nodes
      ARM: dts: am335x/437x/57xx: remove unneeded unit name for gpio-leds nodes
      ARM: dts: omap3/4/5/dra7: remove unneeded unit name for gpio-leds nodes
      ARM: am335x: Add missing memory node in sl50 board
      ARM: omap3: Add missing memory node in overo and torpedo boards
      ARM: dts: omap2: Remove skeleton.dtsi usage
      ARM: dts: omap3: Remove skeleton.dtsi usage
      ARM: dts: omap4: Remove skeleton.dtsi usage
      ARM: dts: omap5: Remove skeleton.dtsi usage
      ARM: dts: am33xx: Remove skeleton.dtsi usage
      ARM: dts: dm814x: Remove skeleton.dtsi usage
      ARM: dts: dm816x: Remove skeleton.dtsi usage
      ARM: dts: dra7: Remove skeleton.dtsi usage
      ARM: dts: am4372: Remove skeleton.dtsi usage
      ARM: dts: omap2: Add missing unit name to memory nodes
      ARM: dts: omap3: Add missing unit name to memory nodes
      ARM: dts: omap4: Add missing unit name to memory nodes
      ARM: dts: omap5: Add missing unit name to memory nodes
      ARM: dts: am335x: Add missing unit name to memory nodes
      ARM: dts: am3517: Add missing unit name to memory nodes
      ARM: dts: am4372: Add missing unit name to memory nodes
      ARM: dts: am572x: Add missing unit name to memory nodes
      ARM: dts: dm8148: Add missing unit name to memory nodes
      ARM: dts: dm8168: Add missing unit name to memory nodes
      ARM: dts: dra62x: Add missing unit name to memory nodes
      ARM: dts: dra7: Add missing unit name to memory nodes

Johan Hovold (2):
      ARM: dts: overo: fix gpmc nand cs0 range
      ARM: dts: overo: fix gpmc nand on boards with ethernet

Keerthy (5):
      ARM: dts: AM437X-GP-EVM: AM437X-SK-EVM: Make dcdc3 dcdc5 and dcdc6 enable during suspend
      ARM: dts: AM437X-GP-EVM: Remove redundant regulator compatibles
      ARM: dts: AM437X-SK-EVM: Remove redundant regulator compatibles
      ARM: dts: AM437X-CM-T43: Remove redundant regulator compatibles
      ARM: dts: AM43X-EPOS-EVM: Remove redundant regulator compatibles

Kishon Vijay Abraham I (1):
      ARM: dts: DRA7: Add "linux,pci-domain" property for pci dt nodes

Sekhar Nori (1):
      ARM: dts: dra7: workaround silicon limitation i845

Stefan M?ller-Klieser (1):
      ARM: dts: am335x-wega: Add audio support

Teresa Remmet (1):
      ARM: dts: am335x: Update elm phandle binding

Tero Kristo (2):
      ARM: dts: am437x-gp-evm: disable DDR regulator in rtc-only/poweroff mode
      ARM: dts: am437x-sk-evm: disable DDR regulator in rtc-only/poweroff mode

Vignesh R (3):
      ARM: dts: dra7xx: Increase spi-max-frequency to 76.8MHz for QSPI
      ARM: dts: am57xx-idk-common: Enable support for QSPI
      ARM: dts: am335x-icev2: Add nodes for gpio-decoder

 .../devicetree/bindings/arm/omap/omap.txt          |  6 ++
 arch/arm/boot/dts/am335x-baltos.dtsi               |  8 +--
 arch/arm/boot/dts/am335x-base0033.dts              |  4 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          | 12 ++--
 arch/arm/boot/dts/am335x-chilisom.dtsi             |  2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               |  8 +--
 arch/arm/boot/dts/am335x-evm.dts                   | 16 +++---
 arch/arm/boot/dts/am335x-evmsk.dts                 | 28 +++++-----
 arch/arm/boot/dts/am335x-icev2.dts                 | 47 +++++++++-------
 arch/arm/boot/dts/am335x-igep0033.dtsi             | 10 ++--
 arch/arm/boot/dts/am335x-lxm.dts                   |  6 +-
 arch/arm/boot/dts/am335x-nano.dts                  |  4 +-
 arch/arm/boot/dts/am335x-pepper.dts                | 18 +++---
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |  6 +-
 arch/arm/boot/dts/am335x-shc.dts                   | 16 +++---
 arch/arm/boot/dts/am335x-sl50.dts                  | 15 +++--
 arch/arm/boot/dts/am335x-wega.dtsi                 | 64 +++++++++++++++++++++-
 arch/arm/boot/dts/am33xx.dtsi                      |  4 +-
 arch/arm/boot/dts/am3517-craneboard.dts            |  2 +-
 arch/arm/boot/dts/am3517-evm.dts                   |  2 +-
 arch/arm/boot/dts/am3517.dtsi                      |  2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts            |  2 +-
 arch/arm/boot/dts/am4372.dtsi                      | 10 +++-
 arch/arm/boot/dts/am437x-cm-t43.dts                |  6 --
 arch/arm/boot/dts/am437x-gp-evm.dts                | 21 ++++---
 arch/arm/boot/dts/am437x-idk-evm.dts               |  2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                | 45 +++++++++++----
 arch/arm/boot/dts/am43x-epos-evm.dts               | 11 +---
 arch/arm/boot/dts/am572x-idk.dts                   |  2 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            | 10 ++--
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |  4 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           | 49 +++++++++++++++++
 arch/arm/boot/dts/da850-evm.dts                    |  2 +-
 arch/arm/boot/dts/dm8148-evm.dts                   |  4 +-
 arch/arm/boot/dts/dm8148-t410.dts                  |  4 +-
 arch/arm/boot/dts/dm814x.dtsi                      |  4 +-
 arch/arm/boot/dts/dm8168-evm.dts                   |  4 +-
 arch/arm/boot/dts/dm816x.dtsi                      |  4 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |  4 +-
 arch/arm/boot/dts/dra7-evm.dts                     | 14 ++---
 arch/arm/boot/dts/dra7.dtsi                        | 10 ++--
 arch/arm/boot/dts/dra72-evm-common.dtsi            |  4 +-
 arch/arm/boot/dts/dra72-evm-revc.dts               |  2 +-
 arch/arm/boot/dts/dra72-evm.dts                    |  2 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi               | 15 +++--
 arch/arm/boot/dts/logicpd-som-lv.dtsi              | 11 ++--
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |  6 ++
 arch/arm/boot/dts/omap2.dtsi                       |  4 +-
 arch/arm/boot/dts/omap2420-h4.dts                  |  2 +-
 arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  2 +-
 arch/arm/boot/dts/omap2430-sdp.dts                 |  2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |  2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |  2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts               |  2 +-
 arch/arm/boot/dts/omap3-evm.dts                    |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  2 +-
 arch/arm/boot/dts/omap3-igep.dtsi                  |  2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |  2 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |  2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  6 +-
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |  2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi            | 10 +++-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |  6 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |  4 +-
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi   |  4 +-
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |  4 +-
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     |  2 -
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi  |  3 -
 arch/arm/boot/dts/omap3-pandora-common.dtsi        | 10 ++--
 arch/arm/boot/dts/omap3-sniper.dts                 |  2 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi               |  2 +-
 arch/arm/boot/dts/omap3-zoom3.dts                  |  2 +-
 arch/arm/boot/dts/omap3.dtsi                       |  6 +-
 arch/arm/boot/dts/omap3430-sdp.dts                 |  2 +-
 arch/arm/boot/dts/omap34xx.dtsi                    |  2 +-
 arch/arm/boot/dts/omap36xx.dtsi                    |  2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |  2 +-
 arch/arm/boot/dts/omap4-duovero.dtsi               |  2 +-
 arch/arm/boot/dts/omap4-kc1.dts                    |  2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi          |  2 +-
 arch/arm/boot/dts/omap4-sdp.dts                    |  2 +-
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |  2 +-
 arch/arm/boot/dts/omap4.dtsi                       |  4 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  4 +-
 arch/arm/boot/dts/omap5-igep0050.dts               |  2 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |  2 +-
 arch/arm/boot/dts/omap5.dtsi                       |  2 -
 92 files changed, 415 insertions(+), 248 deletions(-)
