From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Jun 2017 22:42:02 -0700
Subject: [GIT PULL 1/2] more omap device tree changes for v4.13
Message-ID: <pull-1497505275-391662>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit de09eb52a1cceb6f80464a008c67c7bebb242314:

  arm: dts: am33xx: Remove redundant interrupt-parent property (2017-06-06 00:33:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/dt-part2-signed

for you to fetch changes up to 45f1d5e3c71d479995cefe9dd30344c62efd60c8:

  ARM: dts: omap4: add SHAM node (2017-06-14 00:46:01 -0700)

----------------------------------------------------------------
Second set of device tree changes for omaps for v4.13 merge
window:

- Updates for droid 4 proximity sensor, WLAN and battery

- Configure clocks for remoteproc devices for omap5 and dra7

- Configure omap4 crypto accelerators

----------------------------------------------------------------
Sebastian Reichel (4):
      ARM: dts: omap4-droid4: Add isl29030 ALS/proximity sensor
      ARM: dts: omap4-droid4: Fix WLAN compatible
      ARM: dts: omap4: Fix aes entry
      ARM: dts: omap4.dtsi: remove aes[12]_fck

Subhajit Paul (1):
      ARM: dts: dra7xx-clocks: Use DPLL_GPU for GPU clocks

Suman Anna (5):
      ARM: dts: omap44xx-clocks: Set IVA DPLL and its output clock rates
      ARM: dts: omap54xx-clocks: Set IVA DPLL and its output clock rates
      ARM: dts: dra7xx-clocks: Source IPU1 functional clock from CORE DPLL
      ARM: dts: dra7xx-clocks: Set DSP DPLL and its output clock rates
      ARM: dts: dra7xx-clocks: Set IVA DPLL and its output clock rates

Tero Kristo (2):
      ARM: dts: omap4: add aes2 instance
      ARM: dts: omap4: add SHAM node

Tony Lindgren (1):
      ARM: dts: omap4-droid4: Configure CPCAP battery driver

 arch/arm/boot/dts/dra7xx-clocks.dtsi           | 20 ++++++++++++++++++++
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/omap4-droid4-xt894.dts       | 19 ++++++++++++++++++-
 arch/arm/boot/dts/omap4.dtsi                   | 22 ++++++++++++++++++++--
 arch/arm/boot/dts/omap44xx-clocks.dtsi         | 22 ++++++----------------
 arch/arm/boot/dts/omap54xx-clocks.dtsi         |  6 ++++++
 6 files changed, 86 insertions(+), 19 deletions(-)
