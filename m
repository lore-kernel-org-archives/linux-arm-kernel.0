From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 09:07:32 +0900
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for v4.6
Message-ID: <cover.1456445161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM64 based SoC DT updates
for v4.6.

This pull request is based on the previous round of
such requests, tagged as renesas-arm64-dt-for-v4.6,
which you have already pulled.


The following changes since commit a3fc85e27b7e3c29b30909929bc64737a19fd251:

  arm64: dts: salvator-x: Enable SCIF_CLK frequency and pins (2016-02-03 10:04:33 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.6

for you to fetch changes up to 474efcae3b78167d82def103fcf497152db17c95:

  arm64: dts: salvator-x: enable USB 2.0 Host of channel 1 and 2 (2016-02-26 08:55:32 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM64 Based SoC DT Updates for v4.6

Updates for r8a7795/salvator-x
* Enable USB2.0, and SDHI0 & 3
* Add GIC-400 virtual interfaces
* Add INTC-EX and L2 cache-controller nodes
* Use fallback etheravb compatibility string
* Use GIC_* defines where appropriate

----------------------------------------------------------------
Ai Kyuse (2):
      arm64: dts: r8a7795: Add SDHI support to dtsi
      arm64: dts: r8a7795: salvator-x: enable SDHI0 & 3

Dirk Behme (2):
      arm64: dts: r8a7795: pmu: switch to Cortex specific device nodes
      arm64: dts: r8a7795: Add GIC-400 virtual interfaces

Geert Uytterhoeven (3):
      arm64: dts: r8a7795: Add L2 cache-controller nodes
      arm64: dts: r8a7795: Add missing properties to CA57 L2 cache node
      arm64: dts: r8a7795: Add CA53 L2 cache-controller node

Magnus Damm (1):
      arm64: dts: r8a7795: Add INTC-EX device node

Simon Horman (2):
      arm64: dts: r8a7795: use GIC_* defines
      arm64: dts: r8a7795: use fallback etheravb compatibility string

Yoshihiro Shimoda (4):
      arm64: dts: r8a7795: add usb2_phy device nodes
      arm64: dts: r8a7795: add USB2.0 Host (EHCI/OHCI) device nodes
      arm64: dts: salvator-x: enable usb2_phy of channel 1 and 2
      arm64: dts: salvator-x: enable USB 2.0 Host of channel 1 and 2

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 123 +++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 282 ++++++++++++++++-----
 2 files changed, 347 insertions(+), 58 deletions(-)
