From: davidb@codeaurora.org (David Brown)
Date: Fri, 20 Dec 2013 11:09:13 -0800
Subject: [PATCH 0/7] MSM patches for 3.14
Message-ID: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series contains a warning fix, a bit of cleanup, adds a
few more boards.  There are still numerous patches floating with
issues, but things seem to be moving in the right direction.

These have all been sent previously to the lists, and received reviews
and necessary acks.

Josh Cartwright (1):
  ARM: msm: trout: fix uninit var warning

Rohit Vaswani (2):
  ARM: msm: Add support for APQ8074 Dragonboard
  defconfig: msm_defconfig: Enable CONFIG_ARCH_MSM8974

Stephen Boyd (4):
  ARM: msm: Simplify ARCH_MSM_DT config
  ARM: dts: MSM8974: Add restart node
  ARM: dts: MSM8974: Add MMIO architected timer node
  ARM: msm_defconfig: Enable restart driver

 arch/arm/boot/dts/Makefile                     |  3 +-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts |  6 ++
 arch/arm/boot/dts/qcom-msm8974.dtsi            | 97 ++++++++++++++++++++++++++
 arch/arm/configs/msm_defconfig                 |  3 +
 arch/arm/mach-msm/Kconfig                      | 15 +++-
 arch/arm/mach-msm/board-dt.c                   |  9 +++
 arch/arm/mach-msm/board-trout.c                | 12 ++--
 7 files changed, 136 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8974.dtsi

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
