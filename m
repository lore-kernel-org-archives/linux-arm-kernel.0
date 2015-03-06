From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Mar 2015 11:54:07 +0000
Subject: [PATCH v3 0/4] Fix PMU interrupt affinity for Juno*
Message-ID: <1425642851-27450-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version three of the patches previously posted here:

  v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322251.html
  v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/326570.html

Changes since v2 include:

  - Split the binding docs out into a separate patch
  - Fixed failure path when we fail to find the logical CPU for an IRQ
  - Fixed of_node reference leak
  - Tidied up strings in error messages

Feedback welcome,

Will

--->8

Will Deacon (4):
  dt: pmu: extend ARM PMU binding to allow for explicit interrupt
    affinity
  ARM: pmu: add support for interrupt-affinity property
  arm64: pmu: add support for interrupt-affinity property
  arm64: dts: add interrupt-affinity property to pmu node for juno

 Documentation/devicetree/bindings/arm/pmu.txt |  7 +++
 arch/arm/include/asm/pmu.h                    |  1 +
 arch/arm/kernel/perf_event_cpu.c              | 69 ++++++++++++++++++++++++---
 arch/arm64/boot/dts/arm/juno.dts              | 14 ++++--
 arch/arm64/include/asm/pmu.h                  |  1 +
 arch/arm64/kernel/perf_event.c                | 57 ++++++++++++++++++++--
 6 files changed, 134 insertions(+), 15 deletions(-)

-- 
2.1.4
