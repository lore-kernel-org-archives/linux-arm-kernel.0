From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 17:54:54 +0100
Subject: [PATCH 0/7] memory: atmel-ebi: Add PM ops
Message-ID: <1487609701-10300-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset adds a ->resume() hook to the EBI driver, but a few more
changes were required in order to easily implement this PM hook.

Patches 1 to 5 are just cleanup patches to simplify the EBI driver.
Patch 6 is fixing a bug in the EBI driver. Note that this bug has no
consequences until we start implementing the ->resume() hook.
And finally, patch 7 is implementing ->resume() so that the SMC config
is correctly restored when resuming the system.

This patchset depends on [1] which is removing the unused pata_at91
driver, which in turn prevents us from patching it before dropping
the old SMC macro definitions in patch 4.

Regards,

Boris

[1]http://lkml.iu.edu/hypermail/linux/kernel/1702.2/00990.html

Boris Brezillon (7):
  mfd: syscon: atmel-smc: Add new helpers to ease SMC regs manipulation
  memory: atmel-ebi: Simplify SMC config code
  memory: atmel-ebi: Stop using reg_field objects for simple things
  mfd: syscon: atmel-smc: Remove unused helpers/macros
  memory: atmel-ebi: Change naming scheme
  memory: atmel-ebi: Add missing ->numcs assignment
  memory: atmel-ebi: Add PM ops

 drivers/memory/atmel-ebi.c           | 583 ++++++++++++-----------------------
 include/linux/mfd/syscon/atmel-smc.h | 456 +++++++++++++++++++--------
 2 files changed, 532 insertions(+), 507 deletions(-)

-- 
2.7.4
