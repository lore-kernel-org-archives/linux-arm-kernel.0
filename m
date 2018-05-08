From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Tue,  8 May 2018 14:41:36 -0700
Subject: [GIT PULL 1/2] ARM: SOC driver update v4.18
Message-ID: <1525815697-6338-1-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.18

for you to fetch changes up to 1e0a601437a6111ecf384df010812c53cada6497:

  firmware: ti_sci: Switch to SPDX Licensing (2018-05-04 23:10:23 -0700)

----------------------------------------------------------------
ARM: SOC driver update for 4.18

 - AEMIF driver update to support board files and remove
   need of mach-davinci aemif code
 - Use percpu counters for qmss datapath stats
 - License update for TI SCI

----------------------------------------------------------------
Bartosz Golaszewski (2):
      memory: aemif: don't rely on kbuild for driver's name
      memory: aemif: add support for board files

Lokesh Vutla (1):
      firmware: ti_sci: Switch to SPDX Licensing

Vasyl Gomonovych (1):
      soc: ti: knav_qmss: Use percpu instead atomic for stats counter

 drivers/firmware/ti_sci.c              | 10 +-----
 drivers/firmware/ti_sci.h              | 30 +----------------
 drivers/memory/ti-aemif.c              | 60 ++++++++++++++++++++++------------
 drivers/soc/ti/knav_qmss.h             | 14 ++++----
 drivers/soc/ti/knav_qmss_queue.c       | 60 ++++++++++++++++++++++------------
 include/linux/platform_data/ti-aemif.h | 25 ++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h | 10 +-----
 7 files changed, 115 insertions(+), 94 deletions(-)
