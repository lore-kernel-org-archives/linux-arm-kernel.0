From: ilialin@codeaurora.org (Ilia Lin)
Date: Thu, 24 May 2018 10:50:10 +0300
Subject: [PATCH v12 0/8] Clock for CPU scaling support for msm8996
Message-ID: <1527148218-16540-1-git-send-email-ilialin@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[v12]
 * Addressed the kbuild fail on arm architecture

[v11]
 * Split the series into domains

[v9]
 * Addressed comments from Viresh and Russel about the error handling

[v8]
 * Reordered the patch series into 4 groups
 * Addressed comments from Amit about the comments and commit messages
 * Addressed comments from Amit and Viresh about the resourses deallocation

[v7]
 * Addressed comments from Viresh about resourses deallocation
   and DT compatible

[v6]
 * Addressed comments from Viresh about:
 ** Comments style
 ** Kconfig bool instead of tristate
 ** DT and documentation style
 ** Resourses deallocation on an error
 ** Typos

[v5]
 * Rebased
 * Addressed comments from Bjorn about SPDX style,
   functions and parameters naming
 * Addressed comments from Viresh DT properties and style, comments style,
   resourses deallocation, documentation placement
 * Addressed comments from Sricharan about unnessesary include
 * Addressed comments from Nicolas
 * Addressed comments from Rob about the commit messages and acks
 * Addressed comments from Mark

[v4]
 * Adressed all comments from Stephen
 * Added CPU regulator support
 * Added qcom-cpufreq-kryo driver

[v3]
 * Rebased on top of the latest PLL driver changes
 * Addressed comment from Rob Herring for bindings

[v2]
 * Addressed comments from Rob Herring for bindings
 * Addressed comments from Mark Rutland for memory barrier
 * Addressed comments from Julien Thierry for clock reenabling condition
 * Tuned the HW configuration for clock frequencies below 600MHz

SOC (1/15):
Extracts the kryo l2 accessors driver from the QCOM PMU driver

Clocks (2/15-9/15):
This series adds support for the CPU clocks on msm8996 devices.
The driver uses the existing PLL drivers and is required to control
the CPU frequency scaling on the MSM8996.

Ilia Lin (6):
  soc: qcom: Separate kryo l2 accessors from PMU driver
  clk: Use devm_ in the register fixed factor clock
  clk: qcom: Add CPU clock driver for msm8996
  dt-bindings: clk: qcom: Add bindings for CPU clock for msm8996
  clk: qcom: cpu-8996: Add support to switch below 600Mhz
  clk: qcom: Add ACD path to CPU clock driver for msm8996

Rajendra Nayak (2):
  clk: qcom: Make clk_alpha_pll_configure available to modules
  clk: qcom: cpu-8996: Add support to switch to alternate PLL

 .../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +
 drivers/clk/clk-fixed-factor.c                     |   2 +-
 drivers/clk/qcom/Kconfig                           |  10 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   1 +
 drivers/clk/qcom/clk-alpha-pll.h                   |   6 +
 drivers/clk/qcom/clk-cpu-8996.c                    | 510 +++++++++++++++++++++
 drivers/perf/Kconfig                               |   1 +
 drivers/perf/qcom_l2_pmu.c                         |  90 +---
 drivers/soc/qcom/Kconfig                           |   3 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/kryo-l2-accessors.c               |  56 +++
 include/soc/qcom/kryo-l2-accessors.h               |  12 +
 13 files changed, 643 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
 create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
 create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

-- 
1.9.1
