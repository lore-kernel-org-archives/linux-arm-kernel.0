From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Jun 2017 14:15:01 -0600
Subject: [PATCH 00/17] coresight: next v4.12-rc4 
Message-ID: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Please consider for inclusion in the 4.13 cycle.  Of particular interest is
patch 15/17, which adds a new driver under the CoreSight umbrella.
Everything applies cleanly on today's char-misc-next branch (73726380a26f).

Regards,
Mathieu

Leo Yan (10):
  coresight: tmc: minor fix for output log
  coresight: use const for device_node structures
  coresight: bindings for CPU debug module
  doc: Add documentation for Coresight CPU debug
  doc: Add coresight_cpu_debug.enable to kernel-parameters.txt
  MAINTAINERS: update file entries for Coresight subsystem
  coresight: refactor with function of_coresight_get_cpu
  coresight: add support for CPU debug module
  arm64: dts: hi6220: register debug module
  arm64: dts: qcom: msm8916: Add debug unit

Markus Elfring (2):
  coresight: etb10: Delete an error message for a failed memory
    allocation in etb_probe()
  coresight: etb10: Fix a typo in a comment line

Robin Murphy (1):
  coresight: tmc: Configure DMA mask appropriately

Suzuki K Poulose (4):
  coresight: Disable the path only when the source is disabled
  coresight: Fix reference count for software sources
  coresight: etm_perf: Fix using uninitialised work
  coresight: of_get_coresight_platform_data: Add missing of_node_put

 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 .../bindings/arm/coresight-cpu-debug.txt           |  49 ++
 Documentation/trace/coresight-cpu-debug.txt        | 175 ++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  64 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  32 +
 drivers/hwtracing/coresight/Kconfig                |  14 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  | 700 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etb10.c      |   7 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   3 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  25 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |   7 +
 drivers/hwtracing/coresight/coresight.c            |  34 +-
 drivers/hwtracing/coresight/of_coresight.c         |  47 +-
 include/linux/coresight.h                          |  10 +-
 16 files changed, 1136 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 create mode 100644 Documentation/trace/coresight-cpu-debug.txt
 create mode 100644 drivers/hwtracing/coresight/coresight-cpu-debug.c

-- 
2.7.4
