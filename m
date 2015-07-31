From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 31 Jul 2015 09:37:20 -0600
Subject: [PATCH 00/10] coresight: next v4.2-rc4
Message-ID: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good day Greg, 

Those are the latest coresight enhancement for the 4.3 cycle.  Please consider
for inclusion.

Thanks,
Mathieu

Chunyan Zhang (5):
  coresight-etm3x: Change the name of the ctxid_val to ctxid_pid
  coresight-etm4x: Change the name of the ctxid_val to ctxid_pid
  Coresight: Add an interface for supporting ETM3/4 Context ID tracing
  coresight-etm3x: Support context-ID tracing when PID namespace is
    enabled
  coresight-etm4x: Support context-ID tracing when PID namespace is
    enabled

Ivan T. Ivanov (1):
  coresight-etm3x: Add Qualcomm PTM v1.1 peripheral ID

Mark Brown (1):
  coresight: Fix implicit inclusion of linux/sched.h

Masanari Iida (1):
  Doc: trace: Fix typo in coresight.txt

Mathieu Poirier (1):
  coresight: binding for ETMv4 coresight drivers

Vaishali Thakkar (1):
  coresight: replicator: Use builtin_platform_driver()

 .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |  2 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |  2 +-
 .../devicetree/bindings/arm/coresight.txt          |  1 +
 Documentation/trace/coresight.txt                  |  4 +--
 drivers/hwtracing/coresight/coresight-etm.h        |  7 ++--
 drivers/hwtracing/coresight/coresight-etm3x.c      | 33 ++++++++++++-------
 drivers/hwtracing/coresight/coresight-etm4x.c      | 37 ++++++++++++++--------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  7 ++--
 drivers/hwtracing/coresight/coresight-replicator.c | 13 +-------
 include/linux/coresight.h                          | 21 ++++++++++++
 10 files changed, 82 insertions(+), 45 deletions(-)

-- 
1.9.1
