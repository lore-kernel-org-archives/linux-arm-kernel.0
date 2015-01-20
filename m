From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Jan 2015 12:53:33 -0800
Subject: [PATCH 3.19-rc2 v14 0/7] arm: Implement
 arch_trigger_all_cpu_backtrace
In-Reply-To: <54BE2D15.9080606@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1421144818-14036-1-git-send-email-daniel.thompson@linaro.org>
 <54BE2D15.9080606@linaro.org>
Message-ID: <54BEC04D.1050402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2015 02:25 AM, Daniel Thompson wrote:
> On 13/01/15 10:26, Daniel Thompson wrote:
>> Hi Thomas, Hi Jason:
>>     Patches 1 to 3 are for you (and should be separable from the rest
>>     of the series). The patches haven't changes since the last time
>>     I posted them. The changes in v14 tidy up the later part of the
>>     patch set in order to share more code between x86 and arm.
> No review comments! Have I finally got this right?
>
> If so it possible and/or sensible to get patches 1-3 in a tree that
> feeds linux-next. I'd really like the gic changes to meet the various
> ARM build and boot bots.

With this patchset, is it possible to call sched_clock() from within NMI
context? I ask because the generic sched_clock() code is not NMI safe
today. We were planning on making it NMI safe by doing something similar
to what was done for ktime_get_mono_fast_ns() but we haven't gotten
around to it. Mostly because no architecture that uses generic
sched_clock() has support for NMIs right now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
