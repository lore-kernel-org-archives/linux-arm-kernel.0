From: robherring2@gmail.com (Rob Herring)
Date: Tue,  7 Jun 2011 09:22:18 -0500
Subject: [PATCH v2 0/3] DT bindings for Cortex A9 peripherals
Message-ID: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series adds DT based initialization and bindings for the pmu, gic and l2x0
found on Cortex-A9's.

Changes from v1:
- Added binding documentation
- fixed checkpatch errors in gic.c and cache-l2x0.c

Rob

Rob Herring (3):
  ARM: pmu: add OF probing support
  ARM: gic: add OF based initialization
  ARM: l2x0: Add OF based initialization

 Documentation/devicetree/bindings/arm/gic.txt  |   31 +++++++++++++++++++
 Documentation/devicetree/bindings/arm/l2cc.txt |   35 ++++++++++++++++++++++
 Documentation/devicetree/bindings/arm/pmu.txt  |   22 ++++++++++++++
 arch/arm/common/gic.c                          |   36 ++++++++++++++++++++++
 arch/arm/include/asm/hardware/cache-l2x0.h     |    1 +
 arch/arm/include/asm/hardware/gic.h            |    1 +
 arch/arm/kernel/pmu.c                          |   23 +++++++++++---
 arch/arm/mm/cache-l2x0.c                       |   38 ++++++++++++++++++++++++
 8 files changed, 182 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/l2cc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.txt

-- 
1.7.4.1
