From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 27 May 2014 17:24:10 +0530
Subject: [PATCH 1/1] ARM: mvebu: Staticize local variables
In-Reply-To: <20140527135108.1642833b@free-electrons.com>
References: <1401190629-24559-1-git-send-email-sachin.kamat@linaro.org>
 <20140527135108.1642833b@free-electrons.com>
Message-ID: <CAK9yfHxm27Rg3YcXTfSff7LAmYsj-VFBgBKXBXiD8SXGGYfFzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 27 May 2014 17:21, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Sachin Kamat,
>
> On Tue, 27 May 2014 17:07:09 +0530, Sachin Kamat wrote:
>> Symbols local to this file are made static.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  arch/arm/mach-mvebu/pmsu.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
>> index 53a55c8520bf..950105871480 100644
>> --- a/arch/arm/mach-mvebu/pmsu.c
>> +++ b/arch/arm/mach-mvebu/pmsu.c
>> @@ -148,7 +148,7 @@ static void armada_370_xp_cpu_resume(void)
>>  }
>>
>>  /* No locking is needed because we only access per-CPU registers */
>> -void armada_370_xp_pmsu_idle_prepare(bool deepidle)
>> +static void armada_370_xp_pmsu_idle_prepare(bool deepidle)
>
> I already submitted a patch for this one yesterday:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/259849.html.

I missed this. Sorry.

>
>>  {
>>       unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
>>       u32 reg;
>> @@ -263,7 +263,7 @@ static struct notifier_block
>> armada_370_xp_cpu_pm_notifier = { .notifier_call =
>> armada_370_xp_cpu_pm_notify, };
>>
>> -int __init armada_370_xp_cpu_pm_init(void)
>> +static int __init armada_370_xp_cpu_pm_init(void)
>
> Indeed, this one needs to be fixed.

How do you want me to handle this?

-- 
With warm regards,
Sachin
