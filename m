From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 2 Feb 2017 19:03:45 +0530
Subject: [GIT PULL 1/4] DaVinci driver updates
Message-ID: <20170202133348.32713-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/drivers

for you to fetch changes up to cdf0ead3747200d527f37170d3fdd41e368f88b0:

  sata: ahci-da850: un-hardcode the MPY bits (2017-01-31 20:41:52 +0530)

----------------------------------------------------------------
Driver updates for SATA support on DA850.

These have been acked by SATA maintainer
Tejun Heo. Tejun preferred these be queued
through ARM-SoC because of the dependencies
with platform code.

----------------------------------------------------------------
Bartosz Golaszewski (6):
      sata: ahci-da850: get the sata clock using a connection id
      sata: ahci-da850: add device tree match table
      sata: ahci-da850: implement a workaround for the softreset quirk
      sata: ahci: export ahci_do_hardreset() locally
      sata: ahci-da850: add a workaround for controller instability
      sata: ahci-da850: un-hardcode the MPY bits

 drivers/ata/ahci.h       |   3 +
 drivers/ata/ahci_da850.c | 175 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/ata/libahci.c    |  18 +++--
 3 files changed, 174 insertions(+), 22 deletions(-)
