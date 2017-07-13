From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 13 Jul 2017 16:52:41 -0500
Subject: [PATCH 0/2] pinctrl: qcom: add support for sparse GPIOs
Message-ID: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First patch allows for for pinctrl-msm to understand GPIO groups with
no pins.  Such pins are "hidden" and can't be exported or accessed.

Second patch update the QDF2xxx driver to take advantage of that.

Timur Tabi (2):
  pinctrl: qcom: disable GPIO groups with no pins
  pinctrl: qcom: qdf2xxx: add support for new ACPI HID QCOM8002

 drivers/pinctrl/qcom/pinctrl-msm.c     |  36 ++++++--
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 157 +++++++++++++++++++++++----------
 2 files changed, 142 insertions(+), 51 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
