From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 23 Dec 2014 20:44:33 +0900
Subject: [RFC PATCH 0/4] devfreq: Add generic exynos memory-bus frequency
 driver
Message-ID: <1419335077-31020-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patch-set adds the generic exynos bus frequency driver for memory bus
with DEVFREQ framework. The Samsung Exynos SoCs have the common architecture
for memory bus between DRAM memory and MMC/sub IP in SoC. This driver can
support the memory bus frequency driver for Exynos SoCs.

Each memory bus block has a clock for memory bus speed and frequency
table which is changed according to the utilization of memory bus on runtime.
And then each memory bus group has the one more memory bus blocks and
OPP table (including frequency and voltage), regulator, devfreq-event
devices.

There are a little difference about the number of memory bus because each Exynos
SoC have the different sub-IP and different memory bus speed. In spite of this
difference among Exynos SoCs, we can support almost Exynos SoC by adding
unique data of memory bus to devicetree file.

Chanwoo Choi (4):
  devfreq: exynos: Add generic exynos memory bus frequency driver
  devfreq: exynos: Add documentation for generic exynos memory bus frequency driver
  ARM: dts: Add memory bus node for Exynos3250
  ARM: dts: Add memory bus node for Exynos3250-based Rinato board

 .../devicetree/bindings/devfreq/exynos-busfreq.txt | 184 +++++++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  12 +
 arch/arm/boot/dts/exynos3250.dtsi                  | 137 +++++
 drivers/devfreq/Kconfig                            |  15 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/exynos-busfreq.c                   | 586 +++++++++++++++++++++
 6 files changed, 935 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-busfreq.txt
 create mode 100644 drivers/devfreq/exynos-busfreq.c

-- 
1.8.5.5
