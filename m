From: pi-cheng.chen@linaro.org (pi-cheng.chen)
Date: Wed,  4 Mar 2015 16:49:12 +0800
Subject: [PATCH v2 0/4] cpufreq: add cpufreq driver for Mediatek MT8173 SoC
Message-ID: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 is a ARMv8 based SoC with 2 clusters. All CPUs in a single cluster
share the same power and clock domain. This series tries to add cpufreq support
for MT8173 SoC by using DT based cpufreq driver. 

>From v1 to v2:
1. Add intermediate frequency support in cpufreq-dt driver
2. Use voltage scaling code of cpufreq-dt for little cluster instead of
   implementaion in notifier of mtk-cpufreq driver
3. Code refinement for mtk-cpufreq driver

pi-cheng.chen (4):
  cpufreq-dt: add clock domain and intermediate frequency support
  cpufreq: dt-bindings: add bindings for mtk-cpufreq driver
  cpufreq: mediatek: add Mediatek cpufreq driver
  ARM64: dts: mediatek: add cpufreq dts for MT8173 SoC

 .../devicetree/bindings/cpufreq/cpufreq-mtk.txt    |  17 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  10 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  25 ++
 drivers/cpufreq/Kconfig.arm                        |   6 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt.c                       |  68 +++-
 drivers/cpufreq/mtk-cpufreq.c                      | 346 +++++++++++++++++++++
 include/linux/cpufreq-dt.h                         |   7 +
 8 files changed, 473 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mtk.txt
 create mode 100644 drivers/cpufreq/mtk-cpufreq.c

-- 
1.9.1
