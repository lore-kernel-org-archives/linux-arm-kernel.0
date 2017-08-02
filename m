From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:21:54 -0600
Subject: [PATCH 00/26] coresight: next v4.13-rc3 
Message-ID: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning Grep,

These are the patches I'd like you to consider for inclusion in the v4.14
cycle.  Please have a look when you get the chance.  As usual I made sure
things apply on your char-misc-next branch (24a81a2c2581).

Thanks,
Mathieu

Arvind Yadav (1):
  hwtracing: coresight: constify attribute_group structures.

Mathieu Poirier (5):
  coresight: Correct buffer lost increment
  coresight: etb10: Remove useless conversion to LE
  coresight: Add barrier packet for synchronisation
  coresight: etb10: Move etb_disable_hw() outside of lock
  coresight: etm3x: Set synchronisation frequencty to TRM default

Mike Leach (4):
  coresight: pmu: Adds return stack option to perf coresight pmu
  coresight: ptm: Adds trace return stack option programming for PTM.
  coresight: etm4x: Adds trace return stack option programming for
    ETMv4.
  perf: cs-etm: Fix ETMv4 CONFIGR entry in perf.data file

Stephen Boyd (1):
  coresight: STM: Clean up __iomem type usage

Suzuki K Poulose (15):
  coresight replicator: Cleanup programmable replicator naming
  coresight: Add support for reading 64bit registers
  coresight: Use the new helper for defining registers
  coresight tmc: Add helpers for accessing 64bit registers
  coresight tmc: Expose DBA and AXICTL
  coresight replicator: Expose replicator management registers
  coresight tmc: Handle configuration types properly
  coresight tmc etr: Add capabilitiy information
  coresight tmc: Detect support for scatter gather
  coresight tmc etr: Detect address width at runtime
  coresight tmc etr: Cleanup AXICTL register handling
  coresight tmc etr: Setup AXI cache encoding for read transfers
  coresight tmc: Support for save-restore in ETR
  coresight tmc: Add support for Coresight SoC 600 TMC
  coresight: Add support for Coresight SoC 600 components

 .../devicetree/bindings/arm/coresight.txt          |   4 +-
 drivers/hwtracing/coresight/Kconfig                |  10 +-
 drivers/hwtracing/coresight/Makefile               |   2 +-
 ...cator-qcom.c => coresight-dynamic-replicator.c} |  32 ++++++-
 drivers/hwtracing/coresight/coresight-etb10.c      |  68 ++++++++-----
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   4 +-
 drivers/hwtracing/coresight/coresight-etm.h        |   1 +
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  26 ++---
 drivers/hwtracing/coresight/coresight-etm3x.c      |  20 +++-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  24 ++---
 drivers/hwtracing/coresight/coresight-etm4x.c      |   4 +
 drivers/hwtracing/coresight/coresight-funnel.c     |   5 +
 drivers/hwtracing/coresight/coresight-priv.h       |  39 +++++++-
 drivers/hwtracing/coresight/coresight-stm.c        |  47 ++++-----
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  42 ++++++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  49 +++++++---
 drivers/hwtracing/coresight/coresight-tmc.c        | 106 ++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc.h        |  85 ++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpiu.c       |   5 +
 drivers/hwtracing/coresight/coresight.c            |   8 ++
 include/linux/coresight-pmu.h                      |   6 ++
 tools/include/linux/coresight-pmu.h                |   6 ++
 tools/perf/arch/arm/util/cs-etm.c                  |  28 +++++-
 23 files changed, 485 insertions(+), 136 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-replicator-qcom.c => coresight-dynamic-replicator.c} (87%)

-- 
2.7.4
