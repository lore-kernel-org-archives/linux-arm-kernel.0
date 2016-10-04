From: nleeder@codeaurora.org (Neil Leeder)
Date: Tue, 4 Oct 2016 12:25:54 -0400
Subject: [PATCH v6] soc: qcom: add l2 cache perf events driver
In-Reply-To: <20161004155304.GB29008@leverpostej>
References: <1474492374-12140-1-git-send-email-nleeder@codeaurora.org>
 <20161004155304.GB29008@leverpostej>
Message-ID: <4d049ac5-2661-9af5-561b-6cd4029c3b83@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/4/2016 11:53 AM, Mark Rutland wrote:
> Hi Neil,
> 
> On Wed, Sep 21, 2016 at 05:12:54PM -0400, Neil Leeder wrote:
>> Adds perf events support for L2 cache PMU.
>>
>> The L2 cache PMU driver is named 'l2cache_0' and can be used
>> with perf events to profile L2 events such as cache hits
>> and misses.
>>
>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
>> ---
> 
>>  drivers/soc/qcom/Kconfig         |   9 +
>>  drivers/soc/qcom/Makefile        |   1 +
>>  drivers/soc/qcom/perf_event_l2.c | 948 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/cpuhotplug.h       |   1 +
>>  4 files changed, 959 insertions(+)
>>  create mode 100644 drivers/soc/qcom/perf_event_l2.c
> 
> Apologies for the delay; this has been on my todo list, but I've been a
> little distracted and haven't had the time necessary to devote to this.
> It's somewhat unusual given the constraint logic and the percpu uncore
> component, so there's more to consider than usual.
> 
> At a high level, this will need to be moved to drivers/perf/, per [1].
> 
> Can you move the driver there, and post the result atop of v4.8-rc1 at
> the end of the merge window? Until then, I can't guarantee that I'll
> have the time to look at this.
> 
> Can you also give Vince's perf fuzzer [2] a spin against the driver? I
> can't recall if we covered that previously, and in practice it's found a
> number of issues in drivers that have otherwise looked fine. If you've
> done so, it'd be worth noting in the cover.
> 
> Thanks,
> Mark.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/457188.html
> [2] https://github.com/deater/perf_event_tests
> 

Thanks Mark. I'll move it, rebase on 4.9-rc1 and run perf fuzzer.

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
