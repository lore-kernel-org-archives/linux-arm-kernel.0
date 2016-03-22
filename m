From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:08 -0600
Subject: [PATCH 00/14] coresight: tmc: make driver usable by Perf 
Message-ID: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes the TMC driver usable from Perf by way of the
recently added AUX area functionality.

The first 11 patches remodel the driver so that the functionality
is compartmented enough to be used as building blocks when interfacing
with the Perf subsystem.

Path 12 and 13 implement the AUX area API, taking heavily on the existing
ETB10 implementation.

Finally patch 14 allows the TMC to be used as a link rather than a sink,
something that is required when dealing with an ETF component.

Best regards,
Mathieu

Mathieu Poirier (14):
  coresight: tmc: modifying naming convention
  coresight: tmc: waiting for TMCReady bit before programming
  coresight: tmc: re-implementing tmc_read_prepare/unprepare() functions
  coresight: tmc: introducing new header file
  coresight: tmc: splitting driver in ETB/ETF and ETR components
  coresight: tmc: making prepare/unprepare functions generic
  coresight: tmc: making disable function reusable
  coresight: tmc: allocating memory when needed
  coresight: tmc: adding mode of operation for link/sinks
  coresight: tmc: make sysFS and Perf mode mutually exclusive
  coresight: tmc: keep track of memory width
  coresight: tmc: implementing TMC-ETF AUX space API
  coresight: tmc: implementing TMC-ETR AUX space API
  coresight: configuring ETF in FIFO mode when acting as link

 drivers/hwtracing/coresight/Makefile            |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 606 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 470 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 447 ++---------------
 drivers/hwtracing/coresight/coresight-tmc.h     | 167 +++++++
 drivers/hwtracing/coresight/coresight.c         |  17 +-
 6 files changed, 1296 insertions(+), 415 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc.h

-- 
2.1.4
