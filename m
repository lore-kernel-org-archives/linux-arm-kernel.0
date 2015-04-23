From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 23 Apr 2015 19:16:06 +0530
Subject: [RFC 0/7] qcom: Add support for tsens driver
Message-ID: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an attempt to have a single tsens driver for
the different versions of the tsens IP that exist, on
different qcom msm/apq SoCs.
Support is added for msm8916, msm8960 and msm8974 families.
Based on top of the latest eeprom framework patches [1]

A lot of the work is based of original code from Stephen Boyd
and Siddartha Mohanadoss. I have also picked some of what
Narendran Rajan did in his attempt to upstream the support
for 8960 family. I could not keep the original authorship on
any of the patches because I ended up moving the code around
quite a bit in an effort to have a single driver for the
various devices. I would be glad to change the authorship
for any of the patches if needed.

[1] https://lwn.net/Articles/638565/

Rajendra Nayak (6):
  thermal: qcom: tsens: Add a skeletal tsens drivers
  thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
  thermal: qcom: tsens-8974: Add support for 8974 family of SoCs
  thermal: qcom: tsens-8960: Add support for 8960 family of SoCs
  arm: dts: msm8974: Add thermal zones, tsens and eeprom nodes
  arm: dts: apq8064: Add thermal zones, tsens and eeprom nodes

Srinivas Kandagatla (1):
  clk: qcom: gcc-msm8960: add child devices support.

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  36 +++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 108 +++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                | 105 +++++++
 drivers/clk/qcom/gcc-msm8960.c                     |   4 +-
 drivers/thermal/Kconfig                            |   5 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qcom/Kconfig                       |  10 +
 drivers/thermal/qcom/Makefile                      |   2 +
 drivers/thermal/qcom/tsens-8916.c                  | 107 +++++++
 drivers/thermal/qcom/tsens-8960.c                  | 336 +++++++++++++++++++++
 drivers/thermal/qcom/tsens-8974.c                  | 239 +++++++++++++++
 drivers/thermal/qcom/tsens-common.c                | 128 ++++++++
 drivers/thermal/qcom/tsens.c                       | 209 +++++++++++++
 drivers/thermal/qcom/tsens.h                       |  69 +++++
 14 files changed, 1358 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 drivers/thermal/qcom/Kconfig
 create mode 100644 drivers/thermal/qcom/Makefile
 create mode 100644 drivers/thermal/qcom/tsens-8916.c
 create mode 100644 drivers/thermal/qcom/tsens-8960.c
 create mode 100644 drivers/thermal/qcom/tsens-8974.c
 create mode 100644 drivers/thermal/qcom/tsens-common.c
 create mode 100644 drivers/thermal/qcom/tsens.c
 create mode 100644 drivers/thermal/qcom/tsens.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
