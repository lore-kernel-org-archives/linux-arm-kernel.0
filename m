From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 15:18:50 -0600
Subject: [PATCH 00/28] coresight: next v4.8-rc3 
Message-ID: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

These are a combination of the CoreSight subsystem patches tallied
during v4.7 cycle (that were not picked) and those for this cycle.
My hope is to see them all considered for the v4.9 cycle. 

Everything applies cleanly on your 'char-misc-next' branch
(4c73c0882b34).

With a little help from the universe there will be a few more.

Thanks,
Mathieu 

Chunyan Zhang (1):
  coresight-stm: support mmapping channel regions with mmio_addr

Markus Elfring (1):
  coresight: tmc: Delete an unnecessary check before the function call
    "kfree"

Mathieu Poirier (11):
  coresight: delay initialisation when children are missing
  coresight: add PM runtime calls to coresight_simple_func()
  coresight: etm-perf: pass struct perf_event to
    source::enable/disable()
  coresight: remove duplicated enumeration
  coresight: etm-perf: configuring filters from perf core
  coresight: etm4x: split default and filter configuration
  coresight: etm4x: cleaning up default filter configuration
  coresight: etm4x: adding range filter configuration function
  coresight: etm4x: configuring include/exclude function
  coresight: etm4x: adding configurable address range filtering
  coresight: etm4x: adding configurable start/stop filtering

Olivier Schonken (1):
  coresight-etm3x: Add ARM ETM 3.5 Cortex-A5 peripheral ID

Peter Chen (1):
  hwtracing: coresight: of_coresight: add missing of_node_put after
    calling of_parse_phandle

Sudeep Holla (4):
  coresight: access conn->child_name only if it's initialised
  coresight: always use stashed trace id value in etm4_trace_id
  coresight: etm4x: request to retain power to the trace unit when
    active
  coresight: fix handling of ETM trace register access via sysfs

Suzuki K Poulose (8):
  coresight: Remove erroneous dma_free_coherent in tmc_probe
  coresight: Consolidate error handling path for tmc_probe
  coresight: Fix csdev connections initialisation
  coresight: tmc: Limit the trace to available data
  coresight: etmv4: Fix ETMv4x peripheral ID table
  coresight: Cleanup TMC status check
  coresight: Add better messages for coresight_timeout
  coresight: Use local coresight_desc instances

Wei Yongjun (1):
  coresight: etm4x: remove duplicated include from coresight-etm4x.c

 drivers/hwtracing/coresight/coresight-etb10.c      |  28 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 153 +++++++-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |  34 ++
 drivers/hwtracing/coresight/coresight-etm.h        |   8 -
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   3 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |  39 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  63 +++-
 drivers/hwtracing/coresight/coresight-etm4x.c      | 419 ++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h      |  11 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |  20 +-
 drivers/hwtracing/coresight/coresight-priv.h       |  23 +-
 .../coresight/coresight-replicator-qcom.c          |  18 +-
 drivers/hwtracing/coresight/coresight-replicator.c |  20 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  53 ++-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  12 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  76 ++--
 drivers/hwtracing/coresight/coresight-tmc.h        |   4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |  18 +-
 drivers/hwtracing/coresight/coresight.c            |  29 +-
 drivers/hwtracing/coresight/of_coresight.c         |   3 +-
 include/linux/coresight.h                          |   5 +-
 22 files changed, 727 insertions(+), 316 deletions(-)

-- 
2.7.4
