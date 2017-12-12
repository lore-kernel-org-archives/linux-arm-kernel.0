From: ilialin@codeaurora.org (Ilia Lin)
Date: Tue, 12 Dec 2017 14:31:27 +0200
Subject: [PATCH 00/10] clk: qcom: CPU clock driver for msm8996
Message-ID: <1513081897-31612-1-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the CPU clocks on msm8996 devices.
A previous post of RFC can be found here
https://patchwork.kernel.org/patch/9662917/

Ilia Lin (5):
  soc: qcom: Separate kryo l2 accessors from PMU driver
  clk: qcom: clk-cpu-8996: Prepare PLLs on probe
  clk: qcom: Add ACD path to CPU clock driver for msm8996
  DT: QCOM: Add cpufreq-dt to msm8996
  DT: QCOM: Add thermal mitigation to msm8996

Rajendra Nayak (4):
  clk: qcom: Make clk_alpha_pll_configure available to modules
  clk: qcom: Add CPU clock driver for msm8996
  clk: qcom: cpu-8996: Add support to switch to alternate PLL
  clk: qcom: cpu-8996: Add support to switch below 600Mhz

Taniya Das (1):
  clk: qcom: Fix .set_rate to handle alpha PLLs w/wo dynamic update

 .../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +
 arch/arm64/Kconfig.platforms                       |   7 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 282 ++++++++++-
 drivers/clk/qcom/Kconfig                           |   8 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  72 ++-
 drivers/clk/qcom/clk-alpha-pll.h                   |   5 +
 drivers/clk/qcom/clk-cpu-8996.c                    | 542 +++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/perf/qcom_l2_pmu.c                         |  48 +-
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/kryo-l2-accessors.c               |  64 +++
 include/soc/qcom/kryo-l2-accessors.h               |  27 +
 14 files changed, 1009 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
 create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
 create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

-- 
1.9.1
