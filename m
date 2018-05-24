From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 24 May 2018 16:06:19 +0800
Subject: [GIT PULL] berlin dt changes for v4.18
Message-ID: <20180524160619.45aaead2@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the pull request for berlin dt changes for v4.18.

Thanks,
Jisheng

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jszhang/linux-berlin.git tags/berlin-dt-for-v4.18

for you to fetch changes up to 15cf848d3c208159410eff2055494163c2542bbb:

  ARM: dts: berlin2q: move PMU node from soc to root (2018-05-24 15:25:44 +0800)

----------------------------------------------------------------
berlin DT changes for v4.18

 - add Valve Steam Link board support
 - use PWM for chromecast's LED, override chromecast's bootloader
   bad ATAG_MEM.
 - fix twd timer irq type
 - add interrupt-affinity to BG2Q's pmu
 - add "cache-unified" to BG2Q's l2 node
 - use SPDX-License-Identifier

----------------------------------------------------------------
Alexander Monakov (7):
      ARM: dts: berlin2cd: fix local timer interrupt flags
      ARM: dts: berlin2cd: move PMU node from soc to root
      ARM: dts: berlin2cd: add ADC/thermal sensor node
      ARM: dts: berlin2cd: add remaining Cortex-A9 nodes
      ARM: dts: berlin2cd: add remaining nodes to apb subtrees
      ARM: dts: berlin2cd: add a label for the CPU node
      ARM: dts: berlin2cd: add Valve Steam Link board

Jisheng Zhang (7):
      ARM: dts: berlin2q: add interrupt-affinity to pmu node
      ARM: dts: berlin2q: add "cache-unified" to l2 node
      ARM: dts: berlin2q: fix irq type for arm twd timer
      ARM: dts: berlin2: fix irq type for arm twd timer
      ARM: dts: berlin*.dtsi: use SPDX-License-Identifier for berlin SoCs
      ARM: dts: berlin*-dts: use SPDX-License-Identifier for berlin based board
      ARM: dts: berlin2q: move PMU node from soc to root

Thomas Hebb (2):
      ARM: dts: chromecast: override bad bootloader memory info
      ARM: dts: chromecast: use PWM for LEDs

 arch/arm/boot/dts/Makefile                        |   1 +
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        |  33 +----
 arch/arm/boot/dts/berlin2.dtsi                    |  35 +----
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts |  65 ++++-----
 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts   |  79 ++++++++++
 arch/arm/boot/dts/berlin2cd.dtsi                  | 167 +++++++++++++++++-----
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts        |  33 +----
 arch/arm/boot/dts/berlin2q.dtsi                   |  65 +++------
 8 files changed, 259 insertions(+), 219 deletions(-)
 create mode 100644 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts
