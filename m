From: per.forlin@linaro.org (Per Forlin)
Date: Thu, 21 Jul 2011 00:01:58 +0200
Subject: [PATCH v3 0/3] Make fault injection available for MMC IO
Message-ID: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first version of this patch is a part of mmc non-blocking v9 patchset:
[PATCH v9 11/12] mmc: core: add random fault injection

change log:
 v2 - Resolve build issue in mmc core.c due to multiple init_module by
      removing the fault inject module.
    - Export fault injection functions to make them available for modules
    - Update fault injection documentation on MMC IO  
 v3 - add function descriptions in core.c
    - use export GPL for fault injection functions

Per Forlin (3):
  fault-inject: make fault injection available for modules
  mmc: core: add random fault injection
  fault injection: add documentation on MMC IO fault injection

 Documentation/fault-injection/fault-injection.txt |    5 ++
 drivers/mmc/core/core.c                           |   69 +++++++++++++++++++++
 drivers/mmc/core/debugfs.c                        |    5 ++
 include/linux/mmc/host.h                          |    3 +
 lib/Kconfig.debug                                 |   11 +++
 lib/fault-inject.c                                |    2 +
 6 files changed, 95 insertions(+), 0 deletions(-)

-- 
1.7.4.1
