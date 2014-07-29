From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Jul 2014 15:05:38 +0100
Subject: [PATCH 0/5] irqchip: New driver for ST's SysCfg controlled IRQs
Message-ID: <1406642744-22589-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver enabled IRQs which are controlled using System Configuration
registers.  Without it Performance Monitoring, Core Sight Tracing and some
L2 Caches will fail to function.

Lee Jones (5):
  irqchip: Supply new driver for STi based devices
  irqchip: irq-st: Add documentation for STi based syscfg IRQs
  ARM: STi: STiH416: Enable Cortex-A9 PMU support
  ARM: STi: STiH416: Enable PMU IRQs
  ARM: STI: Ensure requested STi's SysCfg Controlled IRQs are enabled at boot

 .../interrupt-controller/st,sti-irq-syscfg.txt     |  35 ++++
 arch/arm/boot/dts/stih416.dtsi                     |  16 ++
 arch/arm/mach-sti/Kconfig                          |   1 +
 drivers/irqchip/Kconfig                            |   7 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-st.c                           | 204 +++++++++++++++++++++
 6 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
 create mode 100644 drivers/irqchip/irq-st.c

-- 
1.9.1
