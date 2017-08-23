From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 23 Aug 2017 18:47:09 -0500
Subject: [PATCH 0/2][v4] pinctrl: qcom: add support for sparse GPIOs
Message-ID: <1503532031-6428-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First patch allows for for pinctrl-msm to understand GPIO groups with
no pins.  Such pins are "hidden" and can't be exported or accessed.

Second patch updates the QDF2xxx driver to take advantage of all that.

v4:
  Introduce 'sparse' variable
  Update irq_valid_mask instead of conditionals in every IRQ function

Timur Tabi (2):
  [v4] pinctrl: qcom: disable GPIO groups with no pins
  [v3] pinctrl: qcom: qdf2xxx: add support for new ACPI HID QCOM8002

 drivers/pinctrl/qcom/pinctrl-msm.c     |  36 ++++++--
 drivers/pinctrl/qcom/pinctrl-msm.h     |   2 +
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 145 +++++++++++++++++++++++++--------
 3 files changed, 142 insertions(+), 41 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
