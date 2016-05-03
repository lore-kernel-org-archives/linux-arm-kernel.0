From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  3 May 2016 11:33:34 -0600
Subject: [PATCH 00/27] coresight: next v4.6-rc6 
Message-ID: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning Greg,

Here's the other wave of CoreSight enhancement that I would like
so see going in for the 4.7 cycle.  The set applies cleanly on your
current 'char-misc-next' (0a19f129d71f) branch. 

Get back to me if you have any concerns.

Thanks,
Mathieu

Alexander Shishkin (1):
  stm class: Support devices that override software assigned masters

Mathieu Poirier (22):
  coresight: adding path for STM device
  coresight: stm: Bindings for System Trace Macrocell
  coresight: etb10: fixing the right amount of words to read
  coresight: tmc: adding sysFS management entries
  coresight: tmc: modifying naming convention
  coresight: tmc: waiting for TMCReady bit before programming
  coresight: tmc: re-implementing tmc_read_prepare/unprepare() functions
  coresight: tmc: clearly define number of transfers per burst
  coresight: tmc: introducing new header file
  coresight: tmc: cleaning up header file
  coresight: tmc: splitting driver in ETB/ETF and ETR components
  coresight: tmc: making prepare/unprepare functions generic
  coresight: tmc: allocating memory when needed
  coresight: tmc: getting rid of multiple read access
  coresight: tmc: adding mode of operation for link/sinks
  coresight: tmc: dump system memory content only when needed
  coresight: tmc: make sysFS and Perf mode mutually exclusive
  coresight: tmc: keep track of memory width
  coresight: moving struct cs_buffers to header file
  coresight: tmc: implementing TMC-ETF AUX space API
  coresight: configuring ETF in FIFO mode when acting as link
  coresight: etb10: adjust read pointer only when needed

Pratik Patel (1):
  coresight: stm: adding driver for CoreSight STM component

lipengcheng (3):
  coresight: no need to do the forced type conversion
  coresight: etm4x: modify q_support type
  coresight: etm4x: add tracer ID for A72 Maia processor.

 .../ABI/testing/sysfs-bus-coresight-devices-stm    |  53 ++
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  77 ++
 Documentation/ABI/testing/sysfs-class-stm          |  10 +
 .../devicetree/bindings/arm/coresight.txt          |  28 +
 Documentation/trace/coresight.txt                  |  37 +-
 drivers/hwtracing/coresight/Kconfig                |  11 +
 drivers/hwtracing/coresight/Makefile               |   5 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |  25 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   5 +
 drivers/hwtracing/coresight/coresight-etm4x.h      |   2 +-
 drivers/hwtracing/coresight/coresight-priv.h       |  20 +
 drivers/hwtracing/coresight/coresight-stm.c        | 920 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etf.c    | 604 ++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 329 ++++++++
 drivers/hwtracing/coresight/coresight-tmc.c        | 603 +++-----------
 drivers/hwtracing/coresight/coresight-tmc.h        | 140 ++++
 drivers/hwtracing/coresight/coresight.c            | 142 +++-
 drivers/hwtracing/stm/core.c                       |  15 +
 include/linux/coresight-stm.h                      |   6 +
 include/linux/stm.h                                |   3 +
 include/uapi/linux/coresight-stm.h                 |  21 +
 21 files changed, 2513 insertions(+), 543 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
 create mode 100644 drivers/hwtracing/coresight/coresight-stm.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc.h
 create mode 100644 include/linux/coresight-stm.h
 create mode 100644 include/uapi/linux/coresight-stm.h

-- 
2.5.0
