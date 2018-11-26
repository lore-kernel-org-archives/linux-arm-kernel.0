From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:55:01 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.21
Message-ID: <cover.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.21.

I am sending out this pull-request at this time as there are a number
of patches queued up in my arm64 DT branch and I hope that this
will ease the burden later on in the development cycle. I expect to
send a follow-up pull-request for this branch at the usual pre-rc6 timing.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.21

for you to fetch changes up to 275e4eb3f21a09b6b8bd4a353b9a01e500240385:

  arm64: dts: renesas: Add all CPUs in cooling maps (2018-11-26 09:11:44 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.21

* H3 (r8a7795) SoC:
  - Remove unneeded sound #address/size-cells

* M3-W (r8a7796) SoC:
  - Describe CMT (Compare Match Timer) devices in DT
  - Describe I2C-DVFS device node in DT

* M3-N (r8a77965) SoC:
  - Describe CAN, CANFD and LVDS in DT

* R-Car H3 (r8a7795) and M3-W (r8a7796) SoCs:
  - Describe CPU topology, capacity and cooling maps in DT
  - Add SSIU support to R-Car audio

* R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) SoCs:
  - Extend register range of HSUSB device to match documentation

* R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) based
  Salvator-X, Salvator-XS and ULCB boards:
  - Switch eMMC bus to 1V8

* R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) based
  Salvator-X and Salvator-XS boards:
  - Describe USB3.0 xHCI host and prerepheral devices as companions

* R-Car E3 (r8a77990) SoC:
  - Add thermal support
  - Add support for interupt controller for external devices (INTC-EX)
  - Describe all SCIF devices and SYS-DMA for I2C and MSIOF devices

* R-Car E3 (r8a77990) based Ebisu board:
  - Enable SDHI, CAN, CANFD, audio and USB3.0
  - Describe serial console pins

* R-Car E3 (r8a77990) based Ebisu and
  R-Car D3 (r8a77995) based Draak board:
  - Enable USB2.0 peripheral device

* R-Car M3-N (r8a77965), E3 (r8a77990) and V3H (r8a77980) SoCs:
  - Connect EtherAVB to IPMMU

* R-Car V3M (r8a77970) and V3H (r8a77980) SoCs:
  - Describe TMU (timer unit), PWM timer controller and MSIOF devides in DT
  - Add thermal support

* RZ/G2M (r8a774a1) SoC:
  - Use clock and power index macros
  - Describe VIN, CSI-2 and CAN devices in DT

----------------------------------------------------------------
Biju Das (2):
      arm64: dts: renesas: r8a774a1: Add VIN and CSI-2 nodes
      arm64: dts: renesas: r8a7796: Add CMT device nodes

Chris Paterson (1):
      arm64: dts: renesas: r8a774a1: Add CAN nodes

Fabrizio Castro (2):
      arm64: dts: renesas: r8a774a1: Replace power magic numbers
      arm64: dts: renesas: r8a774a1: Replace clock magic numbers

Gaku Inami (2):
      arm64: dts: renesas: Add CPU topology on R-Car Gen3 SoCs
      arm64: dts: renesas: Add CPU capacity-dmips-mhz

Jacopo Mondi (1):
      arm64: dts: renesas: r8a77990: Fix VIN endpoint numbering

Kuninori Morimoto (3):
      arm64: dts: renesas: r8a7795: remove unneeded sound #address/size-cells
      arm64: dts: renesas: r8a7795: add SSIU support for sound
      arm64: dts: renesas: r8a7796: add SSIU support for sound

Laurent Pinchart (1):
      arm64: dts: renesas: r8a77965: Add LVDS support

Magnus Damm (3):
      arm64: dts: renesas: r8a77965: Connect R-Car M3-N AVB to IPMMU
      arm64: dts: renesas: r8a77980: Connect R-Car V3H AVB to IPMMU
      arm64: dts: renesas: r8a77990: Connect R-Car E3 AVB to IPMMU

Marek Vasut (2):
      arm64: dts: renesas: Switch eMMC bus to 1V8 on Salvator-X and ULCB
      arm64: dts: renesas: r8a77990: ebisu: Add and enable CAN,FD device nodes

Sergei Shtylyov (5):
      arm64: dts: renesas: r8a779{7|8}0: add PWM support
      arm64: dts: renesas: r8a77970: add thermal support
      arm64: dts: renesas: r8a77980: add thermal support
      arm64: dts: renesas: r8a779{7|8}0: add MSIOF support
      arm64: dts: renesas: r8a779{7|8}0: add TMU support

Takeshi Kihara (10):
      arm64: dts: renesas: r8a77990: Add INTC-EX device node
      arm64: dts: renesas: r8a77990: Add SCIF-{0,1,3,4,5} device nodes
      arm64: dts: renesas: ebisu: Enable Audio
      arm64: dts: renesas: r8a77990: Add all HSCIF nodes
      arm64: dts: renesas: ebisu: Add serial console pins
      arm64: dts: renesas: ebisu: Add and enable SDHI device nodes
      arm64: dts: renesas: r8a77990: ebisu: Add and enable PCIe device node
      arm64: dts: renesas: r8a77965: Add CAN and CANFD controller nodes
      arm64: dts: renesas: r8a77990: Add I2C-DVFS device node
      arm64: dts: renesas: r8a77990: Enable I2C DMA

Viresh Kumar (1):
      arm64: dts: renesas: Add all CPUs in cooling maps

Yoshihiro Kaneko (3):
      arm64: dts: renesas: r8a77990: Add DMA properties to MSIOF nodes
      arm64: dts: renesas: r8a77990: Add Audio-DMAC and Sound device nodes
      arm64: dts: renesas: r8a77990: add thermal device support

Yoshihiro Shimoda (4):
      arm64: dts: renesas: revise hsusb's reg size
      arm64: dts: renesas: r8a77990: add/enable USB3.0 peripheral device node
      arm64: dts: renesas: salvator-common: add companion property in usb3_peri0
      arm64: dts: renesas: r8a7799{0|5}: add/enable USB2.0 peripheral

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 606 ++++++++++++++---
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |   2 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   2 +
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   2 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 284 +++++++-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 321 ++++++++-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  81 ++-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          | 211 ++++++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          | 221 +++++++
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     | 314 ++++++++-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          | 733 ++++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |   8 +
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |  45 ++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  13 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |   8 +-
 15 files changed, 2701 insertions(+), 150 deletions(-)
