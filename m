From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 May 2015 15:49:38 +0200
Subject: [GIT PULL 6/8] ARM: tegra: Core SoC changes for v4.2-rc1
In-Reply-To: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
References: <1431524980-13599-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1431524980-13599-7-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.2-soc

for you to fetch changes up to 7892158a96629c46c46dfae52eaf951f51222cf5:

  soc/tegra: pmc: move to using a restart handler (2015-05-04 14:21:45 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Core SoC changes for v4.2-rc1

A couple of changes to the core SoC support code. Perhaps the most
important part is a fix for a regression in LP1 suspend/resume code that
was introduced a while back.

----------------------------------------------------------------
David Riley (1):
      soc/tegra: pmc: move to using a restart handler

Dmitry Osipenko (1):
      ARM: tegra20: Store CPU "resettable" status in IRAM

Nicholas Mc Guire (1):
      soc/tegra: Watch wait_for_completion_timeout() return type

 arch/arm/mach-tegra/cpuidle-tegra20.c |  5 ++---
 arch/arm/mach-tegra/reset-handler.S   | 10 +++++++---
 arch/arm/mach-tegra/reset.h           |  4 ++++
 arch/arm/mach-tegra/sleep-tegra20.S   | 37 ++++++++++++++++++++---------------
 arch/arm/mach-tegra/sleep.h           |  4 ++++
 arch/arm/mach-tegra/tegra.c           |  1 -
 drivers/soc/tegra/fuse/fuse-tegra20.c |  6 ++++--
 drivers/soc/tegra/pmc.c               | 23 ++++++++++++++++------
 include/soc/tegra/pmc.h               |  2 --
 9 files changed, 59 insertions(+), 33 deletions(-)
