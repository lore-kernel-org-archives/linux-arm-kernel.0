From: hechtb@googlemail.com (Bastian Hecht)
Date: Thu, 25 Oct 2012 12:58:19 +0200
Subject: [PATCH 0/3] Use generic helper scu_power_mode()
Message-ID: <1351162702-8391-1-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reposted to include the arch/arm mailing list.

The shmobile series implements its own code for setting the SCU power
register of the ARM MPCore. It uses 32-bit wide access and thus needs
locking as multiple CPUs might access it simultaneously for change. There is
already a small helper function that avoids the overhead by using 8-bit
wide access: As every CPU only accesses its own field we can drop the
lock and use it.

Bastian Hecht (3):
  ARM: shmobile: emev2: Replace modify_scu_cpu_psr with scu_power_mode
  ARM: shmobile: sh73a0: Replace modify_scu_cpu_psr with scu_power_mode
  ARM: shmobile: r8a7779: Replace modify_scu_cpu_psr with
    scu_power_mode

 arch/arm/mach-shmobile/smp-emev2.c   |   22 ++--------------------
 arch/arm/mach-shmobile/smp-r8a7779.c |   25 +++----------------------
 arch/arm/mach-shmobile/smp-sh73a0.c  |   23 ++---------------------
 3 files changed, 7 insertions(+), 63 deletions(-)

-- 
1.7.9.5
