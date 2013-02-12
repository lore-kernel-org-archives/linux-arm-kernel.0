From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Feb 2013 11:22:17 -0800
Subject: [GIT PULL] ARM: arm-soc fixes for 3.8
Message-ID: <20130212192217.GA18964@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39:

  Linux 3.8-rc7 (2013-02-09 08:20:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 893db07f50596bd42248dcffbe8157abc7204bdd:

  Merge tag 'highbank-fixes-for-3.8' of git://sources.calxeda.com/kernel/linux into fixes (2013-02-09 20:55:03 -0800)

----------------------------------------------------------------

ARM: arm-soc fixes for 3.8

We had a number of fixes queued up, but taking a strict pass-through
and weeding out any that either have been broken for a while, or are
for platforms that need out-of-tree code to be useful anyway, or other
fixes for problems that few users are likely to see in real life, only
this short branch of patches remains.

The three patches here are to make SMP boot work on the Calxeda
platforms again. Some of the rework for cpuids on 3.8 broke it (and it
was discovered late, unfortunately).

----------------------------------------------------------------
Olof Johansson (1):
      Merge tag 'highbank-fixes-for-3.8' of git://sources.calxeda.com/kernel/linux into fixes

Rob Herring (3):
      ARM: scu: add empty scu_enable for !CONFIG_SMP
      ARM: scu: mask cluster id from cpu_logical_map
      ARM: highbank: mask cluster id from cpu_logical_map

 arch/arm/include/asm/smp_scu.h    | 8 +++++++-
 arch/arm/kernel/smp_scu.c         | 2 +-
 arch/arm/mach-highbank/highbank.c | 3 ++-
 arch/arm/mach-highbank/sysregs.h  | 4 ++--
 4 files changed, 12 insertions(+), 5 deletions(-)
