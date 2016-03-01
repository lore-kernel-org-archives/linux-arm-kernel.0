From: tony@atomide.com (Tony Lindgren)
Date: Tue,  1 Mar 2016 15:01:18 -0800
Subject: [GIT PULL 1/4] omap non-urgent fixes for v4.6 merge window
Message-ID: <pull-1456872971-400983>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.6/fixes-not-urgent-signed

for you to fetch changes up to 4f5395f0d1a5b7c8921331ef81081da00302a37c:

  ARM: OMAP2+: Fix hwmod clock for l4_ls (2016-02-26 11:03:07 -0800)

----------------------------------------------------------------
Fixes for omaps for v4.6 merge window that are not urgent
for the v4.5-rc cycle:

- Add back optimized cpuidle parameters for 34xx that were
  incorrecly removed earlier with cpuidle cleanup

- Fix SSI for omap36xx to get modem working on N950/N9

- A series of omap hwmod fixes via Paul Walmsley <paul@pwsan.com>
  to fix SSI for omap36xx for modem on N950/N9, fix for
  OCP2SCP sysconfig idle mode, and reset data for PCIe on
  dra7

- Fix out of range register access for omap3 control module
  if syscon max_register is initialized like v4.6 will be
  doing

- Fix l4_ls interconnect clocks for 81xx, it should always
  be sysclk6_ck

----------------------------------------------------------------
Kishon Vijay Abraham I (2):
      ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
      ARM: DRA7: hwmod: Add reset data for PCIe

Pali Roh?r (1):
      ARM: OMAP3: Add cpuidle parameters table for omap3430

Sebastian Reichel (1):
      ARM: OMAP2+: hwmod data: Add SSI data for omap36xx

Tony Lindgren (3):
      Merge tag 'for-v4.6/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.6/fixes-not-urgent
      ARM: OMAP2+: Fix out of range register access with syscon_config.max_register
      ARM: OMAP2+: Fix hwmod clock for l4_ls

 arch/arm/mach-omap2/control.c              | 21 +--------
 arch/arm/mach-omap2/cpuidle34xx.c          | 69 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 13 +++---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 18 +++++++-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  9 +++-
 arch/arm/mach-omap2/prm7xx.h               |  1 +
 6 files changed, 101 insertions(+), 30 deletions(-)
