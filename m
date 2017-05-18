From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 May 2017 18:24:28 +0100
Subject: [PATCH v3 0/5] Add support for the ARMv8.2 Statistical Profiling
 Extension
Message-ID: <1495128273-13941-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the fifth posting of the patches previously posted here:

  rfcv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476450.html
  rfcv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/479387.html
     v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/483684.html
     v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/499938.html

Changes since v2 include:

  * Rebased onto v4.12-rc1, which includes some rework to AUX flag
    handling
  * Removed VHE-dependent exclude_hv support in light of recent change
    to CPU PMU code [1]

The architecture documentation is available here:

  https://developer.arm.com/products/architecture/a-profile/docs/ddi0586/latest/arm-architecture-reference-manual-supplement-statistical-profiling-extension-for-armv8-a

and there's a high-level overview on this official ARM blog:

  https://community.arm.com/processors/b/blog/posts/statistical-profiling-extension-for-armv8-a

All comments welcome,

Will

[1] http://lkml.kernel.org/r/1493742574-25955-1-git-send-email-ganapatrao.kulkarni at cavium.com

--->8

Will Deacon (5):
  genirq: export irq_get_percpu_devid_partition to modules
  perf/core: Export AUX buffer helpers to modules
  perf/core: Add PERF_AUX_FLAG_COLLISION to report colliding samples
  drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension
  dt-bindings: Document devicetree binding for ARM SPE

 Documentation/devicetree/bindings/arm/spe-pmu.txt |   20 +
 drivers/perf/Kconfig                              |    8 +
 drivers/perf/Makefile                             |    1 +
 drivers/perf/arm_spe_pmu.c                        | 1246 +++++++++++++++++++++
 include/uapi/linux/perf_event.h                   |    1 +
 kernel/events/ring_buffer.c                       |    4 +
 kernel/irq/irqdesc.c                              |    1 +
 7 files changed, 1281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 drivers/perf/arm_spe_pmu.c

-- 
2.1.4
