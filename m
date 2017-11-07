From: timur@codeaurora.org (Timur Tabi)
Date: Tue,  7 Nov 2017 17:07:32 -0600
Subject: [PATCH 0/4] [v7] pinctrl: qcom: add support for sparse GPIOs
Message-ID: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A series of patches that add support for GPIO maps that have holes in
them.  That is, even though a client driver has N consecutive GPIOs,
some are just unavailable for whatever reason, and the hardware should
not be accessed for those GPIOs.

Frankly, I like V5 of this patchset better, because it uses an
existing API (gpiochip_add_pin_range) and is less intrusive.

v7: fixed missing signed-off-by in patch #1

Timur Tabi (4):
  [v2] Revert "gpio: set up initial state from .get_direction()"
  gpiolib: add bitmask for valid GPIO lines
  [v6] pinctrl: qcom: disable GPIO groups with no pins
  [v3] pinctrl: qcom: qdf2xxx: add support for new ACPI HID QCOM8002

 drivers/gpio/gpiolib.c                 |  74 +++++++++--------
 drivers/pinctrl/qcom/pinctrl-msm.c     |  48 +++++++++--
 drivers/pinctrl/qcom/pinctrl-msm.h     |   2 +
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c | 145 +++++++++++++++++++++++++--------
 include/linux/gpio/driver.h            |   2 +
 5 files changed, 197 insertions(+), 74 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
