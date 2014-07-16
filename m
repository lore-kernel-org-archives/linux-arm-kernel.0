From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 16 Jul 2014 14:45:21 -0700
Subject: [PATCH v3 1/2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <53C6DFAD.8030109@codeaurora.org>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
 <1405464473-3916-2-git-send-email-skannan@codeaurora.org>
 <CAKohpok2hzwDLy77CZJ+7pHV-Nj4XTviJxVeXQYJRYtKXME00w@mail.gmail.com>
 <53C6DFAD.8030109@codeaurora.org>
Message-ID: <53C6F271.6070707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2014 01:25 PM, Saravana Kannan wrote:
> On 07/16/2014 01:24 AM, Viresh Kumar wrote:
>> On 16 July 2014 04:17, Saravana Kannan <skannan@codeaurora.org> wrote:
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>
>>> @@ -1110,9 +1092,10 @@ static int __cpufreq_add_dev(struct device
>>> *dev, struct subsys_interface *sif)
>>>
>>>   #ifdef CONFIG_SMP
>>>          /* check whether a different CPU already registered this
>>> -        * CPU because it is in the same boat. */
>>> +        * CPU because it is one of the related CPUs. */
>>>          policy = cpufreq_cpu_get(cpu);
>>> -       if (unlikely(policy)) {
>>> +       if (policy) {
>>> +               cpufreq_change_policy_cpus(policy, cpu, true);
>>
>> This is just a waste of time at boot as ... (see below)
>
> Why? Please explain.
>

Nevermind. Figured what you meant. I just need to improve the "if" check.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
