From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  7 Dec 2015 15:57:29 -0800
Subject: [GIT PULL 1/4] Broadcom soc changes for v4.5
In-Reply-To: <1449532649-6471-1-git-send-email-f.fainelli@gmail.com>
References: <1449532649-6471-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1449532649-6471-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.5/soc

for you to fetch changes up to 99498905ac1fbc73a97d27d21ea449fb939072e3:

  ARM: BCM: Add SMP support for Broadcom 4708 (2015-12-07 12:30:51 -0800)

----------------------------------------------------------------
This pull request contains Broadcom SoC changes for 4.5, with the following changes:

- Lucas Stach removes the workaround for an imprecise fault for Broadcom
  BCM5301x SoCs (Northstar) since this is now handled by the ARM/Linux kernel
  directly

- Hauke Merthens enables a bunch of erratas for the Cortex-A9 and PL310 L2
  cache present on early Northstar chips (BCM4708)

- Kapil Hali adds SMP support for the Northstar Plus SoCs by consolidating the
  existing SMP code for Kona SoCs (mobile platforms), fixng the Device Tree
  binding for the Kona platforms (wrong placement for 'enable-method' and
  'secondary-reg') and then finally adds the functional code for the Northstar
  Plus platforms to boot their secondary CPUs

- Jon Mason enables SMP on BCM4708/BCM5301X (Northstar SoCs) by building the generic
  Northstar/Northstar Plus SMP code, and adding the relevant SMP Device Tree nodes

----------------------------------------------------------------
Hauke Mehrtens (1):
      ARM: BCM5310X: activate erratas needed for SoC

Jon Mason (1):
      ARM: BCM: Add SMP support for Broadcom 4708

Kapil Hali (2):
      ARM: BCM: Clean up SMP support for Broadcom Kona
      ARM: BCM: Add SMP support for Broadcom NSP

Lucas Stach (1):
      ARM: BCM5301X: remove workaround imprecise abort fault handler

 arch/arm/boot/dts/bcm11351.dtsi             |   2 +-
 arch/arm/boot/dts/bcm21664.dtsi             |   2 +-
 arch/arm/boot/dts/bcm4708.dtsi              |   2 +
 arch/arm/mach-bcm/Kconfig                   |   7 ++
 arch/arm/mach-bcm/Makefile                  |  11 ++-
 arch/arm/mach-bcm/bcm_5301x.c               |  35 -------
 arch/arm/mach-bcm/{kona_smp.c => platsmp.c} | 144 ++++++++++++++++++++++------
 7 files changed, 136 insertions(+), 67 deletions(-)
 rename arch/arm/mach-bcm/{kona_smp.c => platsmp.c} (63%)
