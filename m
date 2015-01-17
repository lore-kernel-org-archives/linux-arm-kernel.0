From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 Jan 2015 09:58:16 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v3.20
Message-ID: <cover.1421380713.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v3.20.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v3.20,
which you have previously pulled.


The following changes since commit 7408d3061d2f04181820902fae6e92e4a73d5cc0:

  ARM: shmobile: r8a7791: add MLB+ clock (2014-12-23 09:18:23 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.20

for you to fetch changes up to fbaa5e694a1240c5f6b829b1e17652e4e228ee12:

  PM / Domains: R-Mobile SYSC: Document SH-Mobile AG5 (sh73a0) binding (2015-01-16 10:59:37 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v3.20

* Support Renesas memory controllers
* Add SRC interrupt number on r8a779~ and r8a7791 SoCs
* Fix MSTP8 input clocks on r8a7791 SoC
* Add PM domain support to r8a7740
* Add DT bindings for the R-Mobile System Controller
* Use Add sh73a0-specific FSI2 compatible property

----------------------------------------------------------------
Geert Uytterhoeven (8):
      ARM: shmobile: sh73a0 dtsi: Add SoC-specific FSI2 compatible property
      PM / Domains: Add DT bindings for the R-Mobile System Controller
      ARM: shmobile: r8a7740 dtsi: Add PM domain support
      ARM: shmobile: Add DT bindings for Renesas memory controllers
      ARM: shmobile: r8a73a4 dtsi: Add memory-controller nodes
      ARM: shmobile: r8a7740 dtsi: Add memory-controller node
      ARM: shmobile: sh73a0 dtsi: Add memory-controller nodes
      PM / Domains: R-Mobile SYSC: Document SH-Mobile AG5 (sh73a0) binding

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: add SRC interrupt number on DTSI
      ARM: shmobile: r8a7791: add SRC interrupt number on DTSI

Sergei Shtylyov (1):
      ARM: shmobile: r8a7791: fix MSTP8 input clocks

 .../renesas-memory-controllers.txt                 |  44 +++++++++
 .../bindings/power/renesas,sysc-rmobile.txt        |  99 +++++++++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi                     |  10 ++
 arch/arm/boot/dts/r8a7740.dtsi                     | 105 +++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                     |  20 ++--
 arch/arm/boot/dts/r8a7791.dtsi                     |  22 ++---
 arch/arm/boot/dts/sh73a0.dtsi                      |  18 +++-
 7 files changed, 296 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas-memory-controllers.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
