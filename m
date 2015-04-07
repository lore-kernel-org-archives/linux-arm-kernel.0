From: agross@codeaurora.org (Andy Gross)
Date: Tue, 7 Apr 2015 00:06:40 -0500
Subject: [PATCH V2 2/6] i2c: qup: Add V2 tags support
In-Reply-To: <1428345067-21878-3-git-send-email-sricharan@codeaurora.org>
References: <1428345067-21878-1-git-send-email-sricharan@codeaurora.org>
 <1428345067-21878-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <20150407050640.GB9225@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 12:01:03AM +0530, Sricharan R wrote:

<snip>

> +static u32 qup_i2c_send_data(struct qup_i2c_dev *qup, int tlen, u8 *tbuf,
> +			     int dlen, u8 *dbuf)
> +{
> +	u32 val = 0, idx = 0, pos = 0, i = 0, t;
> +	int  len = tlen + dlen;
> +	u8 *buf = tbuf;
> +
> +	while (len > 0) {
> +		if (qup_i2c_wait_ready(qup, QUP_OUT_FULL, 0, 4)) {

Instead of 0 and 4 can we use some #defines?  This applies for all of the
i2c_wait_ready calls

<snip>


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
