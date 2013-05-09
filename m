From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 May 2013 11:46:51 -0700
Subject: [GIT PULL 2/2] omap device tree fixes for v3.10 merge window
In-Reply-To: <pull-1368125211-439797>
Message-ID: <mailman.4.1368125244.1125.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bb9055b2744ada735a2fe555c4196ad39a83ef2a:

  Merge tag 'multiplatform-for-linus-2' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2013-05-07 11:28:42 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dt-fixes-for-merge-window

for you to fetch changes up to 914dc329ee11d6b1ecbebef802962dc06e78b942:

  ARM: dts: don't assume boards are using twl4030 for omap3 (2013-05-09 09:06:57 -0700)

----------------------------------------------------------------
Omap device tree fixes for issue discovered during the merge window:

- Fix triggering for GPIO interrupts that's needed for 4430sdp
  Ethernet. Otherwise booting with nfsroot won't work.

- Fix CPU operating point values

- Fix wrong assumption that twl PMIC is always connected to omap3

- Add gpmc for am33xx so beaglebone users can use the bus

- Cosmetic fix for mcspi pin muxing to avoid confusion

----------------------------------------------------------------
Jason Cooper (1):
      ARM: dts: don't assume boards are using twl4030 for omap3

Jon Hunter (1):
      ARM: dts: OMAP4: Fix ethernet IRQ for OMAP4 boards

Nishanth Menon (2):
      ARM: dts: OMAP36xx: Fix CPU OPP voltages
      ARM: dts: OMAP4460: Fix CPU OPP voltages

Philip Avinash (1):
      ARM: dts: AM33XX: Add GPMC node

Tony Lindgren (1):
      ARM: dts: Configure and fix the McSPI pins for 4430sdp

 arch/arm/boot/dts/am33xx.dtsi         | 12 ++++++++++++
 arch/arm/boot/dts/omap3-beagle-xm.dts |  1 +
 arch/arm/boot/dts/omap3-evm.dts       |  1 +
 arch/arm/boot/dts/omap3-overo.dtsi    |  1 +
 arch/arm/boot/dts/omap3.dtsi          |  1 -
 arch/arm/boot/dts/omap36xx.dtsi       |  6 +++---
 arch/arm/boot/dts/omap4-sdp.dts       | 14 +++++++++++++-
 arch/arm/boot/dts/omap4-var-som.dts   |  2 +-
 arch/arm/boot/dts/omap4460.dtsi       |  6 +++---
 9 files changed, 35 insertions(+), 9 deletions(-)
