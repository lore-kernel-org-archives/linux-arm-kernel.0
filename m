From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu, 18 Jun 2015 17:47:46 +0530
Subject: [PATCH v2 0/7] fix build failure of mn10300
Message-ID: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This is an attempt to fix the build failures when building mn10300 with
allmodconfig. As I have never worked with arch files so I hope you will
point me to right direction to correct my mistakes in this attempt.

regards
sudip

Sudip Mukherjee (7):
  mn10300: fix build failure
  mn10300: Provide dummy dma_alloc_attrs() and dma_free_attrs()
  mmc: mediatek: build as module
  USB: mos7720: rename DCR
  samples: kdbus: disable for mn10300
  mn10300: kgdb_arch_set_pc
  mn10300: add early_init_dt_*

 arch/mn10300/include/asm/dma-mapping.h | 13 +++++++++++++
 arch/mn10300/include/asm/kprobes.h     | 12 ++++++++++++
 arch/mn10300/kernel/kgdb.c             |  5 +++++
 arch/mn10300/kernel/setup.c            | 15 +++++++++++++++
 drivers/mmc/host/mtk-sd.c              |  1 +
 drivers/usb/serial/mos7720.c           | 16 ++++++++--------
 samples/Kconfig                        |  2 +-
 7 files changed, 55 insertions(+), 9 deletions(-)

-- 
1.8.1.2
