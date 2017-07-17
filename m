From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 17 Jul 2017 18:43:58 -0500
Subject: [PATCH 0/3][v2] pinctrl: qcom: add support for sparse GPIOs
Message-ID: <1500335041-32711-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First patch update gpiolib so that it requests the GPIO before trying to
initialize it.

Second patch allows for for pinctrl-msm to understand GPIO groups with
no pins.  Such pins are "hidden" and can't be exported or accessed.

Last patch updates the QDF2xxx driver to take advantage of all that.


Timur Tabi (3):
  gliolib: request the gpio before querying its direction
  [v2] pinctrl: qcom: disable GPIO groups with no pins
  [v2] pinctrl: qcom: qdf2xxx: add support for new ACPI HID QCOM8002

 drivers/gpio/gpiolib.c                 |  11 +++
 drivers/pinctrl/qcom/pinctrl-msm.c     |  22 ++++--
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 139 ++++++++++++++++++++++++---------
 3 files changed, 131 insertions(+), 41 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
