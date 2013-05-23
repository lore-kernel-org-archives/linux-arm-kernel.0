From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 11:45:04 +0200
Subject: [PATCH V2 0/3] mmc: mmci: Support ap_sleep in cpuidle for ux500
Message-ID: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

To be able to enter ap_sleep state in cpuidle were the APE power domain
regulator will be cut, a register save and restore mechanism needs to be
implemented. This patchset adapts to these restrictions.

Ulf Hansson (3):
  mmc: mmci: Use optional sleep pinctrl state
  mmc: mmci: Adapt to register write restrictions
  mmc: mmci: Save and restore register context

 drivers/mmc/host/mmci.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |    1 +
 2 files changed, 76 insertions(+)

-- 
1.7.10
