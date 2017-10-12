From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Oct 2017 13:30:31 +0100
Subject: [PATCH v6 0/7] Add support for the ARMv8.2 Statistical Profiling
 Extension
Message-ID: <1507811438-2267-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the 8th posting of the patches previously posted here:

  rfcv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476450.html
  rfcv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/479387.html
     v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/483684.html
     v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/499938.html
     v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507132.html
     v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/510799.html
     v5: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-September/533478.html

The only change since v5 is the addition of Acked-by tags, so I'd like to
queue this soon.

The architecture documentation is available here:

  https://developer.arm.com/products/architecture/a-profile/docs/ddi0586/latest/arm-architecture-reference-manual-supplement-statistical-profiling-extension-for-armv8-a

and there's a high-level overview on this official ARM blog:

  https://community.arm.com/processors/b/blog/posts/statistical-profiling-extension-for-armv8-a

Cheers,

Will

--->8

Will Deacon (7):
  genirq: export irq_get_percpu_devid_partition to modules
  perf/core: Export AUX buffer helpers to modules
  perf/core: Add PERF_AUX_FLAG_COLLISION to report colliding samples
  arm64: sysreg: Move SPE registers and PSB into common header files
  arm64: head: Init PMSCR_EL2.{PA,PCT} when entered at EL2 without VHE
  dt-bindings: Document devicetree binding for ARM SPE
  drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension

 Documentation/devicetree/bindings/arm/spe-pmu.txt |   20 +
 arch/arm64/include/asm/barrier.h                  |    2 +
 arch/arm64/include/asm/sysreg.h                   |   93 ++
 arch/arm64/kernel/head.S                          |   17 +-
 arch/arm64/kvm/hyp/debug-sr.c                     |   24 +-
 drivers/perf/Kconfig                              |    8 +
 drivers/perf/Makefile                             |    1 +
 drivers/perf/arm_spe_pmu.c                        | 1246 +++++++++++++++++++++
 include/uapi/linux/perf_event.h                   |    1 +
 kernel/events/ring_buffer.c                       |    4 +
 kernel/irq/irqdesc.c                              |    1 +
 11 files changed, 1395 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 drivers/perf/arm_spe_pmu.c

-- 
2.1.4
