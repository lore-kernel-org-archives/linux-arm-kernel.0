From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Jul 2015 16:13:47 -0700
Subject: [GIT PULL] Broadcom SoC changes for 4.3 (part 1)
In-Reply-To: <1437088427-31176-1-git-send-email-f.fainelli@gmail.com>
References: <1437088427-31176-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1437088427-31176-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.3/soc

for you to fetch changes up to ffb910d7b84f21ef6caeed041032a0af8d2e00ed:

  ARM: BCM63xx: Remove custom secondary_startup function (2015-07-11 18:33:51 -0700)

----------------------------------------------------------------
This pull request contains two fixes for the Broadcom BCM63xx SMP code:

- Sudeep removes an invalid use of cpu_logical_map() which turned to be a no-op
  since we always boot from physical CPU 0 = logical CPU 0

- Florian removes the custom secondary_startup function and replaces it with
  the generic one

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: BCM63xx: Remove custom secondary_startup function

Sudeep Holla (1):
      ARM: BCM63xx: fix parameter to of_get_cpu_node in bcm63138_smp_boot_secondary

 arch/arm/mach-bcm/Makefile          |  4 +---
 arch/arm/mach-bcm/bcm63xx_headsmp.S | 23 -----------------------
 arch/arm/mach-bcm/bcm63xx_smp.c     |  4 ++--
 arch/arm/mach-bcm/bcm63xx_smp.h     |  1 -
 4 files changed, 3 insertions(+), 29 deletions(-)
 delete mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S
