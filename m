From: shawnguo@kernel.org (Shawn Guo)
Date: Mon,  1 Oct 2018 15:20:01 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.20
In-Reply-To: <20181001072003.16238-1-shawnguo@kernel.org>
References: <20181001072003.16238-1-shawnguo@kernel.org>
Message-ID: <20181001072003.16238-3-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.20

for you to fetch changes up to 04007fe4c65f4cf3133dd256d9fd82169b7f2f22:

  ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support (2018-09-30 15:32:18 +0800)

----------------------------------------------------------------
i.MX device tree update for 4.20:
 - New board support: Engicam's i.Core MX6 CPU module v1.5; ConnectCore
   6UL Single Board Computer (SBC) Pro; i.MX6 ULZ based EVK board.
 - Add Add SFF interface support for vf610-zii board.
 - Disable unneeded devices like VPU and internal watchdog for imx51-zii
   boards.
 - Add 'no-sdio' and 'no-sd' property for vf610-zii-cfu1 board.
 - Improve i.MX6 SLL GPIO support by adding gpio-ranges property and
   clocks information.
 - Update iomux header for i.MX7 Solo and i.MX6 ULL.
 - Enable GPIO buttons as wakeup source for imx7d-sdb and imx6sx-sdb.
 - Add GPIO keys and egalax touch screen support for imx6qdl-sabreauto.
 - Switch to use SPDX-License-Identifier for more boards - vf610-twr,
   imx7s-warp, Engicam boards.
 - Add device tree bindings of 'fsl,pmic-stby-poweroff' property and add
   the support for i.MX6 RIoTboard.
 - DTC has new checks for SPI buses which will be landed on 4.20.
   A patch from Rob to fix those 100+ warnings on i.MX boards. (Thanks!)
 - Switch i.MX7 device tree to use updated coresight binding for
   hardware ports.
 - Misc small or random update and cleanup.

----------------------------------------------------------------
Alex Gonzalez (1):
      ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro

Andrew Lunn (1):
      ARM: dts: vf610-zii-cfu1: Add SFF interface to switch

Anson Huang (16):
      ARM: dts: imx6sll: add gpio-ranges property
      ARM: dts: imx7ulp: update pinfunc header file
      ARM: dts: imx7s: remove snvs_poweroff node
      ARM: dts: imx6sll: add gpio clocks
      ARM: dts: imx6ull-14x14-evk: correct machine model name
      dt-bindings: arm: add missing compatible for i.MX boards
      ARM: dts: imx7d-sdb: enable gpio buttons as wakeup source
      ARM: dts: imx6sx-sdb: enable gpio buttons as wakeup source
      ARM: dts: imx7s: enable cpuidle driver
      ARM: dts: imx6ull: update iomux header
      ARM: dts: imx6qdl-sabreauto: add gpio keys support
      ARM: dts: imx6qdl-sabreauto: add egalax touch screen support
      ARM: dts: imx6ull: update vdd_soc voltage for 900MHz operating point
      ARM: dts: imx6ul: use nvmem-cells for cpu speed grading
      dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
      ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

Esben Haabendal (1):
      ARM: dts: ls1021a: Enable I2C DMA support

Fabio Estevam (13):
      ARM: dts: imx51-babbage: Add MC13892 ADC support
      ARM: dts: imx6ul: Enable the PMU node
      ARM: dts: imx51: Add label for VPU node
      ARM: dts: imx51-zii-scu3-esb: Disable VPU
      ARM: dts: imx51-zii-scu2-mezz: Disable VPU
      ARM: dts: imx51-zii-scu2-mezz: Disable the internal watchdog
      ARM: dts: vf610-zii-cfu1: Pass the 'no-sdio' property
      ARM: dts: vf610-zii-cfu1: Pass the 'no-sd' property
      ARM: dts: imx51-zii-rdu1: Fix the rtc compatible string
      ARM: dts: imx6qdl-zii-rdu2: Disable the internal RTC
      ARM: dts: vf: Switch to SPDX identifier
      ARM: dts: vf610-twr: Switch to SPDX identifier
      ARM: dts: imx53-ppd: Remove 'num-chipselects' property

Jacopo Mondi (2):
      ARM: dts: imx6qdl: Add Engicam i.Core 1.5 MX6
      ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core MX6

Jagan Teki (3):
      ARM: dts: imx: Switch Engicam boards to use SPDX identifier
      ARM: dts: imx6ul-isiot: Move node definitions into dtsi
      ARM: dts: i.MX6: Use consistent node names for Engicam files

Oleksij Rempel (3):
      ARM: dts: imx7s: add i.MX7 messaging unit support
      dt-bindings: imx6q-clock: add new fsl,pmic-stby-poweroff property
      ARM: dts: imx6: RIoTboard provide standby on power off option

Pierre-Jean Texier (2):
      ARM: dts: imx7s-warp: enable i2c3 device support
      ARM: dts: imx7s-warp: use SPDX-License-Identifier

Prabhakar Kushwaha (1):
      ARM: dts: Add big-endian in nor node for ls1021a

Rob Herring (1):
      ARM: dts: imx: Fix SPI bus warnings

Russell King (1):
      ARM: dts: vf610-zii-dev-rev-c: add support for one SFF module

Stefan Agner (1):
      ARM: dts: imx6q-apalis: mux RESET_MOCI# signal

Suzuki K Poulose (1):
      ARM: dts: imx7: Update coresight binding for hardware ports

S?bastien Szymanski (2):
      ARM: dts: imx6ull: keep IMX6UL_ prefix for signals on both i.MX6UL and i.MX6ULL
      ARM: dts: imx6ul: Add weim node

Tuomas Tynkkynen (1):
      ARM: dts: imx6qdl-wandboard: Add stdout-path

 Documentation/devicetree/bindings/arm/fsl.txt      |  44 +++
 .../devicetree/bindings/clock/imx6q-clock.txt      |   8 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/imx1.dtsi                        |   4 +-
 arch/arm/boot/dts/imx23-evk.dts                    |   2 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |   4 +-
 arch/arm/boot/dts/imx23-sansa.dts                  |   4 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |   2 +-
 arch/arm/boot/dts/imx23-xfi3.dts                   |   4 +-
 arch/arm/boot/dts/imx23.dtsi                       |   4 +-
 arch/arm/boot/dts/imx25.dtsi                       |   6 +-
 arch/arm/boot/dts/imx27.dtsi                       |   6 +-
 arch/arm/boot/dts/imx28-apf28dev.dts               |   4 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |   4 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |   2 +-
 arch/arm/boot/dts/imx28-duckbill-2-485.dts         |   4 +-
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts     |   4 +-
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts         |   4 +-
 arch/arm/boot/dts/imx28-duckbill-2.dts             |   4 +-
 arch/arm/boot/dts/imx28-duckbill.dts               |   4 +-
 arch/arm/boot/dts/imx28-evk.dts                    |   6 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |   4 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |   4 +-
 arch/arm/boot/dts/imx28-sps1.dts                   |   4 +-
 arch/arm/boot/dts/imx28-ts4600.dts                 |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   8 +-
 arch/arm/boot/dts/imx31.dtsi                       |   4 +-
 arch/arm/boot/dts/imx35.dtsi                       |   4 +-
 arch/arm/boot/dts/imx50.dtsi                       |   6 +-
 arch/arm/boot/dts/imx51-babbage.dts                |   1 +
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |   2 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts          |   8 +
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts           |   4 +
 arch/arm/boot/dts/imx51.dtsi                       |   8 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |   1 -
 arch/arm/boot/dts/imx53.dtsi                       |   6 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |   2 +-
 arch/arm/boot/dts/imx6dl-icore-mipi.dts            |   2 +-
 arch/arm/boot/dts/imx6dl-icore-rqs.dts             |  38 +-
 arch/arm/boot/dts/imx6dl-icore.dts                 |  38 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   5 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts            |   2 +
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      |   2 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |   2 +
 arch/arm/boot/dts/imx6q-icore-mipi.dts             |   6 +-
 arch/arm/boot/dts/imx6q-icore-ofcap10.dts          |  38 +-
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts          |  38 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts              |  39 +--
 arch/arm/boot/dts/imx6q-icore.dts                  |  38 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   4 -
 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi           |  34 ++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |  41 +--
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |  42 +--
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  67 ++++
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   4 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |   4 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   8 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6sll.dtsi                     |  31 ++
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |   2 +
 arch/arm/boot/dts/imx6sx.dtsi                      |  14 +-
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts        | 390 +++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-geam.dts                  |  40 +--
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts            |  61 +---
 arch/arm/boot/dts/imx6ul-isiot-nand.dts            |  63 +---
 arch/arm/boot/dts/imx6ul-isiot.dtsi                |  90 +++--
 arch/arm/boot/dts/imx6ul.dtsi                      |  28 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts            |   2 +-
 arch/arm/boot/dts/imx6ull-pinfunc.h                |  39 ++-
 arch/arm/boot/dts/imx6ull.dtsi                     |   2 +-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts            |  20 ++
 arch/arm/boot/dts/imx6ulz.dtsi                     |  38 ++
 arch/arm/boot/dts/imx7d-sdb.dts                    |   2 +
 arch/arm/boot/dts/imx7d.dtsi                       |  15 +-
 arch/arm/boot/dts/imx7s-warp.dts                   |  53 +--
 arch/arm/boot/dts/imx7s.dtsi                       | 131 ++++---
 arch/arm/boot/dts/imx7ulp-pinfunc.h                |  16 +-
 arch/arm/boot/dts/ls1021a-qds.dts                  |   2 +
 arch/arm/boot/dts/ls1021a-twr.dts                  |   2 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  12 +-
 arch/arm/boot/dts/vf500.dtsi                       |  43 +--
 arch/arm/boot/dts/vf610-twr.dts                    |  43 +--
 arch/arm/boot/dts/vf610-zii-cfu1.dts               |  30 ++
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |  44 ++-
 arch/arm/boot/dts/vf610.dtsi                       |  44 +--
 arch/arm/boot/dts/vfxxx.dtsi                       |  55 +--
 87 files changed, 1081 insertions(+), 889 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi
