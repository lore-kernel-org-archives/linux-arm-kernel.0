From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jul 2015 14:41:53 -0700
Subject: [PATCH v4 0/2] SPMI regulator driver updates
Message-ID: <1437169315-31530-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the leftover parts of the SPMI regulator driver port. The
OCP feature and other vendor specific DT bindings that didn't make
v4.2. I've added a hook to configure OCP per 

Stephen Boyd (2):
  regulator: Add over current protection (OCP) support
  regulator: qcom-spmi: Add vendor specific configuration

 .../bindings/regulator/qcom,spmi-regulator.txt     |  60 ++++++-
 .../devicetree/bindings/regulator/regulator.txt    |   1 +
 drivers/regulator/core.c                           |   9 +
 drivers/regulator/of_regulator.c                   |   3 +
 drivers/regulator/qcom_spmi-regulator.c            | 200 ++++++++++++++++++++-
 include/linux/regulator/driver.h                   |   1 +
 include/linux/regulator/machine.h                  |   1 +
 7 files changed, 266 insertions(+), 9 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
