From: will.deacon@arm.com (Will Deacon)
Date: Mon,  5 Jun 2017 16:22:52 +0100
Subject: [PATCH v4 0/5] Add support for the ARMv8.2 Statistical Profiling
 Extension
Message-ID: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the sixth posting of the patches previously posted here:

  rfcv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476450.html
  rfcv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/479387.html
     v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/483684.html
     v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/499938.html
     v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507132.html

The main change since v3 is that I have reworked and fixed the CPU hotplug
and notifier bits, in light of review comments from tglx.

The architecture documentation is available here:

  https://developer.arm.com/products/architecture/a-profile/docs/ddi0586/latest/arm-architecture-reference-manual-supplement-statistical-profiling-extension-for-armv8-a

and there's a high-level overview on this official ARM blog:

  https://community.arm.com/processors/b/blog/posts/statistical-profiling-extension-for-armv8-a

All comments welcome,

Will

Will Deacon (5):
  genirq: export irq_get_percpu_devid_partition to modules
  perf/core: Export AUX buffer helpers to modules
  perf/core: Add PERF_AUX_FLAG_COLLISION to report colliding samples
  drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension
  dt-bindings: Document devicetree binding for ARM SPE

 Documentation/devicetree/bindings/arm/spe-pmu.txt |   20 +
 drivers/perf/Kconfig                              |    8 +
 drivers/perf/Makefile                             |    1 +
 drivers/perf/arm_spe_pmu.c                        | 1243 +++++++++++++++++++++
 include/uapi/linux/perf_event.h                   |    1 +
 kernel/events/ring_buffer.c                       |    4 +
 kernel/irq/irqdesc.c                              |    1 +
 7 files changed, 1278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 drivers/perf/arm_spe_pmu.c

-- 
2.1.4
