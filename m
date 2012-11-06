From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Nov 2012 22:55:25 +0100
Subject: [PATCH 0/8] warning fixes for v3.7-rc4
Message-ID: <1352238933-4886-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Here are a few patches for remaining or newly introduced build
warnings in the ARM defconfig builds. The MTD patches have
been around for some time, but I had not submitted them because
I had to redo most of them first.

The only build error in this series is the exynos drm patch,
which is a very recent regression.

Please apply in to the respective maintainer trees.

	Arnd

Arnd Bergmann (8):
  mtd: diskonchip: don't warn about ARM architecture
  mtd: diskonchip: use inline functions for DocRead/DocWrite
  mtd: uninitialized variable warning in map.h
  sched: warnings in kernel/sched/fair.c
  mmc: dw_mmc: fix modular build for exynos back-end
  mmc: dw_mmc: constify dw_mci_idmac_ops in exynos back-end
  ata: highbank: mark ahci_highbank_probe as __devinit
  drm/exynos: don't include plat/gpio-cfg.h

 drivers/ata/sata_highbank.c          |    2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c |    1 -
 drivers/mmc/host/dw_mmc-exynos.c     |    8 ++++----
 drivers/mmc/host/dw_mmc-pltfm.c      |    2 +-
 drivers/mmc/host/dw_mmc-pltfm.h      |    2 +-
 drivers/mmc/host/dw_mmc.c            |    2 +-
 drivers/mtd/devices/docprobe.c       |    2 --
 drivers/mtd/nand/diskonchip.c        |    2 --
 include/linux/mmc/dw_mmc.h           |    4 ++--
 include/linux/mtd/doc2000.h          |   22 ++++++++++++++++++----
 include/linux/mtd/map.h              |    2 +-
 kernel/sched/fair.c                  |    2 +-
 12 files changed, 30 insertions(+), 21 deletions(-)


Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Boonstoppel <pboonstoppel@nvidia.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Rahul Sharma <rahul.sharma@samsung.com>
Cc: Rob Clark <rob@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Will Newton <will.newton@imgtec.com>
Cc: linux-mtd at lists.infradead.org
-- 
1.7.10
