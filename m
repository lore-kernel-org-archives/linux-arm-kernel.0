From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  4 Apr 2014 11:45:32 -0700
Subject: [PATCH 0/4] Support qcom GDSC hardware
Message-ID: <1396637136-29974-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the multimedia GDSCs on the
apq8074 dragonboard. The first two patches (and potentially the last)
should go through Mike's tree and the DTS patch should go through
the qcom tree. Patches are based on v3.14. The probe will conflict with
patches I sent to consolidate things. I'll rework these patches on top of
that if the gdsc.c file is acked/reviewed.

Stephen Boyd (4):
  clk: qcom: Add support for GDSCs
  clk: qcom: Add GDSCs within 8974 multimedia clock controller
  ARM: dts: qcom: Add GDSC nodes underneath clock controller
  devicetree: bindings: qcom,mmcc: Document GDSC binding

 .../devicetree/bindings/clock/qcom,mmcc.txt        |  42 +++
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |  18 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  26 ++
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/gdsc.c                            | 361 +++++++++++++++++++++
 drivers/clk/qcom/gdsc.h                            |  32 ++
 drivers/clk/qcom/mmcc-msm8974.c                    |  86 ++++-
 7 files changed, 564 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/gdsc.c
 create mode 100644 drivers/clk/qcom/gdsc.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
