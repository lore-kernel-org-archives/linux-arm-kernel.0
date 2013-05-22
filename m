From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Wed, 22 May 2013 17:58:58 +0200
Subject: [PATCH 13/14] sched: update the cpu_power
In-Reply-To: <20130522154639.GA4935@e103034-lin>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <1366910611-20048-14-git-send-email-vincent.guittot@linaro.org>
 <20130522154639.GA4935@e103034-lin>
Message-ID: <CAKfTPtBxt=W9m97=Ec5yjoMZX=TjpBanbRDQV=HV3b9DC_fDQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2013 17:46, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> On Thu, Apr 25, 2013 at 06:23:29PM +0100, Vincent Guittot wrote:
>> @@ -4596,8 +4597,12 @@ static void update_cpu_power(struct sched_domain *sd, int cpu)
>>       cpu_rq(cpu)->cpu_available = power;
>>       sdg->sgp->power_available = power;
>>
>> +     if (!is_my_buddy(cpu, cpu))
>> +             power = 1;
>> +
>
> Using your fix for is_my_buddy() for patch 11 the above will always be
> true when sched_packing_mode is to anything else than
> SCHED_PACKING_FULL. So cpu_power for all cpus in
> SCHED_PACKING_{DEFAULT,NONE} is 1.
>
> As far is I understand, this is not the intention?

yes, the too quick fix for 11/14 has not fixed anything... the final
fix is available in git://git.linaro.org/people/vingu/kernel.git
sched-pack-small-tasks-v4-fixed.

And it will be part of the next version that i prepare

Vincent
>
> Cheers,
> Morten
>
>>       cpu_rq(cpu)->cpu_power = power;
>>       sdg->sgp->power = power;
>> +
>>  }
>>
>>  void update_group_power(struct sched_domain *sd, int cpu)
>> --
>> 1.7.9.5
>>
>>
>
