From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 Jan 2017 15:28:20 +0000
Subject: [PATCH 1/2][UPDATE] of: base: add support to get the number of
 cache levels
In-Reply-To: <CAL_Jsq+wawaXeFPnmYw++YMiMzMm+9nSn498Dj7KsGzkfndfog@mail.gmail.com>
References: <1484048479-19767-1-git-send-email-sudeep.holla@arm.com>
 <1484049616-22388-1-git-send-email-sudeep.holla@arm.com>
 <CAL_Jsq+wawaXeFPnmYw++YMiMzMm+9nSn498Dj7KsGzkfndfog@mail.gmail.com>
Message-ID: <14f13c99-2fa4-b195-59f8-ddd9ec5b4037@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/17 13:24, Rob Herring wrote:
> On Tue, Jan 10, 2017 at 6:00 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> It is useful to have helper function just to get the number of cache
>> levels for a given logical cpu. This patch adds the support for the
>> same.
>>
>> It will be used on ARM64 platform where the device tree provides the
>> information for the additional non-architected/transparent/external
>> last level caches that are not integrated with the processors.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/of/base.c  | 23 +++++++++++++++++++++++
>>  include/linux/of.h |  1 +
>>  2 files changed, 24 insertions(+)
>>

[...]

>> +int of_count_cache_levels(unsigned int cpu)
>> +{
>> +       int level = 0;
>> +       struct device_node *np = of_cpu_device_node_get(cpu);
>> +
>> +       while (np) {
>> +               level++;
> 
> This will return 1 if you have a cpu node and no cache nodes. Are you
> assuming the cpu has a cache?
> 

Ah right, that's completely wrong assumption.

> Perhaps you should just find the last level cache node and then just
> read "cache-level".
> 

Yes, sounds better. I will update accordingly. Thanks for the suggestion.

-- 
Regards,
Sudeep
