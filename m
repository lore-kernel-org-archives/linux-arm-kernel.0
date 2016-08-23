From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 23 Aug 2016 08:51:35 -0600
Subject: [PATCH V5 0/9] perf: Driver specific configuration for PMU
In-Reply-To: <878tvon8b7.fsf@ashishki-desk.ger.corp.intel.com>
References: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
 <878tvon8b7.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkxQNB-ZU6obSKvJZMMmZQT5kMfuUuA1PpF8YYeZqujwbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 August 2016 at 09:15, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> As such something that used to be a two-step process:
>>
>> # echo 1 > /sys/bus/coresight/devices/20070000.etr/enable_sink
>> # perf record -e cs_etm//u --per-thread  uname
>>
>> is integrated in a single command:
>>
>> # perf record -e cs_etm/@sink=20070000.etr/u --per-thread  uname
>
> Can't we simply teach perf record to write 1 to that sysfs attribute and
> avoid parsing more ascii strings in the kernel? I suspect that would also
> take way less code.

That, in my opinion, would be a big hack.  Peter and Jiri, any thoughts on this?

>
> Are there any other use cases for this besides specifying @sink for a
> ETM?

Not at this time but there is so many configuration option for the
ETM/PTM tracers (that aren't filters) that I wanted the right
infrastructure to be there should/when we need to expand.

Thanks for taking the time to review this set,
Mathieu

>
> Regards,
> --
> Alex
