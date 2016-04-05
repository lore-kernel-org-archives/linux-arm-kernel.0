From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:41 -0600
Subject: [PATCH 00/11] coresight: next v4.6-rc2 
Message-ID: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

I would appreciate if you could consider this set for inclusion
in the 4.7 cycle - it applies cleanly on your current 'char-misc-next'.

More patches are to be expected in the coming weeks.

Regards,
Mathieu

Mathieu Poirier (11):
  coresight: etm4x: moving sysFS entries to a dedicated file
  coresight: etm4x: adding config and traceid registers
  coresight: etm4x: splitting struct etmv4_drvdata
  coresight: etm4x: splitting etmv4 default configuration
  coresight: etm4x: unlocking tracers in default arch init
  coresight: etm4x: moving etm_drvdata::enable to atomic field
  coresight: etm4x: implementing user/kernel mode tracing
  coresight: etm4x: implementing the perf PMU API
  coresight: moving coresight_simple_func() to header file
  coresight: etb10: splitting sysFS "status" entry
  coresight: removing gratuitous boot time log messages

 .../ABI/testing/sysfs-bus-coresight-devices-etb10  |   69 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |   13 +
 drivers/hwtracing/coresight/Makefile               |    8 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |   82 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   33 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 2126 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.c      | 2475 +++-----------------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  222 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |    1 -
 drivers/hwtracing/coresight/coresight-priv.h       |   10 +
 drivers/hwtracing/coresight/coresight-replicator.c |    1 -
 drivers/hwtracing/coresight/coresight-tmc.c        |    1 -
 drivers/hwtracing/coresight/coresight-tpiu.c       |    1 -
 13 files changed, 2691 insertions(+), 2351 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c

-- 
2.1.4
