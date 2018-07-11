From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 11 Jul 2018 13:40:10 -0600
Subject: [PATCH 00/25] coresight: next v4.18-rc4
Message-ID: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg, 

These are the patches I've rounded up for inclusion in the v4.19 cycle.  Applies
cleanly on your char-mist/next branch.

Thanks,
Mathieu

Arnd Bergmann (1):
  coresight: include vmalloc.h for vmap/vunmap

Mathieu Poirier (3):
  coresight: etm3x: Don't use contextID with PID namespaces
  coresight: etm4x: Don't use contextID with PID namespaces
  coresight: Remove function coresight_vpid_to_pid()

Robin Murphy (1):
  coresight: tpiu: Fix disabling timeouts

Suzuki K Poulose (20):
  coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35
  coresight: tmc: Hide trace buffer handling for file read
  coresight: tmc-etr: Do not clean trace buffer
  coresight: tmc-etr: Disallow perf mode
  coresight: Add helper for inserting synchronization packets
  dts: bindings: Restrict coresight tmc-etr scatter-gather mode
  coresight: Add generic TMC sg table framework
  coresight: Add support for TMC ETR SG unit
  coresight: tmc-etr: Add transparent buffer management
  coresight: tmc-etr buf: Add TMC scatter gather mode backend
  coresight: tmc: Add configuration support for trace buffer size
  coresight: Fix check in coresight_tmc_etr_buf_insert_barrier_packet
  coresight: Cleanup platform description data
  coresight: Handle errors in finding input/output ports
  coresight: Cleanup device subtype struct
  coresight: Add helper device type
  coresight: Introduce support for Coresight Address Translation Unit
  dts: bindings: Document device tree binding for CATU
  coresight: catu: Add support for scatter gather tables
  coresight: catu: Plug in CATU as a backend for ETR buffer

 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |    8 +
 .../devicetree/bindings/arm/coresight.txt          |   58 +-
 drivers/hwtracing/coresight/Kconfig                |   11 +
 drivers/hwtracing/coresight/Makefile               |    1 +
 drivers/hwtracing/coresight/coresight-catu.c       |  577 +++++++++++
 drivers/hwtracing/coresight/coresight-catu.h       |  119 +++
 drivers/hwtracing/coresight/coresight-etb10.c      |   12 +-
 drivers/hwtracing/coresight/coresight-etm.h        |    3 -
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   43 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |    4 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   47 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   31 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |    3 -
 drivers/hwtracing/coresight/coresight-priv.h       |   10 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   45 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 1074 ++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.c        |   83 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |  113 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |    7 +-
 drivers/hwtracing/coresight/coresight.c            |   53 +-
 include/linux/coresight.h                          |   68 +-
 21 files changed, 2135 insertions(+), 235 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.c
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.h

-- 
2.7.4
