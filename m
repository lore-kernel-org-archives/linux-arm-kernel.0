From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 4 Jan 2017 17:43:54 +0530
Subject: [GIT PULL] DaVinci fixes for v4.10
Message-ID: <20170104121354.8467-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.10

for you to fetch changes up to d1df1e01af1d7c91e48204b9eb8b9f20cdb90700:

  ARM: davinci: da8xx: Fix sleeping function called from invalid context (2017-01-02 16:15:07 +0530)

----------------------------------------------------------------
This pull request contains fixes for the following issues

1) Fix two instances of infinite loop occurring in
   clock list for DA850. This fixes kernel hangs in some
   instances and so have been marked for stable kernel.

2) Fix for sleeping function called from atomic context
   with USB 2.0 clock management code introduced in v4.10
   merge window.

----------------------------------------------------------------
Alexandre Bailon (2):
      ARM: davinci: Make __clk_{enable,disable} functions public
      ARM: davinci: da8xx: Fix sleeping function called from invalid context

Bartosz Golaszewski (2):
      ARM: davinci: da850: fix infinite loop in clk_set_rate()
      ARM: davinci: da850: don't add emac clock to lookup table twice

 arch/arm/mach-davinci/clock.c     | 12 ++++++------
 arch/arm/mach-davinci/clock.h     |  2 ++
 arch/arm/mach-davinci/da850.c     | 32 ++++++++++++++++++++++++++++++--
 arch/arm/mach-davinci/usb-da8xx.c | 34 +++++++++++++++-------------------
 4 files changed, 53 insertions(+), 27 deletions(-)
