From: will.deacon@arm.com (Will Deacon)
Date: Fri,  9 Nov 2012 15:06:55 +0000
Subject: [GIT PULL] hw-breakpoint updates for 3.8
Message-ID: <1352473615-18371-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This series of patches reworks much of the debug register reset sequence
for ARM debug architecture 7.1 in light of some comments from Stephen
Boyd.

Thanks,

Will


The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git hw-breakpoint

Dietmar Eggemann (1):
      ARM: hw_breakpoint: use CRn as argument for debug reg accessor macros

Will Deacon (7):
      ARM: hw_breakpoint: only clear OS lock when implemented on v7
      ARM: hw_breakpoint: fix monitor mode detection with v7.1
      ARM: hw_breakpoint: fix ordering of debug register reset sequence
      ARM: hw_breakpoint: don't try to clear v6 debug registers during boot
      ARM: hw_breakpoint: make boot quieter without CPUID feature registers
      ARM: hw_breakpoint: check if monitor mode is enabled during validation
      ARM: hw_breakpoint: kill WARN_ONCE usage

 arch/arm/include/asm/hw_breakpoint.h |    8 +-
 arch/arm/kernel/hw_breakpoint.c      |  154 +++++++++++++++++++---------------
 2 files changed, 89 insertions(+), 73 deletions(-)
