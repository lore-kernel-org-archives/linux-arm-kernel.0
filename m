From: timur@codeaurora.org (Timur Tabi)
Date: Thu,  7 Sep 2017 10:33:27 -0500
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
Message-ID: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First patch allows for for pinctrl-msm to understand GPIO groups with
no pins.  Such pins are "hidden" and can't be exported or accessed.

Second patch updates the QDF2xxx driver to take advantage of all that.

v5:
 Since gpiochip_add_data no longer requests GPIOs before scanning for
 the direction (that patch was reverted), pinctrl-msm.c now specifically
 checks for special case.

 Also added msm_gpio_get_next_range() to reduce the number of pin
 ranges registered.

Timur Tabi (2):
  [v5] pinctrl: qcom: disable GPIO groups with no pins
  [v3] pinctrl: qcom: qdf2xxx: add support for new ACPI HID QCOM8002

 drivers/pinctrl/qcom/pinctrl-msm.c     | 110 +++++++++++++++++++++++--
 drivers/pinctrl/qcom/pinctrl-msm.h     |   2 +
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 145 +++++++++++++++++++++++++--------
 3 files changed, 215 insertions(+), 42 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
