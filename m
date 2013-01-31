From: robherring2@gmail.com (Rob Herring)
Date: Thu, 31 Jan 2013 14:01:11 -0600
Subject: [PATCH 0/3] More highbank fixes for 3.8
Message-ID: <1359662474-1883-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

A couple more fixes for highbank related to fallout from using MPIDR
value for the physical cpu id and an scu build error introduced by
suspend fixes. 

Rob

Rob Herring (3):
  ARM: scu: add empty scu_enable for !CONFIG_SMP
  ARM: scu: mask cluster id from cpu_logical_map
  ARM: highbank: mask cluster id from cpu_logical_map

 arch/arm/include/asm/smp_scu.h    |    8 +++++++-
 arch/arm/kernel/smp_scu.c         |    2 +-
 arch/arm/mach-highbank/highbank.c |    3 ++-
 arch/arm/mach-highbank/sysregs.h  |    4 ++--
 4 files changed, 12 insertions(+), 5 deletions(-)

-- 
1.7.10.4
