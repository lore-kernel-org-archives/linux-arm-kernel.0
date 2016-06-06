From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Jun 2016 10:11:32 +0100
Subject: [PATCH v2 0/9] coresight: Miscellaneous fixes
Message-ID: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a collection fixes / cleanups for the coresight driver.

Patches 1-5 are fixes, and the remaining patches are clean ups.

Changes since V2:
 - Added a patch to limit the trace data
 - Added a patch to fix tmc_read_unprepare_etr (another crash)
 - Split the patch to remove erraneous dma_free_coherent.
 - Use consistent error message format for coresight_timeout cleanup.
 - Fixed checkpatch warnings on the commit description, there are
   some errors reported on the "crash output" in the commit description.
   May be the checkpatch needs to be fixed ?

Suzuki K Poulose (9):
  coresight: Fix NULL pointer dereference in _coresight_build_path
  coresight: Fix tmc_read_unprepare_etr
  coresight: Remove erroneous dma_free_coherent in tmc_probe
  coresight: Fix csdev connections initialisation
  coresight: tmc: Limit the trace to available data
  coresight: etmv4: Fix ETMv4x peripheral ID table
  coresight: Cleanup TMC status check
  coresight: Consolidate error handling path for tmc_probe
  coresight: Add better messages for coresight_timeout

 drivers/hwtracing/coresight/coresight-etb10.c   |  7 ++--
 drivers/hwtracing/coresight/coresight-etm4x.c   | 14 +++----
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 14 +++++--
 drivers/hwtracing/coresight/coresight-tmc.c     | 52 +++++++++++--------------
 drivers/hwtracing/coresight/coresight-tmc.h     |  4 +-
 drivers/hwtracing/coresight/coresight.c         | 30 +++++++-------
 7 files changed, 64 insertions(+), 59 deletions(-)

-- 
1.9.1
