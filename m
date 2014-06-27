From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 27 Jun 2014 07:45:55 +0530
Subject: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
In-Reply-To: <20140627015354.32686.83046@quantum>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
 <e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
 <53AB1CC1.4010907@codeaurora.org>
 <CAKohpo=Q7eWNwcK6KF9_U-zD0g=96QHW9hiQupLpV5GqoWE+mA@mail.gmail.com>
 <53ACB568.4000903@codeaurora.org>
 <20140627015354.32686.83046@quantum>
Message-ID: <CAKohponvN3rAvJrfi4TojFcq5gq7r2oNE4Q0_NtwBHmEZ8waBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2014 07:23, Mike Turquette <mturquette@linaro.org> wrote:
>> but it isn't future-proof if/when the clock framework starts returning
>> dynamically allocated clock pointers for each clk_get() invocation.
>> Maybe we need a function in the common clock framework that tells us if
>> the clocks are the same either via DT or by taking two clock pointers?
>
> I looked through the patch briefly and did not see why we would need to
> do this. Any hint?

We want to know which CPUs are sharing clock line, so that we can
fill affected-cpus field of cpufreq core.
