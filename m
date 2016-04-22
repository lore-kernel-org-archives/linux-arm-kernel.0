From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 22 Apr 2016 17:17:04 -0500
Subject: [PATCH 0/8] Qualcomm SCM Rework
Message-ID: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following set of patches does a bit of rework on the existing
Qualcomm SCM firmware.  The first couple of patches deals with turning
the current SCM into a platform driver.  The next couple are cleanups
that make adding the 64 support a little easier.

I took Kumar's 64 bit support patch and modified it to use the arm_smccc
calls.  This simplified things quite a bit.

Lastly, there are a few DT patches to add the firmware node for a couple of the
supported platforms.

Andy Gross (7):
  dt/bindings: firmware: Add Qualcomm SCM binding
  firmware: qcom: scm: Convert SCM to platform driver
  firmware: qcom: scm: Generalize shared error map
  firmware: qcom: scm: Use atomic SCM for cold boot
  firmware: qcom: scm: Add memory allocation API
  dts: qcom: apq8084: Add SCM firmware node
  arm64: dts: msm8916: Add SCM firmware node

Kumar Gala (1):
  firmware: qcom: scm: Add support for ARM64 SoCs

 .../devicetree/bindings/firmware/qcom,scm.txt      |  31 ++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  10 ++
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  10 ++
 drivers/firmware/qcom_scm-32.c                     |  61 ++++---
 drivers/firmware/qcom_scm-64.c                     | 194 ++++++++++++++++++++-
 drivers/firmware/qcom_scm.c                        | 178 ++++++++++++++++++-
 drivers/firmware/qcom_scm.h                        |  24 +++
 8 files changed, 468 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt

-- 
1.9.1
