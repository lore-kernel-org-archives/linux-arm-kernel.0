From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:49 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.20
Message-ID: <cover.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.20.

I am sending out this pull-request at this time as there are a number
of patches queued up in my arm (32) DT branch and I hope that this
will ease the burden later on in the development cycle. I expect to
send a follow-up pull-request for this branch at the usual pre-rc6 timing.

Highlights of this pull request:
* New SoC: RZ/G2M (r8a774a1)
* New Board: R-Car M3-N (r8a77965) based ULCB
* And, as usual, increased hardware coverage a variety of SoCs and their boards


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.20

for you to fetch changes up to 450d6079e8d3c40c7ce67ac8bb4a2da9baf56613:

  arm64: dts: r8a77965: add FDP1 device nodes (2018-09-13 09:48:13 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.20

* Correct whitespace around assignments

* R-Car Gen-3 SoCs:
  - Enable SDR104 for SD devices
  - Include R-Car product name in DTSI files to ease maintenance
* R-Car Gen-3 SoC based boards: Convert to new LVDS DT bindings
* R-Car Gen 3 Salvator-X and Salvator-XS boards:
  - Override secondary addresses of ADV748x to avoid address conflicts
* R-Car Gen 3 based Salvator-XS board: Enable SATA

* R-Car M3-N (r8a77965) SoC:
  - Add FDP1 device nodes
  - Move arm_cc630p and timer nodes to restore sort-order of file
  - Correct clock/reset for usb2_phy1
  - Correct HS-USB compat string
  - Add OPPs table for cpu devices enabling CPUFreq support
  - Add CAN device placeholder nodes to facilitate adding
    initial device tree for KF daughter board
  - Attach SYS-DMAC to the IPMMU
* R-Car M3-N (r8a77965) based ULCB board:
  - Initial device tree for board and KF daughter board

* R-Car E3 (r8a77990) SoC:
  - Add SYS-DMAC, I2C VIN, CSI-2, MSIOF device nodes
  - Add BRG support to SCIF2 which allows an increase in serial clock accuracy
  - Use CPG/MSSR and SYSC binding definitions
* R-Car E3 (r8a77990) based Ebisu board: Enable PWM

* R-Car D3 (r8a77995) SoC: Attach the SYS-DMAC to the IPMMU
* R-Car D3 (r8a77995) based Draak board: Sort device nodes

* R-Car V3H (r8a77980) based V3HSK board:
  - Move lvds0 node to restore sort-order of file
* R-Car V3H (r8a77980) SoC:
  - Add RWDT, CSI2 and VIN, Cortex-A53 PMU nodes
  - Move IPMMU and CAN clock nodes to restore sort-order of file

* R-Car V3M (r8a77970) SoC:
  - Add MMC nodes
  - Move CAN clock node to restore sort-order of file
* R-Car V3M (r8a77970) based V3MSK board: Add eMMC support
* R-Car V3H (r8a77980) based Condor board: Add PCIe, DU, LVDS and HDMI support

* RZ/G2M (r8a774a1) SoC:
  - Initial device tree
  - Add SYS-DMAC, SCIF, HSCIF, INTC-EX, EtherAVB, RWDT, pinctl, GPIO,
    SDHI, I2C, IIC-DVFS, thermal, IPMMU, MSIOF, Cortex-A53 CPU core,
    PWM, Audio, FCPF, FCPV, USB2.0, USB-DMAC, HSUSB and USB3.0 device nodes

----------------------------------------------------------------
Biju Das (12):
      arm64: dts: renesas: Initial r8a774a1 SoC device tree
      arm64: dts: renesas: r8a774a1: Add SYS-DMAC controller nodes
      arm64: dts: renesas: r8a774a1: Add INTC-EX device node
      arm64: dts: renesas: r8a774a1: Add RWDT node
      arm64: dts: renesas: r8a774a1: Add I2C and IIC-DVFS support
      arm64: dts: renesas: r8a774a1: Add RZ/G2M thermal support
      arm64: dts: renesas: r8a774a1: Add all MSIOF nodes
      arm64: dts: renesas: r8a774a1: Add Cortex-A53 CPU cores
      arm64: dts: renesas: r8a774a1: Add audio support
      arm64: dts: renesas: r8a774a1: Add USB2.0 phy and host(EHCI/OHCI) device nodes
      arm64: dts: renesas: r8a774a1: Add USB-DMAC and HSUSB device nodes
      arm64: dts: renesas: r8a774a1: Add USB3.0 device nodes

Dien Pham (1):
      arm64: dts: renesas: r8a77965: Add OPPs table for cpu devices

Eugeniu Rosca (3):
      arm64: dts: renesas: r8a77965: Add CAN{0,1} placeholder nodes
      arm64: dts: renesas: r8a77965: m3nulcb: Initial device tree
      arm64: dts: renesas: r8a77965: m3nulcb-kf: Initial device tree

Fabrizio Castro (8):
      arm64: dts: renesas: r8a774a1: Add SCIF and HSCIF nodes
      arm64: dts: renesas: r8a774a1: Add Ethernet AVB node
      arm64: dts: renesas: r8a774a1: Add pinctrl device node
      arm64: dts: renesas: r8a774a1: Add GPIO device nodes
      arm64: dts: renesas: r8a774a1: Add SDHI nodes
      arm64: dts: renesas: r8a774a1: Add IPMMU device nodes
      arm64: dts: renesas: r8a774a1: Add PWM device nodes
      arm64: dts: renesas: r8a774a1: Add FCPF and FCPV instances

Geert Uytterhoeven (10):
      arm64: dts: renesas: Fix whitespace around assignments
      arm64: dts: renesas: v3hsk: Move lvds0 node
      arm64: dts: renesas: r8a77965: Move timer node
      arm64: dts: renesas: r8a77965: Fix HS-USB compatible
      arm64: dts: renesas: r8a77965: Fix clock/reset for usb2_phy1
      arm64: dts: renesas: salvator-xs: Improve SATA switch settings comments
      arm64: dts: renesas: r8a77990: Use CPG/MSSR and SYSC binding definitions
      arm64: dts: renesas: r8a7795: Move arm_cc630p node
      arm64: dts: renesas: r8a77990: Add all MSIOF nodes
      arm64: dts: renesas: draak: Sort device nodes

Hoan Nguyen An (1):
      arm64: dts: r8a77965: add FDP1 device nodes

Kieran Bingham (1):
      arm64: dts: renesas: salvator-common: adv748x: Override secondary addresses

Koji Matsuoka (1):
      arm64: dts: renesas: r8a77990: Add VIN and CSI-2 device nodes

Laurent Pinchart (1):
      arm64: dts: renesas: Convert to new LVDS DT bindings

Magnus Damm (3):
      arm64: dts: renesas: Include R-Car product name in DTSI files
      arm64: dts: renesas: r8a77995: Attach the SYS-DMAC to the IPMMU
      arm64: dts: renesas: r8a77965: Attach the SYS-DMAC to the IPMMU

Sergei Shtylyov (10):
      arm64: dts: renesas: r8a77980: add RWDT support
      arm64: dts: renesas: r8a77980: add Cortex-A53 PMU support
      arm64: dts: renesas: r8a77980: move IPMMU nodes
      arm64: dts: renesas: r8a779{7|8}0: move CAN clock node
      arm64: dts: renesas: r8a77980: add CSI2/VIN support
      arm64: dts: renesas: r8a77970: add MMC support
      arm64: dts: renesas: v3msk: add eMMC support
      arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support
      arm64: dts: renesas: r8a77980: add PCIe support
      arm64: dts: renesas: condor: add PCIe support

Takeshi Kihara (4):
      arm64: dts: renesas: r8a77965: Add SATA controller node
      arm64: dts: renesas: r8a77990: Add BRG support to SCIF2
      arm64: dts: renesas: r8a77990: Add I2C device nodes
      arm64: dts: renesas: r8a77990: Add SYS-DMAC device nodes

Wolfram Sang (2):
      arm64: dts: renesas: salvator-xs: enable SATA
      arm64: dts: renesas: enable SDR104 on R-Car Gen3

Yoshihiro Shimoda (1):
      arm64: dts: renesas: r8a77990: Enable PWM for Ebisu board

 arch/arm64/boot/dts/renesas/Makefile               |    2 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 1664 ++++++++++++++++++++
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |    3 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |   18 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |    3 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |    3 +-
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   17 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  104 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |    3 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |    3 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   86 +-
 .../arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts |   16 +
 arch/arm64/boot/dts/renesas/r8a77965-m3nulcb.dts   |   33 +
 .../boot/dts/renesas/r8a77965-salvator-xs.dts      |   14 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  155 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |   26 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |   36 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |  123 ++
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts     |  134 ++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |  580 ++++++-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     |   24 +
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |  478 +++++-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |  276 ++--
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |   14 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |    7 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |    2 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    1 +
 27 files changed, 3462 insertions(+), 363 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-m3nulcb.dts
