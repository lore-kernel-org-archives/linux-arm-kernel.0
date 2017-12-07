From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 10:53:41 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.16
Message-ID: <cover.1512640145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.16.


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.16

for you to fetch changes up to 8aba250d7800702bbd2f6a91174e01b9a84ed2dd:

  arm64: dts: renesas: r8a77970: use SYSC power domain macros (2017-12-05 09:30:48 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.16

* Use r8a77970 (V3M) CPG core clock and SYSC power domain macros

  These may be used in place of numeric constants now that they
  are present in Linus's tree.

* Add r8a77970 (V3M) Starter Kit board support

  This includes basic support to bring up the board with a serial
  console and EtherAVB support

* Add IPMMU nodes and connections to on-chip devices
  on r8a7795 (H3), r8a7796 (M3-W), r8a77970 (V3M) and r8a77995 (D3) SoCs

  Simon Horman says "With these patches applied a white list enabled IPMMU
  driver may be used to check silicon revision and then enable IPMMU in the
  known working cases."

* Enable DMA for SCIF2 on r8a77995 (D2) SoC

* Increase the number of GPIO bank 1 ports to 29 on r8a7795 (H3) SoC

  This adds support for the GP-1-28 port pin of the r8a7795 (H3) ES2.0 SoC

* Add support for CAN to r8a77995 (D3) SoC

  Ulrich Hecht says "This is a by-the-datasheet implementation, with the
  datasheet missing some bits, namely the pin map.  I filled in the gaps...
  by deducing the information from pin numbers already in the PFC driver,
  so careful scrutiny is advised."

* Add support for SDHI to r8a77995 (D3) SoC

* Add SoC name to file header of r8a7795 (H3) and r8a7796 (M3-W)
  Salvator-X and Salvator-XS board files

  Geert Uytterhoeven says "With the proliferation of Salvator-X and
  Salvator-XS boards carrying different R-Car Gen3 SoCs variants, several
  DTS files ended up having the same file headers.

  Add the SoC names to the file headers to avoid confusion."

* Add device note for ROHM BD9571MWV PMIC to
  r8a7795 (H3) and r8a7796 (M3-W) Salvator-X and Salvator-XS boards.

  Geert Uytterhoeven says "This was based on the example in the DT binding
  documentation, but using IRQ0 instead of a GPIO interrupt, as that
  matches the schematics, and because INTC-EX is a simpler block."

* Enable USB2.0 channel 0 on r8a77970 (V3M) ULCB Kingfisher board

  Vladimir Barinov says "The dedicated USB0_PWEN pin is used to control
  CN13 VBUS source from U43 power supply.  MAX3355 can also provide VBUS,
  hence it should be disabled via OTG_OFFVBUSn node coming from gpio
  expander TCA9539.  Set MAX3355 enabled using OTG_EXTLPn node to be able
  to read OTG ID of CN13."

* Add support for r8a7795 (M3-W) Salvator-XS board

  Geert Uytterhoeven says "This patch series adds support for the version
  of the Salvator-XS development board equipped with an R-Car M3-W SiP.

  The DT was based on work for the Salvator-X and -XS boards with M3-W
  resp. H3 SiPs."

* Add watchdog timer support to r8a77970 (V3M) eagle board

  Geert Uytterhoven says "This allows to use the watchdog timer to reset
  the board, until PSCI is enhanced to include such functionality."

* Use Use R-Car SDHI Gen3 fallback on r8a7795 (H3) and r8a7796 (M3-W) SoCs

* Set driver type for MMC on r8a7795 (H3) and r8a7796 (M3-W) Salvator-X and
  Salvator-XS boards.

  Wolfram Sang says "These boards are known to have eMMC issues with the
  default driver type.  Specify a working one."

----------------------------------------------------------------
Geert Uytterhoeven (9):
      arm64: dts: renesas: r8a77970: Add RWDT node
      arm64: dts: renesas: eagle: Move avb node to preserve sort order
      arm64: dts: renesas: eagle: Enable watchdog timer
      arm64: dts: renesas: Add support for Salvator-XS with R-Car M3-W
      arm64: dts: renesas: salvator-common: Add BD9571 PMIC
      arm64: dts: renesas: r8a7795-es1-salvator-x: Add SoC name to file header
      arm64: dts: renesas: r8a7795-salvator-x: Add SoC name to file header
      arm64: dts: renesas: r8a7796-salvator-x: Add SoC name to file header
      arm64: dts: renesas: r8a7795-salvator-xs: Add SoC name to file header

Magnus Damm (18):
      arm64: dts: renesas: r8a7796: Add IPMMU device nodes
      arm64: dts: renesas: r8a7796: Tie SYS-DMAC to IPMMU-DS0/1
      arm64: dts: renesas: r8a7796: Enable IPMMU-DS0, DS1, MP, VI0, VC0 and MM
      arm64: dts: renesas: r8a7795: Add IPMMU device nodes
      arm64: dts: renesas: r8a7795-es1: Add IPMMU device nodes
      arm64: dts: renesas: r8a7795: Tie SYS-DMAC to IPMMU-DS0/1
      arm64: dts: renesas: r8a7795: Tie Audio-DMAC to IPMMU-MP0/1
      arm64: dts: renesas: r8a7795: Point DU/VSPD via FCPVD to IPMMU-VI0/1
      arm64: dts: renesas: r8a7795-es1: Point DU/VSPD via FCPVD to IPMMU-VI0
      arm64: dts: renesas: r8a7795: Point FDP1 via FCPF to IPMMU-VP0/1
      arm64: dts: renesas: r8a7795-es1: Point FDP1 via FCPF to IPMMU-VP0
      arm64: dts: renesas: r8a7795: Point VSPBC/VSPBD via FCPVB to IPMMU-VP0/1
      arm64: dts: renesas: r8a7795: Point VSPI via FCPVI to IPMMU-VP0/1
      arm64: dts: renesas: r8a7795-es1: Point VSPI via FCPVI to IPMMU-VP
      arm64: dts: renesas: r8a7795: Connect Ethernet-AVB to IPMMU-DS0
      arm64: dts: renesas: r8a7795: Connect SATA to IPMMU-HC
      arm64: dts: renesas: r8a7795-es1: Enable IPMMU-MP1
      arm64: dts: renesas: r8a7795: Enable IPMMU-VI0, VP1, DS0, DS1 and MM

Sergei Shtylyov (4):
      arm64: dts: renesas: initial V3MSK board device tree
      arm64: dts: renesas: v3msk: add EtherAVB support
      arm64: dts: renesas: r8a77970: use CPG core clock macros
      arm64: dts: renesas: r8a77970: use SYSC power domain macros

Simon Horman (13):
      arm64: dts: renesas: r8a7795: Use R-Car SDHI Gen3 fallback compat string
      arm64: dts: renesas: r8a7796: Use R-Car SDHI Gen3 fallback compat string
      arm64: dts: renesas: r8a7796: Tie Audio-DMAC to IPMMU-MP
      arm64: dts: renesas: r8a7796: Point FDP1 via FCPF to IPMMU-VI0
      arm64: dts: renesas: r8a7796: Point VSPI via FCPVI to IPMMU-VC0
      arm64: dts: renesas: r8a7796: Connect Ethernet-AVB to IPMMU-DS0
      arm64: dts: renesas: r8a77970: sort includes
      arm64: dts: renesas: r8a77970: Add IPMMU device nodes
      arm64: dts: renesas: r8a77970: Tie SYS-DMAC to IPMMU-DS1
      arm64: dts: renesas: r8a77970: Connect Ethernet-AVB to IPMMU-RT
      arm64: dts: renesas: r8a77970: Enable IPMMU-DS1, RT and MM
      arm64: dts: renesas: r8a77995: Add IPMMU device nodes
      arm64: dts: renesas: r8a77995: Connect Ethernet-AVB to IPMMU-RT

Takeshi Kihara (1):
      arm64: dts: renesas: r8a7795: Increase the number of GPIO bank 1 ports to 29

Ulrich Hecht (6):
      arm64: dts: renesas: r8a77995: add SYS-DMAC nodes
      arm64: dts: renesas: r8a77995: Add SDHI (MMC) support
      arm64: dts: renesas: r8a77995: Add CAN external clock support
      arm64: dts: renesas: r8a77995: Add CAN support
      arm64: dts: renesas: r8a77995: Add CAN FD support
      arm64: dts: renesas: r8a77995: add DMA for SCIF2

Vladimir Barinov (2):
      arm64: dts: renesas: ulcb-kf: enable USB2 PHY of channel 0
      arm64: dts: renesas: ulcb-kf: add dr_mode property for USB2.0 channel 0

Wolfram Sang (1):
      arm64: dts: renesas: salvator: set driver type for eMMC

 arch/arm64/boot/dts/renesas/Makefile               |   3 +-
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |   2 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |  85 ++++++++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   2 +-
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 205 +++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |   2 +-
 .../arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |  58 +++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 151 ++++++++++++-
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  23 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |  55 +++++
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          | 115 +++++++---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          | 234 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  30 +++
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |  29 +++
 15 files changed, 947 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7796-salvator-xs.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
