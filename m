From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 8 Jul 2011 14:43:04 +0530
Subject: [GIT PULL] DaVinci features for v3.1
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D9B56E8@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following DaVinci features for v3.1.

This pull request depends on the patch "davinci: dm6467/T EVM: fix setting
up of reference clock rate" in clean-up pull request for successful build.

Pulling this after the earlier clean-up pull request generates this merge
conflict:

<<<<<<< HEAD:arch/arm/mach-davinci/include/mach/psc.h
#define MDSTAT_STATE_MASK	0x1f
=======
#define MDSTAT_STATE_MASK 0x1f
#define MDCTL_FORCE		BIT(31)
>>>>>>> 8bb2c4813c534d26eba3beb7888fbd3cbc931f62:arch/arm/mach-davinci/include/mach/psc.h

The resolution is:

#define MDSTAT_STATE_MASK	0x1f
#define MDCTL_FORCE		BIT(31)

Thanks,
Sekhar

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:
  Linus Torvalds (1):
        Linux 3.0-rc6

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git features

Christian Riesch (1):
      davinci: da850: add a .set_rate method to ref_clk

Sekhar Nori (4):
      davinci: pass clock flags to davinci_psc_config()
      davinci: enable forced transitions on PSC
      davinci: da850: add support for SATA interface
      davinci: da850 evm: register SATA device

 arch/arm/mach-davinci/board-da850-evm.c    |    7 ++
 arch/arm/mach-davinci/clock.c              |    8 +-
 arch/arm/mach-davinci/clock.h              |    1 +
 arch/arm/mach-davinci/da850.c              |   10 ++
 arch/arm/mach-davinci/devices-da8xx.c      |  126 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 arch/arm/mach-davinci/include/mach/psc.h   |    3 +-
 arch/arm/mach-davinci/psc.c                |   14 +++-
 8 files changed, 164 insertions(+), 7 deletions(-)
