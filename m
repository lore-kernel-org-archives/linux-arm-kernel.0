From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu,  4 Jan 2018 13:10:04 +0200
Subject: [PATCH v2 00/11] clk: qcom: CPU clock driver for msm8996
Message-ID: <1515064215-22202-1-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[v2]
 * Addressed comments from Rob Herring for bindings
 * Addressed comments from Mark Rutland for memory barrier
 * Addressed comments from Julien Thierry for clock reenabling condition
 * Tuned the HW configuration for clock frequencies below 600MHz

This series adds support for the CPU clocks on msm8996 devices.
A previous post of RFC can be found here
https://patchwork.kernel.org/patch/10106867/

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

Taniya Das (1):
  clk: qcom: Fix .set_rate to handle alpha PLLs w/wo dynamic update

 .../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +
 arch/arm64/Kconfig.platforms                       |   7 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 282 ++++++++++-
 drivers/clk/qcom/Kconfig                           |   8 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  73 ++-
 drivers/clk/qcom/clk-alpha-pll.h                   |   5 +
 drivers/clk/qcom/clk-cpu-8996.c                    | 543 +++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/perf/qcom_l2_pmu.c                         |  48 +-
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/kryo-l2-accessors.c               |  64 +++
 include/soc/qcom/kryo-l2-accessors.h               |  22 +
 14 files changed, 1006 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
 create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
 create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

-- 
1.9.1
