From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 5 Aug 2016 09:44:11 -0600
Subject: [PATCH V4 6/6] coresight: etm-perf: incorporating sink definition
 from cmd line
In-Reply-To: <2b1836a4-00be-b6d5-02d4-38d23b3451ad@arm.com>
References: <1470329604-14356-1-git-send-email-mathieu.poirier@linaro.org>
 <1470329604-14356-7-git-send-email-mathieu.poirier@linaro.org>
 <2b1836a4-00be-b6d5-02d4-38d23b3451ad@arm.com>
Message-ID: <CANLsYkzg+27wxvGvtTVpim3MGwxifcJ09XkBpyUJpQSRCxR9yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 August 2016 at 03:32, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 04/08/16 17:53, Mathieu Poirier wrote:
>>
>> Now that PMU specific configuration is available as part of the event,
>> lookup the sink identified by users from the perf command line and build
>> a path from source to sink.
>>
>> With this functionality it is no longer required to select a sink in a
>> separate step (from sysFS) before a perf trace session can be started.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
>
>
>> +static const match_table_t drv_cfg_tokens = {
>> +       {ETM_TOKEN_SINK_CPU, "sink=cpu%d:%s"},
>> +       {ETM_TOKEN_SINK, "sink=%s"},
>> +       {ETM_TOKEN_ERR, NULL},
>> +};
>> +
>
>
> Is the above format documented somewhere for the perf users ? If not could
> we please
> add it ?
>

Yes definitely.  I will document everything once I am done with
upstreaming the feature.  That way we go over the process only once.

> Thanks
> Suzuki
>
