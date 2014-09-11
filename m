From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Sep 2014 16:28:54 -0700
Subject: [GIT PULL 1/5] non-urgent omap fixes for v3.18 merge window
Message-ID: <pull-1410478051-378788>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-v3.18-not-urgent

for you to fetch changes up to 31957609db529d401658adc2e91ef7df7ea42699:

  ARM: OMAP2+: make of_device_ids const (2014-09-11 12:37:23 -0700)

----------------------------------------------------------------
Fixes for omaps that were not considered urgent enough
for the -rc cycle:

- Fixes for .dts files to differentiate panda and beaglebone versions
- Powerdomain fixes from Nishant Menon mostly for newer omaps
- Fixes for __initconst and of_device_ids const usage

----------------------------------------------------------------
Nishanth Menon (9):
      ARM: dts: omap4-panda: Fix model and SoC family details
      ARM: dts: am335x-bone*: Fix model name and update compatibility information
      ARM: OMAP: DRA7: powerdomain data: fix powerdomain powerstate
      ARM: OMAP5: powerdomain data: fix powerdomain powerstate
      ARM: OMAP2+: powerdomain: pwrdm_for_each_clkdm iterate only valid clkdms
      ARM: OMAP2+: powerdomain: introduce logic for finding valid power domain
      ARM: OMAP4+: PM: Make logic state programmable
      ARM: OMAP4+: PM: use only valid low power state for suspend
      ARM: OMAP4+: PM: Use only valid low power state for CPU hotplug

Tony Lindgren (1):
      Merge branch 'pull/v3.18/powerdomain-fixes' of https://github.com/nmenon/linux-2.6-playground into omap-for-v3.18/fixes-not-urgent

Uwe Kleine-K??nig (2):
      ARM: omap2: make arrays containing machine compatible strings const
      ARM: OMAP2+: make of_device_ids const

 arch/arm/boot/dts/am335x-bone-common.dtsi   |  3 --
 arch/arm/boot/dts/am335x-bone.dts           |  5 ++
 arch/arm/boot/dts/am335x-boneblack.dts      |  5 ++
 arch/arm/boot/dts/omap4-panda-common.dtsi   |  3 --
 arch/arm/boot/dts/omap4-panda-es.dts        |  5 ++
 arch/arm/boot/dts/omap4-panda.dts           |  5 ++
 arch/arm/mach-omap2/board-generic.c         | 26 +++++-----
 arch/arm/mach-omap2/common.h                |  2 +-
 arch/arm/mach-omap2/gpmc.c                  |  2 +-
 arch/arm/mach-omap2/irq.c                   |  2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c   |  4 ++
 arch/arm/mach-omap2/pdata-quirks.c          |  2 +-
 arch/arm/mach-omap2/pm44xx.c                |  9 +++-
 arch/arm/mach-omap2/powerdomain.c           | 79 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/powerdomain.h           |  4 ++
 arch/arm/mach-omap2/powerdomains54xx_data.c | 12 ++---
 arch/arm/mach-omap2/powerdomains7xx_data.c  | 14 ++---
 arch/arm/mach-omap2/prm_common.c            |  2 +-
 arch/arm/mach-omap2/timer.c                 |  6 +--
 19 files changed, 147 insertions(+), 43 deletions(-)
