From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 29 Feb 2016 11:54:19 -0700
Subject: [PATCH 0/8] coresight: etmv4: make driver usable by Perf
Message-ID: <1456772067-18085-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes the ETMv4 driver usable from Perf by way of the
recently added AUX area functionality.

The first 7 patches move code around to obtain a configuration
granularity suitable for Perf.  The last patch implement the AUX area
API.  Most of the code is made to resemble the work that was done on
ETMv3 as much as possible.

Best regards,
Mathieu 

Mathieu Poirier (8):
  coresight: etm4x: moving sysFS entries to a dedicated file
  coresight: etm4x: adding config and traceid registers
  coresight: etm4x: splitting struct etmv4_drvdata
  coresight: etm4x: splitting etmv4 default configuration
  coresight: etm4x: unlocking tracers in default arch init
  coresight: etm4x: moving etm_drvdata::enable to atomic field
  coresight: etm4x: implementing user/kernel mode tracing
  coresight: etm4x: implementing the perf PMU API

 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |   13 +
 drivers/hwtracing/coresight/Makefile               |    8 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 2133 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.c      | 2475 +++-----------------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  222 +-
 5 files changed, 2575 insertions(+), 2276 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c

-- 
2.1.4
