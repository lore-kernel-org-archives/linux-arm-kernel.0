From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 30 Jun 2016 10:22:06 -0600
Subject: [PATCH 00/13] coresight: next v4.7-rc5 
Message-ID: <1467303739-12543-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good day,

Please consider these patches for inclusion in the 4.8 cycle.  They
apply cleanly on your 'char-misc-next' branch (e2402b1d214e).

Regards,
Mathieu

Chunyan Zhang (1):
  coresight-stm: support mmapping channel regions with mmio_addr

Mathieu Poirier (3):
  coresight: delay initialisation when children are missing
  coresight: document binding acronyms
  coresight: add PM runtime calls to coresight_simple_func()

Sudeep Holla (2):
  coresight: access conn->child_name only if it's initialised
  coresight: always use stashed trace id value in etm4_trace_id

Suzuki K Poulose (7):
  coresight: Remove erroneous dma_free_coherent in tmc_probe
  coresight: Consolidate error handling path for tmc_probe
  coresight: Fix csdev connections initialisation
  coresight: tmc: Limit the trace to available data
  coresight: etmv4: Fix ETMv4x peripheral ID table
  coresight: Cleanup TMC status check
  coresight: Add better messages for coresight_timeout

 .../devicetree/bindings/arm/coresight.txt          | 35 +++++++++++----
 drivers/hwtracing/coresight/coresight-etb10.c      |  6 +--
 drivers/hwtracing/coresight/coresight-etm4x.c      | 30 +++----------
 drivers/hwtracing/coresight/coresight-priv.h       |  8 +++-
 drivers/hwtracing/coresight/coresight-stm.c        | 22 ++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  2 +
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 12 +++--
 drivers/hwtracing/coresight/coresight-tmc.c        | 51 ++++++++++------------
 drivers/hwtracing/coresight/coresight-tmc.h        |  4 +-
 drivers/hwtracing/coresight/coresight.c            | 27 +++++++-----
 drivers/hwtracing/coresight/of_coresight.c         |  2 +-
 11 files changed, 117 insertions(+), 82 deletions(-)

-- 
2.7.4
