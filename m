From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 26 Jun 2014 18:53:54 -0700
Subject: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
In-Reply-To: <53ACB568.4000903@codeaurora.org>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
 <e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
 <53AB1CC1.4010907@codeaurora.org>
 <CAKohpo=Q7eWNwcK6KF9_U-zD0g=96QHW9hiQupLpV5GqoWE+mA@mail.gmail.com>
 <53ACB568.4000903@codeaurora.org>
Message-ID: <20140627015354.32686.83046@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-06-26 17:06:00)
> Finally, checking for equivalent pointers from clk_get() will work now,

Please don't do that. Even though it works for the current
implementation, comparing those pointers from a driver violates how
clkdev is supposed to work. The pointer returned by clk_get should only
be dereferenced by a driver to check if it is an error code. Anything
besides an error code is no business of the driver.

> but it isn't future-proof if/when the clock framework starts returning
> dynamically allocated clock pointers for each clk_get() invocation.
> Maybe we need a function in the common clock framework that tells us if
> the clocks are the same either via DT or by taking two clock pointers?

I looked through the patch briefly and did not see why we would need to
do this. Any hint?

Thanks,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> 
