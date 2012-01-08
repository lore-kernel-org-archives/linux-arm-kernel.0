From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Sun, 8 Jan 2012 18:25:24 +0200
Subject: [RFC PATCH v2 1/9] arm: avoid using on_each_cpu hard coded ret
 value
In-Reply-To: <20120108161212.GD21765@n2100.arm.linux.org.uk>
References: <1326029549-2794-1-git-send-email-gilad@benyossef.com>
 <1326029549-2794-2-git-send-email-gilad@benyossef.com>
 <20120108161212.GD21765@n2100.arm.linux.org.uk>
Message-ID: <CAOtvUMddvPVQTaUQAmGOgx9Wz18ewVWG5nRouYaDuFWe13pX4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 8, 2012 at 6:12 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

<SNIP>

>> diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
>> index 5bb91bf..6e9acb7 100644
>> --- a/arch/arm/kernel/perf_event.c
>> +++ b/arch/arm/kernel/perf_event.c
>> @@ -616,7 +616,7 @@ static int __init
>> ?cpu_pmu_reset(void)
>> ?{
>> ? ? ? if (cpu_pmu && cpu_pmu->reset)
>> - ? ? ? ? ? ? return on_each_cpu(cpu_pmu->reset, NULL, 1);
>> + ? ? ? ? ? ? on_each_cpu(cpu_pmu->reset, NULL, 1);
>
> There's not much to review here...

Oh, I've introduced fatal bugs with less... :-)

Thanks for the review.
Gilad


-- 
Gilad Ben-Yossef
Chief Coffee Drinker
gilad at benyossef.com
Israel Cell: +972-52-8260388
US Cell: +1-973-8260388
http://benyossef.com

"Unfortunately, cache misses are an equal opportunity pain provider."
-- Mike Galbraith, LKML
