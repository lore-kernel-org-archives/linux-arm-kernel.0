From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Thu,  3 Oct 2013 16:05:53 -0700
Subject: [PATCH 0/4]Re-organize DEBUG_UART for MSM and add support for MSM8974
Message-ID: <1380841557-2673-1-git-send-email-rvaswani@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a pre-cursor, this series cleans-up the DEBUG_UART configs for msm and
includes patches to add basic board support for MSM8974 and debug uart support
for it as well.
The debug uart patches will be added to Russell's patch tracker and hence were
separated from the MSM8974 patch.

Rohit Vaswani (4):
  ARM: debug: Create CONFIG_DEBUG_MSM_UART and re-organize the selects
    for MSM
  ARM: msm: Add support for APQ8074 Dragonboard
  ARM: debug: msm: Add DEBUG_LL support for ARCH_MSM8974
  defconfig: msm_defconfig: Enable CONFIG_ARCH_MSM8974

 arch/arm/Kconfig.debug                         | 24 ++++++++++++++----
 arch/arm/boot/dts/Makefile                     |  3 ++-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts |  6 +++++
 arch/arm/boot/dts/qcom-msm8974.dtsi            | 35 ++++++++++++++++++++++++++
 arch/arm/configs/msm_defconfig                 |  1 +
 arch/arm/include/debug/msm.S                   |  5 ++++
 arch/arm/mach-msm/Kconfig                      | 13 ++++++++++
 arch/arm/mach-msm/board-dt.c                   |  9 +++++++
 8 files changed, 90 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
 create mode 100644 arch/arm/boot/dts/qcom-msm8974.dtsi

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
