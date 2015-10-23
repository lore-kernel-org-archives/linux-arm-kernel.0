From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Oct 2015 06:18:06 +0900
Subject: [GIT PULL 1/5] Late Samsung DT updates for v4.4
Message-ID: <562AA40E.4050407@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Here is late pull-request for v4.4, please pull.

If any problems, please kindly let me know.
See you in Seoul next week ;-)

Thanks,
Kukjin


The following changes since commit df829b06f0079165d9dc7719af8f8a7da852fe51:

  ARM: dts: Use GPIO constants for flags cells in exynos5440 boards
(2015-10-08 07:39:58 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-2

for you to fetch changes up to d6b9aea67f40e138e972b17c7c658bc3c8ac2459:

  MAINTAINERS: Add documentation and dt-bindings for exynos stuff
(2015-10-24 05:07:26 +0900)

----------------------------------------------------------------
Samsung 2nd DT updates for v4.4

- use exynos5420-dw-mshc instead of exynos5250 for exynos3250
- add DISP1 clocks and the DISP1 power domain of two closk
  on exynos5250 (clock commit got Stephen's ack)
- add vbus regulators on exynos3250, exynos4210 and exynos4412 boards
- fix typo in regulator enable GPIO property on s5pv20-aquila and goni
- document: correct the example of exynos power domain clocks
- document: consolidate exynos SoC dt-bindings and non-Samsung
  boards related compatibles (FriendlyARM, Google, Hardkernel
  and Insignal)
- update MAINTAINER entries accordingly (documentation)

----------------------------------------------------------------
Jaehoon Chung (1):
      ARM: dts: use exynos5420-dw-mshc compatible for exynos3250

Krzysztof Kozlowski (4):
      dt-bindings: Correct the example for Exynos power domain clocks
      dt-bindings: Consolidate Exynos SoC bindings
      dt-bindings: EXYNOS: Document compatibles from other vendors
      MAINTAINERS: Add documentation and dt-bindings for exynos stuff

Laurent Pinchart (2):
      ARM: dts: Fix typo in regulator enable GPIO property in s5pv210-aquila
      ARM: dts: Fix typo in regulator enable GPIO property in s5pv210-goni

Marek Szyprowski (1):
      ARM: dts: Add vbus regulator to USB2 phy nodes on exynos3250,
exynos4210 and exynos4412 boards

Tomeu Vizoso (2):
      clk: samsung: exynos5250: Add DISP1 clocks
      ARM: dts: Add clocks to DISP1 domain in exynos5250

 .../devicetree/bindings/arm/samsung-boards.txt     | 27 ---------
 .../bindings/arm/samsung/samsung-boards.txt        | 69
++++++++++++++++++++++
 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  2 +-
 .../power_domain.txt => power/pd-samsung.txt}      |  5 +-
 MAINTAINERS                                        |  4 ++
 arch/arm/boot/dts/exynos3250-monk.dts              |  1 +
 arch/arm/boot/dts/exynos3250-rinato.dts            |  1 +
 arch/arm/boot/dts/exynos3250.dtsi                  |  4 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |  2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |  1 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  4 ++
 arch/arm/boot/dts/s5pv210-aquila.dts               |  2 +-
 arch/arm/boot/dts/s5pv210-goni.dts                 |  4 +-
 drivers/clk/samsung/clk-exynos5250.c               | 14 ++++-
 include/dt-bindings/clock/exynos5250.h             |  4 +-
 16 files changed, 106 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/samsung-boards.txt
 create mode 100644
Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
 rename Documentation/devicetree/bindings/{arm/exynos/power_domain.txt
=> power/pd-samsung.txt} (93%)
