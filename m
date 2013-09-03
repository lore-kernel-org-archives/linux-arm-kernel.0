From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue,  3 Sep 2013 11:29:32 +0200
Subject: [PATCH V3 0/4] mmc: mmci: Support ap_sleep in cpuidle for ux500
Message-ID: <1378200576-13413-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to enter ap_sleep state in cpuidle were the APE power domain
regulator will be cut, a register save and restore mechanism needs to be
implemented. This patchset adapts to these restrictions.

Changes in v3:
	- Fold in a new patch, mmc: mmci: Adapt to new pinctrl handling
	- Updated patch "mmc: mmci: Use optional sleep pinctrl state" to
	use the new pinctrl API.
	- Added Acks from Rickard Andersson.

Ulf Hansson (4):
  mmc: mmci: Adapt to new pinctrl handling
  mmc: mmci: Use optional sleep pinctrl state
  mmc: mmci: Adapt to register write restrictions
  mmc: mmci: Save and restore register context

 drivers/mmc/host/mmci.c |   78 ++++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/mmci.h |    4 ---
 2 files changed, 61 insertions(+), 21 deletions(-)

-- 
1.7.9.5
