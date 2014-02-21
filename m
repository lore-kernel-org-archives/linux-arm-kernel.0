From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:25 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Boards Updates for
 v3.15
Message-ID: <cover.1392960310.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this third round of Renesas ARM based SoC
boards updates for v3.15.

This pull request is based on the previous round of
such requests, tagged as renesas-boards2-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit 03fec7dee502d43114f384a1588ce84a3c9bf38d:

  ARM: shmobile: genmai: Enable r7s72100-ether (2014-02-07 09:20:03 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards3-for-v3.15

for you to fetch changes up to 6197c08ab81cf1430cbe7346fd6ca0b5a18580bf:

  ARM: shmobile: Remove Lager DT reference legacy clock bits (2014-02-18 09:15:49 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Boards Updates for v3.15

* r7s72100 SoC (RZ/A1H) based Genmai board
  - Set proper DMA masks for Ether device

* r8a7791 (R-Car M2) based Koelsch board
  - Remove Koelsch DT reference legacy clock bits
  - Set proper DMA masks for Ether device
  - Add DU device to koelsch-reference
  - Refactor clock lookup hack in koelsch-reference
  - Add SDHI devices

* r8a7790 (R-Car H2) based Lager board
  - Remove Lager DT reference legacy clock bits
  - Set proper DMA masks for Ether device
  - Add internal USB PCI support
  - Add QSPI pinmux
  - Sdd SDHI0/2 support

* emev2 (Emma Mobile EV2) based kzm9d board
  - Remove KZM9D board code

* r8a7778 (R-Car M1) based bock-w board
  - Set proper DMA masks for Ether device

* r8a7740 (R-Mobile A1) based Armadillo 800 EVA board
  - Set proper DMA masks for Ether device

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: lager legacy: Add QSPI pinmux

Kuninori Morimoto (1):
      ARM: shmobile: lager: add SDHI0/2 support

Laurent Pinchart (4):
      ARM: shmobile: lager-reference: Refactor clock lookup hack
      ARM: shmobile: lager-reference: Add DU device
      ARM: shmobile: koelsch-reference: Refactor clock lookup hack
      ARM: shmobile: koelsch-reference: Add DU device

Magnus Damm (4):
      ARM: shmobile: Add SDHI devices for legacy Koelsch
      ARM: shmobile: Remove KZM9D board code
      ARM: shmobile: Remove Koelsch DT reference legacy clock bits
      ARM: shmobile: Remove Lager DT reference legacy clock bits

Sergei Shtylyov (5):
      ARM: shmobile: Armadillo 800 EVA: set proper DMA masks for Ether device
      ARM: shmobile: BOCK-W: set proper DMA masks for Ether device
      ARM: shmobile: Lager: set proper DMA masks for Ether device
      ARM: shmobile: Koelsch: set proper DMA masks for Ether device
      ARM: shmobile: Genmai: set proper DMA masks for Ether device

Valentine Barshak (1):
      ARM: shmobile: lager: Add internal USB PCI support

 arch/arm/mach-shmobile/Kconfig                   |   6 -
 arch/arm/mach-shmobile/Makefile                  |   1 -
 arch/arm/mach-shmobile/board-armadillo800eva.c   |   2 +
 arch/arm/mach-shmobile/board-bockw.c             |  21 ++-
 arch/arm/mach-shmobile/board-genmai.c            |  19 ++-
 arch/arm/mach-shmobile/board-koelsch-reference.c | 104 +++++++++++---
 arch/arm/mach-shmobile/board-koelsch.c           | 174 ++++++++++++++++++++++-
 arch/arm/mach-shmobile/board-kzm9d-reference.c   |  47 ------
 arch/arm/mach-shmobile/board-lager-reference.c   | 107 +++++++++++---
 arch/arm/mach-shmobile/board-lager.c             | 138 +++++++++++++++++-
 10 files changed, 506 insertions(+), 113 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9d-reference.c
