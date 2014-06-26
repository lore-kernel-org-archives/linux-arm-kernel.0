From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Jun 2014 12:36:36 +0100
Subject: [PATCH 8/9] ARM: kernel: add support for cpu cache information
In-Reply-To: <53AB6700.2060807@codeaurora.org>
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-9-git-send-email-sudeep.holla@arm.com>
 <53AB6700.2060807@codeaurora.org>
Message-ID: <53AC05C4.2030104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 26/06/14 01:19, Stephen Boyd wrote:
> On 06/25/14 10:30, Sudeep Holla wrote:
>> +
>> +/*
>> + * Which cache CCSIDR represents depends on CSSELR value
>> + * Make sure no one else changes CSSELR during this
>> + * smp_call_function_single prevents preemption for us
>> + */
>
> Where's the smp_call_function_single() or preemption disable happening?
>

init_cache_level is called using smp_call_function_single in
drivers/base/cacheinfo.c(PATCH 2/9)

Regards,
Sudeep
