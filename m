From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:19 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.3
Message-ID: <cover.1436509954.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v4.3.


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.3

for you to fetch changes up to 7bf46d0be278a3586c78322c65ceff5fd03bb95d:

  ARM: shmobile: r8a7779: Configure IRLM mode via DT (2015-07-06 09:33:41 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v4.3

* Configure IRLM mode via DT on r8a7779 SoC
* Use "arm,gic-400" for GIC on r8a777[01349] and r8a73a4 SoCs
* Add pinctrl and gpio-hog for lcdc0 to armadillo800eva board
* EtherAVB DT support for r8a7790 SoC
* Minimal device tree for r8a7793 SoC and its Gose board

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: shmobile: armadillo800eva dts: Add pinctrl and gpio-hog for lcdc0
      ARM: shmobile: r8a73a4 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a7790 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a7791 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a7793 dtsi: Use "arm,gic-400" for GIC
      ARM: shmobile: r8a7794 dtsi: Use "arm,gic-400" for GIC

Magnus Damm (1):
      ARM: shmobile: r8a7779: Configure IRLM mode via DT

Sergei Shtylyov (2):
      ARM: shmobile: r8a7790: add EtherAVB clocks
      ARM: shmobile: r8a7790: add EtherAVB DT support

Ulrich Hecht (2):
      ARM: shmobile: add r8a7793 minimal SoC device tree
      ARM: shmobile: r8a7793: add minimal Gose board device tree

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/r8a73a4.dtsi                |   2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |  13 +
 arch/arm/boot/dts/r8a7779.dtsi                |   5 +-
 arch/arm/boot/dts/r8a7790.dtsi                |  22 +-
 arch/arm/boot/dts/r8a7791.dtsi                |   2 +-
 arch/arm/boot/dts/r8a7793-gose.dts            |  63 +++++
 arch/arm/boot/dts/r8a7793.dtsi                | 367 ++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi                |   2 +-
 include/dt-bindings/clock/r8a7790-clock.h     |   1 +
 include/dt-bindings/clock/r8a7793-clock.h     | 164 ++++++++++++
 11 files changed, 632 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7793-gose.dts
 create mode 100644 arch/arm/boot/dts/r8a7793.dtsi
 create mode 100644 include/dt-bindings/clock/r8a7793-clock.h
