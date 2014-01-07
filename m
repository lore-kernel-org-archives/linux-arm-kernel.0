From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  7 Jan 2014 11:06:38 +0900
Subject: [GIT PULL 0/2] Renesas ARM Based SoC DT Fixes for v3.14
Message-ID: <cover.1389060068.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider these renesas ARM Based SoC DT Fixes for v3.14.

This pull-request is based on the Third Round of Renesas ARM Based SoC DT
Updates for v3.14, tagged as renesas-dt3-for-v3.14, which you have
previously pulled.  And it resolves a problem introduced in that
pull-request.


The following changes since commit b652896b02df3dfde3a68957cce01f2aa4585842:

  ARM: shmobile: r8a7791: Add SSI clocks in device tree (2013-12-24 23:01:13 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes-for-v3.14

for you to fetch changes up to 3effae8c26f451a9d572255c08dfbe342dd1dc98:

  Revert "ARM: shmobile: r8a7791: Add SSI clocks in device tree" (2013-12-26 14:16:54 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Fixes for v3.14

Revert the addition of SSI clocks to DT for the
r8a7790 (R-Car H2) and r8a7791 (R-Car M2) SoCs.

Unfortunately these patches prevent booting the
r8a7790-based Lager board and r8a7791-based Koelsch board
to the point where a serial output is available.

A solution to this problem is being sought but has not
yet been finalised so in the mean time revert the changes.

----------------------------------------------------------------
Simon Horman (2):
      Revert "ARM: shmobile: r8a7790: Add SSI clocks in device tree"
      Revert "ARM: shmobile: r8a7791: Add SSI clocks in device tree"

 arch/arm/boot/dts/r8a7790.dtsi            | 20 --------------------
 arch/arm/boot/dts/r8a7791.dtsi            | 20 --------------------
 include/dt-bindings/clock/r8a7790-clock.h | 13 -------------
 include/dt-bindings/clock/r8a7791-clock.h | 13 -------------
 4 files changed, 66 deletions(-)
