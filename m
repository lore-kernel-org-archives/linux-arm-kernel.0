From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 May 2018 12:18:14 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.17
Message-ID: <cover.1525256178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC fixes for v4.17.


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.17

for you to fetch changes up to edb0c3affe5214a21d71ffb82ca92ed068e828df:

  ARM: dts: r8a7793: Convert to new LVDS DT bindings (2018-04-23 12:31:42 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Fixes for v4.17

Fix LVDS output on Gen2 boards

Laurent Pincart says "This patch series fixes LVDS output support on the
Lager, Koelsh, Porter and Gose boards that broke in v4.17-rc1 due to the
combination of the R-Car DU LVDS driver rework and the DT move of all
on-SoC peripherals to a /soc node.

We could handle the problem in the R-Car DU LVDS DT backward compatibility
code, but that fix would only be used for v4.17 as in v4.18 the Gen2 DT
will move to the new LVDS DT bindings. I thus propose merging these three
patches in v4.17 already to fix the problem as this is the simplest
solution."

----------------------------------------------------------------
Laurent Pinchart (3):
      ARM: dts: r8a7790: Convert to new LVDS DT bindings
      ARM: dts: r8a7791: Convert to new LVDS DT bindings
      ARM: dts: r8a7793: Convert to new LVDS DT bindings

 arch/arm/boot/dts/r8a7790-lager.dts   | 22 +++++++++---
 arch/arm/boot/dts/r8a7790.dtsi        | 65 ++++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/r8a7791-koelsch.dts | 12 +++++--
 arch/arm/boot/dts/r8a7791-porter.dts  | 16 +++++++--
 arch/arm/boot/dts/r8a7791.dtsi        | 36 +++++++++++++++----
 arch/arm/boot/dts/r8a7793-gose.dts    | 10 ++++--
 arch/arm/boot/dts/r8a7793.dtsi        | 37 ++++++++++++++++----
 7 files changed, 164 insertions(+), 34 deletions(-)
