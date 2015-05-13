From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 13 May 2015 15:34:13 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.2
In-Reply-To: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
References: <1431556453-11633-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1431556453-11633-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.2/soc

for you to fetch changes up to d044ce725eea4d7b74bcb6e9e7b33996aae77f04:

  ARM: BCM63xx: Add SMP support for BCM63138 (2015-05-13 09:59:07 -0700)

----------------------------------------------------------------
This pull request contains the following changes:

- BCM63138 SMP support which pulls in code to control the PMB bus, secondary CPU initialization
  sequence and small changes suggested by Russell King to allow platforms to disable VFP

----------------------------------------------------------------
Florian Fainelli (5):
      ARM: BCM63xx: Add Broadcom BCM63xx PMB controller helpers
      ARM: BCM63xx: Add secondary CPU PMB initialization sequence
      ARM: vfp: Add include guards
      ARM: vfp: Add vfp_disable for problematic platforms
      ARM: BCM63xx: Add SMP support for BCM63138

 arch/arm/include/asm/vfp.h          |   9 ++
 arch/arm/mach-bcm/Makefile          |   7 +-
 arch/arm/mach-bcm/bcm63xx_headsmp.S |  23 ++++
 arch/arm/mach-bcm/bcm63xx_pmb.c     | 221 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.c     | 170 +++++++++++++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.h     |   9 ++
 arch/arm/vfp/vfpmodule.c            |  13 +++
 include/linux/bcm63xx_pmb.h         |  76 +++++++++++++
 8 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S
 create mode 100644 arch/arm/mach-bcm/bcm63xx_pmb.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.h
 create mode 100644 include/linux/bcm63xx_pmb.h
