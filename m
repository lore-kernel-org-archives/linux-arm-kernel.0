From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:57:33 +0900
Subject: [GIT PULL 0/9] Renesas ARM Based SoC Clock Updates for v3.15
Message-ID: <cover.1393401266.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd, Hi Kevin,

please consider these Renesas ARM based SoC clock updates for v3.15.

As requested these have been split out from SoC updates.

This pull request is based on "Renesas ARM based SoC updates for v3.15",
tagged as tags/renesas-soc-for-v3.15, which you have previously pulled.


The following changes since commit 012a7069b5a10a0851584d71a1facdc40a972319:

  ARM: shmobile: r8a7790: Add PCI USB host clock support (2014-02-04 10:25:03 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-for-v3.15

for you to fetch changes up to df55f6685a04a259cf59cd3fde02212b294461cc:

  ARM: shmobile: Remove legacy r8a7790 DT clocks (2014-02-24 08:54:44 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Clock Updates for v3.15

* r7s72100 SoC (RZ/A1H)
  - Add clock for SH Ethernet
  - Add RSPI clocks

* r8a7791 (R-Car M2)
  - Add QSPI and SDHI clocks

* r8a7790 (R-Car H2)
  - Add audio clock
  - Remove legacy DT clocks
  - Correct SYS DMAC clock defines

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: r7s72100 clock: Add RSPI clocks
      ARM: shmobile: r7s72100 clock: Add RSPI clocks for DT
      ARM: shmobile: r8a7791 clock: add QSPI clocks

Kuninori Morimoto (2):
      ARM: shmobile: r8a7778: add audio clock in new style
      ARM: shmobile: r8a7790: add audio clock

Magnus Damm (2):
      ARM: shmobile: Add r8a7791 legacy SDHI clocks
      ARM: shmobile: Remove legacy r8a7790 DT clocks

Simon Horman (2):
      ARM: shmobile: r7s72100: Add clock for r7s72100-ether
      ARM: shmobile: r8a7790: Correct SYS DMAC clock defines

 arch/arm/boot/dts/r8a7790.dtsi            | 23 ++++++++++++
 arch/arm/mach-shmobile/clock-r7s72100.c   | 30 +++++++++++++--
 arch/arm/mach-shmobile/clock-r8a7778.c    |  4 ++
 arch/arm/mach-shmobile/clock-r8a7790.c    | 31 ++++++++++------
 arch/arm/mach-shmobile/clock-r8a7791.c    | 62 ++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/r8a7790-clock.h |  4 +-
 6 files changed, 136 insertions(+), 18 deletions(-)
