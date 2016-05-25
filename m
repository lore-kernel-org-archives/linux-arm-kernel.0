From: sricharan@codeaurora.org (Sricharan R)
Date: Wed, 25 May 2016 13:46:50 +0530
Subject: [PATCH V3 0/2] i2c: qup: Some misc fixes
Message-ID: <1464164212-11377-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One for fixing the bug with CONFIG_DEBUG_SG enabled and another
to suspend the transfer for all errors instead of just for NACK.

[V3] Added more commit description. Return more appropriate
     error codes for NACK and other bus errors. Corrected
     other bus errors handling procedure for dma mode as well.
     Removed the dev_err log for NACKs.

[V2] Removed the use of unnecessary variable assignment.

Kept the reviewed and Tested by tag for patch#1,
as there was no code change.

Depends on patch[1] for the error handling to be complete.

[1] https://lkml.org/lkml/2016/5/9/447

Sricharan R (2):
  i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled
  i2c: qup: Fix error handling

 drivers/i2c/busses/i2c-qup.c | 129 +++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 71 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
