From: spjoshi@codeaurora.org (Sarangdhar Joshi)
Date: Thu,  3 Nov 2016 17:10:34 -0700
Subject: [PATCH v2 0/3] Remove clocks dependency from SCM driver
Message-ID: <1478218237-1737-1-git-send-email-spjoshi@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On earlier chiptsets (APQ8064, MSM8660, MSM8690, MSM8916,
APQ8084, MSM8974) crypto operations of TZ were depends on crypto
clocks controlled by users/clients. However on MSM8996 crypto clocks
control is handled internally in TZ itself. The current series of
patches handle this clock dependency in SCM driver.

Changes since v1:
- Added Rob's Acked-by
- Removed of_device_is_compatible check from probe (Stephen)
- Modified typecast to take care of 32-bit pointer

Sarangdhar Joshi (3):
  dt-bindings: firmware: scm: Add MSM8996 DT bindings
  firmware: qcom: scm: Remove core, iface and bus clocks dependency
  firmware: qcom: scm: Return PTR_ERR when devm_clk_get fails

 .../devicetree/bindings/firmware/qcom,scm.txt      |  2 +
 drivers/firmware/qcom_scm.c                        | 49 ++++++++++++++++------
 2 files changed, 39 insertions(+), 12 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
