From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 27 Dec 2017 18:07:51 -0800
Subject: [GIT PULL 2/3] SOC: Keystone SOC update for 4.16
In-Reply-To: <1514426872-5769-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1514426872-5769-1-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <1514426872-5769-2-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_driver_soc_for_4.16

for you to fetch changes up to aefc5818553680c50c9f6840e47c01b80edd9b3a:

  soc: ti: fix max dup length for kstrndup (2017-12-16 14:45:33 -0800)

----------------------------------------------------------------
SOC: Keystone Soc driver updates for 4.16

 - TI EMIF-SRAM driver
 - TI SCI print format fix
 - Navigator strndup lenth fix

----------------------------------------------------------------
Arnd Bergmann (1):
      memory: ti-emif-sram: remove unused variable

Dave Gerlach (2):
      Documentation: dt: Update ti,emif bindings
      memory: ti-emif-sram: introduce relocatable suspend/resume handlers

Ma Shimiao (1):
      soc: ti: fix max dup length for kstrndup

Nishanth Menon (1):
      firmware: ti_sci: Use %zu for size_t print format

 .../bindings/memory-controllers/ti/emif.txt        |  17 +-
 drivers/firmware/ti_sci.c                          |   4 +-
 drivers/memory/Kconfig                             |  10 +
 drivers/memory/Makefile                            |   8 +
 drivers/memory/Makefile.asm-offsets                |   5 +
 drivers/memory/emif-asm-offsets.c                  |  92 ++++++
 drivers/memory/emif.h                              |  17 ++
 drivers/memory/ti-emif-pm.c                        | 324 ++++++++++++++++++++
 drivers/memory/ti-emif-sram-pm.S                   | 334 +++++++++++++++++++++
 drivers/soc/ti/knav_qmss_queue.c                   |   4 +-
 include/linux/ti-emif-sram.h                       |  69 +++++
 11 files changed, 879 insertions(+), 5 deletions(-)
 create mode 100644 drivers/memory/Makefile.asm-offsets
 create mode 100644 drivers/memory/emif-asm-offsets.c
 create mode 100644 drivers/memory/ti-emif-pm.c
 create mode 100644 drivers/memory/ti-emif-sram-pm.S
 create mode 100644 include/linux/ti-emif-sram.h
