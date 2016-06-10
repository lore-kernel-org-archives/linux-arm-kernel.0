From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 10 Jun 2016 23:38:20 +0530
Subject: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
In-Reply-To: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

index gets incremented during check to determine if the
messages can be transferred with dma. But not reset after
that, resulting in wrong start value in subsequent loop,
causing failure. Fix it.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 43adc2d..b8116e5 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1260,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 		}
 	}
 
+	idx = 0;
+
 	do {
 		if (msgs[idx].len == 0) {
 			ret = -EINVAL;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
