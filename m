From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:04 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.10
Message-ID: <cover.1478251192.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v4.10.


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.10

for you to fetch changes up to 935085209343a0c507e3d9a3e01883b25c8f743e:

  arm64: renesas: r8a7796: add SYS-DMAC controller nodes (2016-11-04 10:18:07 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v4.10

Enablement:
* Enable On-board eMMC
* Enable SDHI 0 & 3 with UHS
* Add SYS-DMAC controller nodes to r8a7796 SoC
* Populate EXTALR on r8a7796/salvator-x board; used by watchdog
* Add DU LVDS output endpoint on r8a7795/salvator-x board
* Add bias setting for USB1 pins on r8a7795/salvator-x board

Clean-Up:
* Remove FCP SoC-specific compatible strings

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: dts: r8a7796: salvator-x: Populate EXTALR

Laurent Pinchart (3):
      arm64: dts: r8a7795: salvator-x: Add DU LVDS output endpoint
      dt-bindings: media: renesas-fcp: Remove SoC-specific compatible strings
      arm64: dts: r8a7795: Remove FCP SoC-specific compatible strings

Simon Horman (3):
      arm64: dts: r8a7796: add SDHI nodes
      arm64: dts: r8a7796: salvator-x: enable SDHI0 & 3
      arm64: dts: r8a7796: salvator-x: enable UHS for SDHI 0 & 3

Ulrich Hecht (1):
      arm64: renesas: r8a7796: add SYS-DMAC controller nodes

Wolfram Sang (3):
      arm64: dts: r8a7795: salvator-x: enable UHS for SDHI 0 & 3
      arm64: dts: r8a7795: salvator: enable on-board eMMC
      arm64: dts: r8a7796: salvator: enable on board eMMC

Yoshihiro Shimoda (1):
      arm64: dts: r8a7795: salvator-x: add bias setting for usb1_pins

 .../devicetree/bindings/media/renesas,fcp.txt      |   8 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  85 +++++++++++-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  24 ++--
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 148 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 139 +++++++++++++++++++
 5 files changed, 381 insertions(+), 23 deletions(-)
