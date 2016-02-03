From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed,  3 Feb 2016 16:10:24 +0800
Subject: [PATCH V2 0/6] Introduce CoreSight STM support
Message-ID: <1454487030-30053-1-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for CoreSight STM IP block. It also makes
a little modification to the generic STM framework to cover the
CoreSight STM requirements. Full description follows the changelog.

Changes from v1:
 - Added a definition of coresight_simple_func() in CS-STM driver to
   avoid the kbuild test robot error for the time being.  This
   modification will be removed when merging the code in which the
   coresight_simple_func() has been moved to the header file.


Thanks,
Chunyan

Chunyan Zhang (3):
  stm class: Add ioctl get_options interface
  stm class: adds a loop to extract the first valid STM device name
  Documentations: Add explanations of the case for non-configurable
    masters

Mathieu Poirier (2):
  stm class: provision for statically assigned masterIDs
  coresight-stm: Bindings for System Trace Macrocell

Pratik Patel (1):
  coresight-stm: adding driver for CoreSight STM component

 .../ABI/testing/sysfs-bus-coresight-devices-stm    |  53 ++
 .../devicetree/bindings/arm/coresight.txt          |  28 +
 Documentation/trace/coresight.txt                  |  37 +-
 Documentation/trace/stm.txt                        |   6 +
 drivers/hwtracing/coresight/Kconfig                |  11 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-stm.c        | 972 +++++++++++++++++++++
 drivers/hwtracing/stm/core.c                       |  29 +-
 drivers/hwtracing/stm/policy.c                     |  46 +-
 include/linux/coresight-stm.h                      |   6 +
 include/linux/stm.h                                |  11 +
 include/uapi/linux/coresight-stm.h                 |  12 +
 include/uapi/linux/stm.h                           |   1 +
 13 files changed, 1196 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
 create mode 100644 drivers/hwtracing/coresight/coresight-stm.c
 create mode 100644 include/linux/coresight-stm.h
 create mode 100644 include/uapi/linux/coresight-stm.h

-- 
1.9.1
