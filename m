From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 10 Jun 2016 23:45:37 +0530
Subject: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
In-Reply-To: <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <00af01d1c344$1cd02310$56706930$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Wolfram Sang

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Sricharan R
>Sent: Friday, June 10, 2016 11:38 PM
>To: linux-arm-msm at vger.kernel.org; ntelkar at codeaurora.org; galak at codeaurora.org; linux-kernel at vger.kernel.org;
>andy.gross at linaro.org; linux-i2c at vger.kernel.org; agross at codeaurora.org; linux-arm-kernel at lists.infradead.org;
>nkaje at codeaurora.org; absahu at codeaurora.org
>Cc: sricharan at codeaurora.org
>Subject: [PATCH V4 2/3] i2c: qup: Fix wrong value of index variable
>
>index gets incremented during check to determine if the
>messages can be transferred with dma. But not reset after
>that, resulting in wrong start value in subsequent loop,
>causing failure. Fix it.
>
>Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>---
> drivers/i2c/busses/i2c-qup.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
>index 43adc2d..b8116e5 100644
>--- a/drivers/i2c/busses/i2c-qup.c
>+++ b/drivers/i2c/busses/i2c-qup.c
>@@ -1260,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
> 		}
> 	}
>
>+	idx = 0;
>+
> 	do {
> 		if (msgs[idx].len == 0) {
> 			ret = -EINVAL;
>--
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux
>Foundation
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
