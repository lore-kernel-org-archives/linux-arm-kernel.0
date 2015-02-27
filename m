From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 27 Feb 2015 16:04:49 -0700
Subject: [PATCH 0/5] coresight: next
Message-ID: <1425078294-13059-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are the latest coresight patches that I'd like you to consider for
inclusion in your tree.  The set is based on v4.0-rc1.

Thanks,
Mathieu

Mathieu Poirier (4):
  coresight: making cpu index lookup arm64 compliant
  coresight: fixing compilation warnings picked up by 64bit compiler
  coresight: Adding coresight support for arm64 architecture
  coresight-stm: Bindings for System Trace Macrocell

Pratik Patel (1):
  coresight-stm: adding driver for CoreSight STM component

 .../ABI/testing/sysfs-bus-coresight-devices-stm    |   62 ++
 .../devicetree/bindings/arm/coresight.txt          |   28 +
 Documentation/trace/coresight.txt                  |   88 +-
 arch/arm/Kconfig.debug                             |   55 +-
 arch/arm64/Kconfig.debug                           |    2 +
 drivers/coresight/Kconfig                          |   71 ++
 drivers/coresight/Makefile                         |    1 +
 drivers/coresight/coresight-etb10.c                |    4 +-
 drivers/coresight/coresight-stm.c                  | 1070 ++++++++++++++++++++
 drivers/coresight/coresight-tmc.c                  |    4 +-
 drivers/coresight/of_coresight.c                   |   18 +-
 include/linux/coresight-stm.h                      |   40 +
 include/uapi/linux/coresight-stm.h                 |   23 +
 13 files changed, 1394 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
 create mode 100644 drivers/coresight/Kconfig
 create mode 100644 drivers/coresight/coresight-stm.c
 create mode 100644 include/linux/coresight-stm.h
 create mode 100644 include/uapi/linux/coresight-stm.h

-- 
1.9.1
