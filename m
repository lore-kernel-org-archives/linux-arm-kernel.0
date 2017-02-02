From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 2 Feb 2017 19:03:46 +0530
Subject: [GIT PULL 2/4]: DaVinci SoC support updates (part 2)
In-Reply-To: <20170202133348.32713-1-nsekhar@ti.com>
References: <20170202133348.32713-1-nsekhar@ti.com>
Message-ID: <20170202133348.32713-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9c9b1bc25291e275b04f758f2549c81e092954f5:

  ARM: davinci: add skeleton for pdata-quirks (2017-01-23 20:52:38 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/soc-2

for you to fetch changes up to a3035886852cd859e371550fe726da08b85c67d0:

  ARM: davinci: remove BUG_ON() from da850_register_sata() (2017-01-31 20:48:25 +0530)

----------------------------------------------------------------
SoC updates needed for SATA support on
DA850.

This includes a merge of non-critical-fixes
branch already queued for v4.11 because
SATA clock addition conflicts with the fix-up
done earlier.

----------------------------------------------------------------
Bartosz Golaszewski (7):
      ARM: davinci: da850: coding style fix
      ARM: davinci: da850: fix da850_set_pll0rate()
      bus: da850-mstpri: fix my e-mail address
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for SATA
      ARM: davinci: da850: add con_id for the SATA clock
      ARM: davinci: da850: model the SATA refclk
      ARM: davinci: remove BUG_ON() from da850_register_sata()

Sekhar Nori (1):
      Merge branch 'v4.11/fixes-non-critical' into v4.11/soc

 arch/arm/mach-davinci/da850.c              | 24 +++++++++++++++++++-----
 arch/arm/mach-davinci/da8xx-dt.c           |  9 +++++++++
 arch/arm/mach-davinci/devices-da8xx.c      | 30 ++++++++++++++++++++++++++++--
 arch/arm/mach-davinci/include/mach/da8xx.h |  1 +
 drivers/bus/da8xx-mstpri.c                 |  2 +-
 drivers/cpufreq/davinci-cpufreq.c          |  2 +-
 6 files changed, 59 insertions(+), 9 deletions(-)
