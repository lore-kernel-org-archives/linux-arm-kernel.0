From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Aug 2013 11:48:09 -0600
Subject: [PATCH 1/6] clk: Tegra: Add CPU0 clock driver
In-Reply-To: <CAKohpokVgcMfmKmjkxc9Dr3z6mBKad23uUdB4ydN_xzGHdfedQ@mail.gmail.com>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <8d192a13cb7e088943da40689d62bc6353bd8604.1375886595.git.viresh.kumar@linaro.org>
 <52028620.6000608@wwwdotorg.org>
 <CAKohpokVgcMfmKmjkxc9Dr3z6mBKad23uUdB4ydN_xzGHdfedQ@mail.gmail.com>
Message-ID: <52028859.20008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 11:45 AM, Viresh Kumar wrote:
> On 7 August 2013 23:08, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 08/07/2013 08:46 AM, Viresh Kumar wrote:
>>> This patch adds CPU0's clk driver for Tegra. It will be used by the generic
>>> cpufreq-cpu0 driver to get/set cpu clk.
>>>
>>> Most of the platform specific bits are picked from tegra-cpufreq.c.
>>
>> Hmmm. I'm not sure if it makes sense to represent this as a clock
>> object; isn't this more of a virtual construct that manages the rate of
>> the clock, rather than an actual clock? The actual clock already exists
>> as "cpu".
> 
> I see it as this: There is a clock in system for cpu, call it "cpu". Now we
> must be able to provide get/set routines for it. A set should set the
> frequency to whatever is asked for and should really worry about how
> that is being set. This part is internal to "cpu" clk.

Sure.

> This is what cpufreq-cpu0 driver should expect and does. Current "cpu"
> clock implemented doesn't provide this facility ? And so this wrapper
> made sense to me.

But the additional management logic on top of the raw clock is exactly
what the cpufreq driver is for. This patch series is basically moving
the cpufreq driver code inside the clock code instead.
