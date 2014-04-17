From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:23:59 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Clock Updates for v3.16
Message-ID: <cover.1397694178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM Based SoC Clock Updates for v3.16.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-for-v3.16

for you to fetch changes up to 932616eed0308cbebbb20a079e4bed3674bf1117:

  ARM: shmobile: r8a7790: remove old style audio clock (2014-04-14 12:49:43 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Clock Updates for v3.16

SH Mobile shared clock code
* Introduce shmobile_clk_workaround()

r8a7791 (R-Car M2) SoC
* Rename VSP1_SY clocks to VSP1_S
* Correct the I2C clocks parents

r8a7790 (R-Car H2) SoC
* Remove old style audio clock
* Rename VSP1_(SY|RT) clocks to VSP1_(S|R)
* Fix the I2C clocks parents

r8a7778 (R-Car M1) SoC
* Remove old style audio clock

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: r8a7791: Use rcar_gen2_read_mode_pins() helper

Kuninori Morimoto (2):
      ARM: shmobile: r8a7778: remove old style audio clock
      ARM: shmobile: r8a7790: remove old style audio clock

Laurent Pinchart (4):
      ARM: shmobile: r8a7790: Fix the I2C clocks parents in legacy code
      ARM: shmobile: r8a7791: Fix the I2C clocks parents in legacy code
      ARM: shmobile: r8a7790: Rename VSP1_(SY|RT) clocks to VSP1_(S|R)
      ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S

Magnus Damm (1):
      ARM: shmobile: Introduce shmobile_clk_workaround()

 arch/arm/boot/dts/r8a7790.dtsi              |  2 +-
 arch/arm/boot/dts/r8a7791.dtsi              |  2 +-
 arch/arm/mach-shmobile/Makefile             |  2 +-
 arch/arm/mach-shmobile/clock-r8a7778.c      | 22 ++++++++------------
 arch/arm/mach-shmobile/clock-r8a7790.c      | 32 +++++++++++++----------------
 arch/arm/mach-shmobile/clock-r8a7791.c      | 23 ++++++++-------------
 arch/arm/mach-shmobile/clock.c              | 28 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/clock.h | 16 +++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h   |  4 ++--
 include/dt-bindings/clock/r8a7791-clock.h   |  2 +-
 10 files changed, 81 insertions(+), 52 deletions(-)
