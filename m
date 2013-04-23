From: arjan@linux.intel.com (Arjan van de Ven)
Date: Tue, 23 Apr 2013 08:30:58 -0700
Subject: [RFC PATCH v3 5/6] sched: pack the idle load balance
In-Reply-To: <5175F09E.1000304@intel.com>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-6-git-send-email-vincent.guittot@linaro.org>
 <1364302359.5053.21.camel@laptop>
 <CAKfTPtD=_oS5gJeynUG=ft-Y1zEdxZEMhUPH9hSXx+H2pi4xgA@mail.gmail.com>
 <1364308932.5053.46.camel@laptop>
 <CAKfTPtArtgkH5MU_xFAKjLDS-i32g2qQMdvyW=LLkG84tH8Hhg@mail.gmail.com>
 <5174CE96.3060805@linux.vnet.ibm.com>
 <CAKfTPtCCCifC=c+xjjnAH_HSqkR80PiQoddQKXPHuZwZawbvcA@mail.gmail.com>
 <5175F09E.1000304@intel.com>
Message-ID: <5176A932.5050506@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/22/2013 7:23 PM, Alex Shi wrote:
> Thanks you, Preeti and Vincent to talk the power aware scheduler for
> details! believe this open discussion is helpful to conduct a a more
> comprehensive solution. :)
>
>> Hi Preeti,
>>
>> I have had a look at Alex patches but i have some concerns with his patches
>> -There no notion of power domain which is quite important when we speak
>> about power saving IMHO. Packing tasks has got an interest if the idle
>> CPUs can reach a useful low power state independently from busy CPUs.
>> Architectures have different low power state capabilities which must be
>> taken into account. In addition, you can have system which have CPUs
>> with better power efficiency and this kind of system are not taken into
>> account.
>
> I agree with you on this point. and like what's you done to add new flag
> in sched domain.

For x86 we should not be setting such flag then; we don't have a way for some cpu packages to
go to an extra deep power state if they're completely idle.
(this afaik is true for both Intel and AMD)
