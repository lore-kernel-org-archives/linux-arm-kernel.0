From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 17 Feb 2016 17:51:42 -0700
Subject: [PATCH 00/21] coresight: next v4.5-rc4
Message-ID: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good evening Greg,

Here are more enhancement that I would like to see going in the 4.6 cycle.
Everything will apply cleanly on your 'char-misc-next' branch.  

Thanks,
Mathieu

Eric Long (2):
  coresight: "DEVICE_ATTR_RO" should defined as static.
  coresight: etm4x: Check every parameter used by dma_xx_coherent.

Mathieu Poirier (18):
  coresight: associating path with session rather than tracer
  coresight: add API to get sink from path
  coresight: moving PM runtime operations to core framework
  coresight: etm3x: moving etm_readl/writel to header file
  coresight: etm3x: moving sysFS entries to dedicated file
  coresight: etm3x: unlocking tracers in default arch init
  coresight: etm3x: splitting struct etm_drvdata
  coresight: etm3x: adding operation mode for etm_enable()
  coresight: etm3x: set progbit to stop trace collection
  coresight: etm3x: changing default trace configuration
  coresight: etm3x: consolidating initial config
  coresight: etm3x: implementing user/kernel mode tracing
  coresight: etm3x: implementing perf_enable/disable() API
  coresight: etb10: moving to local atomic operations
  coresight: etb10: adding operation mode for sink->enable()
  coresight: etb10: implementing AUX API
  coresight: etm-perf: new PMU driver for ETM tracers
  coresight: introducing a global trace ID function

Paul Gortmaker (1):
  drivers/hwtracing: make coresight-* explicitly non-modular

 drivers/hwtracing/coresight/Kconfig                |    1 +
 drivers/hwtracing/coresight/Makefile               |    4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  282 +++-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  393 +++++
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   32 +
 drivers/hwtracing/coresight/coresight-etm.h        |  142 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 1272 +++++++++++++++
 drivers/hwtracing/coresight/coresight-etm3x.c      | 1724 ++++----------------
 drivers/hwtracing/coresight/coresight-etm4x.c      |   16 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   11 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   15 +
 .../coresight/coresight-replicator-qcom.c          |    8 +-
 drivers/hwtracing/coresight/coresight-replicator.c |    9 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |   20 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |   13 +-
 drivers/hwtracing/coresight/coresight.c            |  329 ++--
 drivers/hwtracing/coresight/of_coresight.c         |    3 +-
 include/linux/amba/bus.h                           |    9 +
 include/linux/coresight-pmu.h                      |   39 +
 include/linux/coresight.h                          |   31 +-
 20 files changed, 2740 insertions(+), 1613 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.h
 create mode 100644 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
 create mode 100644 include/linux/coresight-pmu.h

-- 
2.1.4
