From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 29 Aug 2016 09:58:51 -0600
Subject: [PATCH V6 0/5] perf: Driver specific configuration for PMU
In-Reply-To: <20160828141808.GC32293@krava>
References: <1472156445-24283-1-git-send-email-mathieu.poirier@linaro.org>
 <20160828141808.GC32293@krava>
Message-ID: <CANLsYkyzYaF3Z=MPAwevtosN-XU5BK7qSwppaJ1nBNqT-qoCwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2016 at 08:18, Jiri Olsa <jolsa@redhat.com> wrote:
> On Thu, Aug 25, 2016 at 02:20:40PM -0600, Mathieu Poirier wrote:
>
> SNIP
>
>> perf record -e some_event/@cfg1, at cfg2=config/ ...
>>
>> The above are all valid configuration and will see the strings 'cfg1'
>> and 'cfg2=config' sent to the PMU driver for parsing and interpretation
>> using the existing ioctl() mechanism.
>>
>> The primary customers for this feature are the CoreSight drivers where
>> the selection of a sink (where trace data is accumulated) needs to be
>> done in a previous, and separated step, from the launching of the perf
>> command.
>>
>> As such something that used to be a two-step process:
>>
>> # echo 1 > /sys/bus/coresight/devices/20070000.etr/enable_sink
>> # perf record -e cs_etm//u --per-thread  uname
>>
>> is integrated in a single command:
>>
>> # perf record -e cs_etm/@20070000.etr/u --per-thread  uname
>>
>> Thanks,
>> Mathieu
>>
>> Changes for V6:
>> - Using sysFS rather than an ioctl() to communicate command line
>>   parameters to the CoreSight PMU.
>
> apart from few nits it looks good.. but can't say for patch 2/5 ;-)
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>

Many thanks for taking the time to look at this set - your time is
much appreciated.

> thanks,
> jirka
