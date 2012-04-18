From: tony@atomide.com (Tony Lindgren)
Date: Wed, 18 Apr 2012 11:23:50 -0700
Subject: [GIT PULL] omap fixes for v3.4-rc3
Message-ID: <20120418182349.GM21106@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Here are some fixes for the -rc cycle. The biggest change is to
remove bad muxing for serial ports that was causing random oopses
with at least zoom3 and nfsroot.

Now using a signed tag.

Regards,

Tony


The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.4-rc3

for you to fetch changes up to 6aaec67da1e41a0752a2b903b989e73b9f02e182:

  ARM: OMAP1: DMTIMER: fix broken timer clock source selection (2012-04-17 15:30:16 -0700)

----------------------------------------------------------------
Fix regression for bad uart muxing and oops when PM is not set.
Revert one softreset regression and few other minor fixes.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP1: mux: add missing include

Archit Taneja (1):
      ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC slave interface

Fernando Guzman Lugo (1):
      ARM: OMAP2+: hwmod: add softreset delay field and OMAP4 data

Govindraj.R (1):
      ARM: OMAP2+: UART: Fix incorrect population of default uart pads

Grazvydas Ignotas (1):
      ARM: OMAP: sram: fix BUG in dpll code for !PM case

Paul Walmsley (2):
      ARM: OMAP2+: hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for reset status"
      ARM: OMAP1: DMTIMER: fix broken timer clock source selection

Santosh Shilimkar (1):
      ARM: OMAP: serial: Fix the ocp smart idlemode handling bug

Tony Lindgren (1):
      Merge tag 'omap-fixes-b-for-3.4rc' of git://git.kernel.org/.../pjw/omap-pending into fixes

 arch/arm/mach-omap1/mux.c                    |    1 +
 arch/arm/mach-omap1/timer.c                  |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   17 +++-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    1 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    9 ++
 arch/arm/mach-omap2/serial.c                 |  124 ++------------------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +-
 arch/arm/plat-omap/sram.c                    |   12 +--
 10 files changed, 43 insertions(+), 131 deletions(-)
