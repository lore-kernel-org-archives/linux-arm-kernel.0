From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Jun 2014 11:45:14 -0700
Subject: [PATCH 8/9] ARM: kernel: add support for cpu cache information
In-Reply-To: <53AC05C4.2030104@arm.com>
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-9-git-send-email-sudeep.holla@arm.com>
 <53AB6700.2060807@codeaurora.org> <53AC05C4.2030104@arm.com>
Message-ID: <53AC6A3A.1010001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/14 04:36, Sudeep Holla wrote:
> Hi Stephen,
>
> On 26/06/14 01:19, Stephen Boyd wrote:
>> On 06/25/14 10:30, Sudeep Holla wrote:
>>> +
>>> +/*
>>> + * Which cache CCSIDR represents depends on CSSELR value
>>> + * Make sure no one else changes CSSELR during this
>>> + * smp_call_function_single prevents preemption for us
>>> + */
>>
>> Where's the smp_call_function_single() or preemption disable happening?
>>
>
> init_cache_level is called using smp_call_function_single in
> drivers/base/cacheinfo.c(PATCH 2/9)

Oh that's unexpected. Do other architectures require the use of
smp_call_function_single() to read their cache information? It seems
like an ARM architecture specific detail that has been pushed up into
the generic layer.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
