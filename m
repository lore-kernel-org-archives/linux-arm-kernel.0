From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Mar 2015 14:13:33 -0600
Subject: [PATCH 0/8] coresight: next 4.0-rc6
Message-ID: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg, 

Please consider the following set for inclusion in your tree.  It has a 
respin on the patches I asked you to drop [1], which allows [2] to apply
correctly.  The latter has also been included herein to keep things
together.

Thanks,
Mathieu

[1]. http://lkml.iu.edu/hypermail/linux/kernel/1503.2/04095.html
[2]. http://lkml.iu.edu/hypermail/linux/kernel/1503.2/04716.html

Kaixu Xia (1):
  coresight: remove the unnecessary configuration coresight-default-sink

Mathieu Poirier (6):
  coresight: making cpu index lookup arm64 compliant
  coresight: fixing compilation warnings picked up by 64bit compiler
  coresight: Adding coresight support for arm64 architecture
  coresight: Correcting documentation typographical error
  coresight-tmc: Adding a status interface to sysfs
  coresight: moving to new "hwtracing" directory

Xia Kaixu (1):
  coresight: adding the LINKSINK block as a sink type

 .../devicetree/bindings/arm/coresight.txt          |  1 -
 Documentation/trace/coresight.txt                  |  2 +-
 MAINTAINERS                                        |  2 +-
 arch/arm/Kconfig.debug                             | 55 +------------------
 arch/arm/boot/dts/hip04.dtsi                       |  1 -
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  1 -
 arch/arm/boot/dts/omap3-beagle.dts                 |  1 -
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  1 -
 arch/arm64/Kconfig.debug                           |  2 +
 drivers/Makefile                                   |  2 +-
 drivers/hwtracing/coresight/Kconfig                | 61 ++++++++++++++++++++++
 drivers/{ => hwtracing}/coresight/Makefile         |  0
 .../{ => hwtracing}/coresight/coresight-etb10.c    |  4 +-
 .../{ => hwtracing}/coresight/coresight-etm-cp14.c |  0
 drivers/{ => hwtracing}/coresight/coresight-etm.h  |  0
 .../{ => hwtracing}/coresight/coresight-etm3x.c    |  0
 .../{ => hwtracing}/coresight/coresight-funnel.c   |  0
 drivers/{ => hwtracing}/coresight/coresight-priv.h |  0
 .../coresight/coresight-replicator.c               |  0
 drivers/{ => hwtracing}/coresight/coresight-tmc.c  | 60 ++++++++++++++++++++-
 drivers/{ => hwtracing}/coresight/coresight-tpiu.c |  0
 drivers/{ => hwtracing}/coresight/coresight.c      |  4 +-
 drivers/{ => hwtracing}/coresight/of_coresight.c   | 18 +++----
 23 files changed, 136 insertions(+), 79 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/Kconfig
 rename drivers/{ => hwtracing}/coresight/Makefile (100%)
 rename drivers/{ => hwtracing}/coresight/coresight-etb10.c (99%)
 rename drivers/{ => hwtracing}/coresight/coresight-etm-cp14.c (100%)
 rename drivers/{ => hwtracing}/coresight/coresight-etm.h (100%)
 rename drivers/{ => hwtracing}/coresight/coresight-etm3x.c (100%)
 rename drivers/{ => hwtracing}/coresight/coresight-funnel.c (100%)
 rename drivers/{ => hwtracing}/coresight/coresight-priv.h (100%)
 rename drivers/{ => hwtracing}/coresight/coresight-replicator.c (100%)
 rename drivers/{ => hwtracing}/coresight/coresight-tmc.c (91%)
 rename drivers/{ => hwtracing}/coresight/coresight-tpiu.c (100%)
 rename drivers/{ => hwtracing}/coresight/coresight.c (99%)
 rename drivers/{ => hwtracing}/coresight/of_coresight.c (94%)

-- 
1.9.1
