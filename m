From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 25 Jul 2016 10:50:29 -0500
Subject: [PATCH v9 4/9] clocksource/drivers/arm_arch_timer: use readq to
 get 64-bit CNTVCT
In-Reply-To: <20160725153118.GD19209@arm.com>
References: <1469460427-8643-1-git-send-email-fu.wei@linaro.org>
 <1469460427-8643-5-git-send-email-fu.wei@linaro.org>
 <20160725153118.GD19209@arm.com>
Message-ID: <57963545.6020400@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
>> >  {
>> >-	u32 vct_lo, vct_hi, tmp_hi;
>> >-
>> >-	do {
>> >-		vct_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> >-		vct_lo = readl_relaxed(arch_counter_base + CNTVCT_LO);
>> >-		tmp_hi = readl_relaxed(arch_counter_base + CNTVCT_HI);
>> >-	} while (vct_hi != tmp_hi);
>> >-
>> >-	return ((u64) vct_hi << 32) | vct_lo;
>> >+	return readq(arch_counter_base + CNTVCT_LO);
> Please drop this patch. It doesn't work.

On systems where readq() does work, wouldn't it be more optimal than the 
above while-loop?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
