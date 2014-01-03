From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 02 Jan 2014 16:46:20 -0800
Subject: [PATCH 2/2] sched_clock: Disable seqlock lockdep usage in
 sched_clock
In-Reply-To: <1388704274-5278-2-git-send-email-john.stultz@linaro.org>
References: <52C5E675.80701@linaro.org>
 <1388704274-5278-1-git-send-email-john.stultz@linaro.org>
 <1388704274-5278-2-git-send-email-john.stultz@linaro.org>
Message-ID: <52C6085C.3070206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/14 15:11, John Stultz wrote:
> Unforunately the seqlock lockdep enablmenet can't be used

s/Unforunately/Unfortunately/
s/enablmenet/enablement/

> in sched_clock, since the lockdep infrastructure eventually
> calls into sched_clock, which causes a deadlock.
>
> Thus, this patch changes all generic sched_clock usage
> to use the raw_* methods.
>
> Cc: Krzysztof Ha?asa <khalasa@piap.pl>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Ingo Molnar <mingo@kernel.org>,
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Reported-by: Krzysztof Ha?asa <khalasa@piap.pl>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
