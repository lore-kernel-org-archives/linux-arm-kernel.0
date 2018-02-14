From: ilialin@codeaurora.org (Ilia Lin)
Date: Wed, 14 Feb 2018 15:59:42 +0200
Subject: [PATCH v3 00/10] clk: qcom: CPU clock driver for msm8996
Message-ID: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[v3]
 * Rebased on top of the latest PLL driver changes
 * Addressed comment from Rob Herring for bindings

This series adds support for the CPU clocks on msm8996 devices.

The driver uses the existing PLL drivers and is required
to control the CPU frequency scaling on the MSM8996.

A previous post of RFC can be found here
https://patchwork.kernel.org/patch/10144485/

Ilia Lin (6):
  soc: qcom: Separate kryo l2 accessors from PMU driver
  clk: qcom: Add DT bindings for CPU clock driver for msm8996
  clk: qcom: clk-cpu-8996: Prepare PLLs on probe
  clk: qcom: Add ACD path to CPU clock driver for msm8996
  DT: QCOM: Add cpufreq-dt to msm8996
  DT: QCOM: Add thermal mitigation to msm8996

Rajendra Nayak (4):
  clk: qcom: Make clk_alpha_pll_configure available to modules
  clk: qcom: Add CPU clock driver for msm8996
  clk: qcom: cpu-8996: Add support to switch to alternate PLL
  clk: qcom: cpu-8996: Add support to switch below 600Mhz

 .../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +
 arch/arm64/Kconfig.platforms                       |   7 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |   4 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 286 ++++++++++-
 drivers/clk/qcom/Kconfig                           |   8 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   1 +
 drivers/clk/qcom/clk-cpu-8996.c                    | 554 +++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/perf/qcom_l2_pmu.c                         |  50 +-
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/kryo-l2-accessors.c               |  64 +++
 include/soc/qcom/kryo-l2-accessors.h               |  22 +
 14 files changed, 956 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
 create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
 create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

-- 
1.9.1
