From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:52:30 +0200
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.15
Message-ID: <cover.1506678250.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.15.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.15

for you to fetch changes up to 2affee619d48d101831e83e74cadeb7c5200d9cb:

  arm64: dts: renesas: r8a7796: add USB3.0 peripheral device node (2017-09-25 09:09:51 +0200)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.15

* r8a7795 (H3)
  - Use r8a7795-cpg-mssr and r8a7795-sysc bindings
    Hardcoded indicies are replaced with symbols now that they are available

  - Drop bogus HDMI node name suffixes
    Laurent Pinchart says: Node names should not use numerical suffixes if
    the nodes can be distinguished by unit-address

  - Update PFC node name to pin-controller
    Shimoda-san says the PFC node name is changed "from e6060000.pfc and
    pfc at e6060000 to e6060000.pin-controller and pin-controller at e6060000
    like other Renesas SoCs."

* r8a7795 (H3) ES1.0
  - Drop extra zero from XHCI unit address
    This corrects a typo were ee0400000 rather than ee040000 was used
    as the unit address.

* r8a7796 (M3-W)
  - Add FDP1 instance
    Laurent Pinchart says: The r8a7796 has a single FDP1 instance.

* r8a7795 (H3) and r8a7796 (M3-W) SoCs
  - Add USB3.0 peripheral device nodes
    Shimoda-san says that this is not enabled on the Salvator-X/XS boards
    for now as:
     + we need a special cable (USB type-A to A cross cable).
     + we can swap the role by renesas_usb3 driver even if we use a normal
	cable and after usb3.0 host is running, but I think it's a special
	use case.

* r8a7795 (H3) and r8a7796 (M3-W) ULCB boards
  - Enable display output
    Laurent Pinchart says: The DU is already wired up to the HDMI encoder,
    all we need to do is enable it.

* r8a77995 (D3) Draak board
  - Enable EthernetAVB and , USB2.0 Host and PHY

  - Add serial console pins.
    This is safe to do now that r8a77995 PFC driver support is present

* r8a77970 (V3M)
  - Add basic support for SoC and EtherAVB, [H]SCIF and SYS-DMAC nodes
    This is a step towards enabling EtherAVB and [H]SCIF with SYS-DMAC
    in the Eagle board support for which is under review

----------------------------------------------------------------
Geert Uytterhoeven (6):
      arm64: dts: renesas: r8a7795-es1: Drop extra zero from usb unit address
      arm64: dts: renesas: r8a7795: Drop bogus HDMI node names suffixes
      arm64: renesas: Add Renesas R8A77970 Kconfig support
      arm64: dts: renesas: r8a77995: Use r8a7795-sysc binding definitions
      arm64: dts: renesas: r8a77995: Use r8a7795-cpg-mssr binding definitions
      arm64: dts: draak: Add serial console pins

Laurent Pinchart (2):
      arm64: dts: renesas: r8a7796: Add FDP1 instance
      arm64: dts: renesas: ulcb: Enable display output

Sergei Shtylyov (4):
      arm64: dts: renesas: initial R8A77970 SoC device tree
      arm64: dts: renesas: r8a77970: add SYS-DMAC support
      arm64: dts: renesas: r8a77970: add [H]SCIF support
      arm64: dts: renesas: r8a77970: add EtherAVB support

Yoshihiro Shimoda (10):
      arm64: dts: renesas: r8a77995: update PFC node name to pin-controller
      arm64: dts: renesas: r8a77995: add GPIO device nodes
      arm64: dts: renesas: r8a77995: Add EthernetAVB device node
      arm64: dts: renesas: r8a77995: Add USB2.0 PHY device node
      arm64: dts: renesas: r8a77995: add USB2.0 Host (EHCI/OHCI) device node
      arm64: dts: renesas: r8a77995: draak: enable USB2.0 PHY
      arm64: dts: renesas: r8a77995: draak: enable USB2.0 Host (EHCI/OHCI)
      arm64: dts: renesas: r8a77995: draak: enable EthernetAVB
      arm64: dts: renesas: r8a7795: add USB3.0 peripheral device node
      arm64: dts: renesas: r8a7796: add USB3.0 peripheral device node

 arch/arm64/Kconfig.platforms                   |   6 +
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi   |   2 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi       |  15 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi       |  21 ++
 arch/arm64/boot/dts/renesas/r8a77970.dtsi      | 366 +++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts |  55 ++++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi      | 211 +++++++++++++-
 arch/arm64/boot/dts/renesas/ulcb.dtsi          |   4 +
 8 files changed, 669 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77970.dtsi
