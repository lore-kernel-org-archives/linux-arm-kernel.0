From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 21 Jun 2016 17:10:47 +0100
Subject: [PATCH v3 0/7] coresight: Miscellaneous fixes
Message-ID: <1466525454-14702-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a collection of cleanups and minor enhancements to the
coresight driver. Applies on v4.7-rc4

Changes since V2:
 - Removed patches already queued as fixes for 4.7
 - Addressed comments on V2.

Changes since V1:
 - Added a patch to limit the trace data
 - Added a patch to fix tmc_read_unprepare_etr (another crash)
 - Split the patch to remove erraneous dma_free_coherent.
 - Use consistent error message format for coresight_timeout cleanup.
 - Fixed checkpatch warnings on the commit description, there are
   some errors reported on the "crash output" in the commit description.
   May be the checkpatch needs to be fixed ?


Suzuki K Poulose (7):
  coresight: Remove erroneous dma_free_coherent in tmc_probe
  coresight: Consolidate error handling path for tmc_probe
  coresight: Fix csdev connections initialisation
  coresight: tmc: Limit the trace to available data
  coresight: etmv4: Fix ETMv4x peripheral ID table
  coresight: Cleanup TMC status check
  coresight: Add better messages for coresight_timeout

 drivers/hwtracing/coresight/coresight-etb10.c   |  6 +--
 drivers/hwtracing/coresight/coresight-etm4x.c   | 14 +++----
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 12 ++++--
 drivers/hwtracing/coresight/coresight-tmc.c     | 51 +++++++++++--------------
 drivers/hwtracing/coresight/coresight-tmc.h     |  4 +-
 drivers/hwtracing/coresight/coresight.c         | 24 +++++++-----
 7 files changed, 58 insertions(+), 55 deletions(-)

-- 
1.9.1
