From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 19 Oct 2015 23:18:56 +0800
Subject: [GIT PULL 2/3] ARM: imx: device tree changes for 4.4
In-Reply-To: <1445267937-2952-1-git-send-email-shawnguo@kernel.org>
References: <1445267937-2952-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1445267937-2952-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

This is the i.MX device tree updates for 4.4.  To resolve the dependency
between clock drivers and DTS files on some new clock ID additions, the
i.MX clock change set imx-clk-4.4 are pulled into the branch.  The clock
changes has been pulled by Stephen and will be stable.

Shawn


The following changes since commit 84a87250ee4e4f7cf5865be9757e2ea758e5cae3:

  clk: imx6: Add SPDIF_GCLK clock in clock tree (2015-10-12 21:55:59 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.4

for you to fetch changes up to 607e266c47ef552b6f87c7cf0ba7f3c28ea5af14:

  ARM: dts: ls1021a: Add quirk for Erratum A009116 (2015-10-19 22:45:43 +0800)

----------------------------------------------------------------
The i.MX device tree changes for 4.4:
 - Add IOMUXC LPSR (Low Power State Retention) device for i.MX7D.
 - Add a few low power mode related devices and touch controller for
   i.MX6UL.
 - Add a number of devices for i.MX7D SDB board support, USB, Dual FEC,
   and eMMC5.0.
 - i.MX6 Boundary Devices updates: relicense under GPLv2/X11, add Okaya
   LCD, touch and wifi support, add new boards Nitrogen6_Lite and
   Nitrogen6_Max.
 - Enable touch screen and NAND Flash controller for a few Vybrid
   devices.
 - Some random and small updates on LS1021A and MXS support.

----------------------------------------------------------------
Adrian Alonso (2):
      ARM: dts: imx7d-pinfunc: add gpio1 pad iomux settings
      ARM: dts: imx: imx7d add iomuxc lpsr device node

Alison Wang (1):
      ARM: ls1021a: Add dma-coherent property for eTSEC nodes

Anson Huang (3):
      ARM: dts: imx6ul: add sram support for i.mx6ul
      ARM: dts: imx6ul: add mmdc support for i.mx6ul
      ARM: dts: imx6ul: add pm_power_off support

Fabio Estevam (4):
      ARM: dts: imx6sl: Complete the dcp node
      ARM: dts: imx7d: Add PWM support
      ARM: dts: imx7d: Add USB support
      ARM: dts: imx7d-sdb: Add USB support

Fugang Duan (2):
      ARM: dts: imx7d: add fec1 and fec2 support for i.MX7d soc
      ARM: dts: imx7d-sdb: add fec1 and fec2 support

Gary Bisson (11):
      ARM: dts: imx6qdl-nitrogen6x: add Okaya LCD panel
      ARM: dts: imx6qdl-sabrelite: add Okaya LCD panel
      ARM: dts: imx6dql-nitrogen6x: add touchscreen support
      ARM: dts: imx6qdl-nitrogen6x: add wifi wl1271 support
      ARM: dts: imx6qdl-nitrogen6x: relicense under GPLv2/X11
      ARM: dts: imx6qdl-sabrelite: relicense under GPLv2/X11
      of: Add Boundary Devices Inc. vendor prefix
      ARM: dts: imx6q-nitrogen6x: change manufacturer to Boundary Devices
      ARM: dts: imx6dl-nitrogen6x: change manufacturer to Boundary Devices
      ARM: dts: imx: add Boundary Devices Nitrogen6_Max board
      ARM: dts: imx: add Boundary Devices Nitrogen6_Lite board

Haibo Chen (3):
      ARM: dts: imx7d-sdb: add eMMC5.0 support
      ARM: dts: imx6ul.dtsi: add TSC support
      ARM: dts: imx6ul-14x14-evk.dts: add tsc support

Horia Geant? (1):
      ARM: dts: ls1021a: add crypto node

Laurent Pinchart (1):
      ARM: imx6sx-sdb: Fix typo in regulator enable GPIO property

Michael Opdenacker (1):
      ARM: dts: imx6: phyFLEX: fix typo in "pinctrl-names"

Rafa? Mi?ecki (1):
      ARM: dts: imx: add "jedec,spi-nor" flash compatible binding

Rajesh Bhagat (1):
      ARM: dts: ls1021a: Add quirk for Erratum A009116

Sanchayan Maity (1):
      ARM: dts: vf500-colibri: Add device tree node for touchscreen support

Shawn Guo (1):
      Merge tag 'imx-clk-4.4' into imx/dt

Shengjiu Wang (1):
      ARM: dts: imx6: change the core clock of spdif

Stefan Agner (2):
      ARM: dts: vf610twr: add NAND flash controller peripherial
      ARM: dts: vf-colibri: enable NAND flash controller

Stefan Wahren (1):
      ARM: mxs: enable ocotp for i.MX23 and i.MX28

Vladimir Zapolskiy (2):
      ARM: dts: i.MX31: fix cpu compatible value
      ARM: dts: i.MX35: fix cpu compatible value

Yuan Yao (1):
      ARM: dts: Add node for ina220 on LS1021ATWR

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/imx23.dtsi                       |   6 +-
 arch/arm/boot/dts/imx28-evk.dts                    |   2 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   6 +-
 arch/arm/boot/dts/imx31.dtsi                       |   2 +-
 arch/arm/boot/dts/imx35.dtsi                       |   2 +-
 arch/arm/boot/dts/imx50-evk.dts                    |   2 +-
 arch/arm/boot/dts/imx53-smd.dts                    |   2 +-
 arch/arm/boot/dts/imx6dl-nit6xlite.dts             |  49 ++
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts            |  44 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts             |   2 +-
 arch/arm/boot/dts/imx6dl-sabrelite.dts             |  40 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   2 +-
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts          |  53 ++
 arch/arm/boot/dts/imx6q-nitrogen6x.dts             |  44 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts                |   2 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  40 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |   2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           | 630 +++++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       | 873 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          | 189 ++++-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   6 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           | 118 ++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  12 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |   2 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  21 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts              |   4 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                   |   4 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  22 +
 arch/arm/boot/dts/imx6ul.dtsi                      |  29 +
 arch/arm/boot/dts/imx7d-pinfunc.h                  | 122 ++-
 arch/arm/boot/dts/imx7d-sdb.dts                    | 100 ++-
 arch/arm/boot/dts/imx7d.dtsi                       | 165 ++++
 arch/arm/boot/dts/ls1021a-twr.dts                  |  13 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  44 ++
 arch/arm/boot/dts/vf-colibri.dtsi                  |  39 +
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |   5 +
 arch/arm/boot/dts/vf500-colibri.dtsi               |  47 ++
 arch/arm/boot/dts/vf610-twr.dts                    |  47 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  11 +
 49 files changed, 2744 insertions(+), 78 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-nit6xlite.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6_max.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
