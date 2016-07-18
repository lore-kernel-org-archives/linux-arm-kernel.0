From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Jul 2016 13:51:21 -0600
Subject: [PATCH 00/10] coresight: implementing address filtering 
Message-ID: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset builds on the generic address filtering framework
in the perf core to implement range and start/stop filters for
ARM CoreSight.

Most of the code is moving things around in order to provide an
environment where filters can be acquired from perf and then configured
in the CoreSight drivers.

The set is based on 4.7-rc7 and depends on these patches [1].

[1]. https://lkml.org/lkml/2016/7/18/457

Mathieu Poirier (10):
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
  coresight: documenting range and start/stop filtering

 Documentation/trace/coresight.txt                  |  48 +++
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 150 +++++++--
 drivers/hwtracing/coresight/coresight-etm-perf.h   |  32 ++
 drivers/hwtracing/coresight/coresight-etm.h        |   8 -
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   1 +
 drivers/hwtracing/coresight/coresight-etm3x.c      |  14 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   1 +
 drivers/hwtracing/coresight/coresight-etm4x.c      | 356 +++++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h      |   8 -
 drivers/hwtracing/coresight/coresight-priv.h       |   8 +
 drivers/hwtracing/coresight/coresight-stm.c        |   7 +-
 drivers/hwtracing/coresight/coresight.c            |   2 +-
 include/linux/coresight.h                          |   5 +-
 13 files changed, 530 insertions(+), 110 deletions(-)

-- 
2.7.4
