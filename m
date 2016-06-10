From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 10 Jun 2016 23:43:01 +0530
Subject: [PATCH V4 0/3] i2c: qup: Some misc fixes
In-Reply-To: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <00a501d1c343$c03e2b60$40ba8220$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Wolfram. Sorry Missed.

>-----Original Message-----
>From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Sricharan R
>Sent: Friday, June 10, 2016 11:38 PM
>To: linux-arm-msm at vger.kernel.org; ntelkar at codeaurora.org; galak at codeaurora.org; linux-kernel at vger.kernel.org;
>andy.gross at linaro.org; linux-i2c at vger.kernel.org; agross at codeaurora.org; linux-arm-kernel at lists.infradead.org;
>nkaje at codeaurora.org; absahu at codeaurora.org
>Cc: sricharan at codeaurora.org
>Subject: [PATCH V4 0/3] i2c: qup: Some misc fixes
>
>One for fixing the bug with CONFIG_DEBUG_SG enabled, another
>to suspend the transfer for all errors instead of just for NACK
>and one for correcting the wrong initial value for index variable.
>
>[V4] Added little more description to patch#1 and split a
>     change in to a new patch.
>
>[V3] Added more commit description. Return more appropriate
>     error codes for NACK and other bus errors. Corrected
>     other bus errors handling procedure for dma mode as well.
>     Removed the dev_err log for NACKs.
>
>[V2] Removed the use of unnecessary variable assignment.
>
>Kept the reviewed and Tested by tag for patch#1,
>as there was no code change.
>
>Depends on patch[1] for the error handling to be complete.
>
>[1] https://lkml.org/lkml/2016/5/9/447
>
>Sricharan R (3):
>  i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled
>  i2c: qup: Fix wrong value of index variable
>  i2c: qup: Fix error handling
>
> drivers/i2c/busses/i2c-qup.c | 128 ++++++++++++++++++++-----------------------
> 1 file changed, 58 insertions(+), 70 deletions(-)
>
>--
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux
>Foundation
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
