From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 17 Jan 2017 06:18:12 -0600
Subject: [PATCH v19 10/15] clocksource/drivers/arm_arch_timer: Refactor
 the timer init code to prepare for GTDT
In-Reply-To: <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20161221064603.11830-11-fu.wei@linaro.org>
 <20170116183032.GL5908@leverpostej>
 <CADyBb7tFaSshUmZsJbNO2tnbqAKEii39NQVfcx5CqDiDsK5OJA@mail.gmail.com>
Message-ID: <b977f47b-a85e-d4d5-666c-b8c9cd21c25e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fu Wei wrote:
> if (i >= ARCH_TIMER_MEM_MAX_FRAMES) {
>         pr_err(FW_BUG "too many frames, ARMv8 spec only allows 8.\n");

pr_err(FW_BUG "too many frames, ARMv8 spec only allows %u.\n",
	ARCH_TIMER_MEM_MAX_FRAMES);

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
