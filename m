From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 31 Aug 2016 08:14:22 -0600
Subject: [PATCH V7 5/5] perf tools: adding sink configuration for cs_etm
 PMU
In-Reply-To: <94a6e940-cce8-a179-fe0c-c69a543e302c@arm.com>
References: <1472573965-3881-1-git-send-email-mathieu.poirier@linaro.org>
 <1472573965-3881-6-git-send-email-mathieu.poirier@linaro.org>
 <94a6e940-cce8-a179-fe0c-c69a543e302c@arm.com>
Message-ID: <CANLsYkzeS=1fY6uQVNpJMpOfqnT_BtUOfh+YHzZWi+XA+C=dwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 August 2016 at 03:37, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 30/08/16 17:19, Mathieu Poirier wrote:
>>
>> Using the PMU::set_drv_config() callback to enable the CoreSight
>> sink that will be used for the trace session.
>
>
>> +int cs_etm_set_drv_config(struct perf_evsel_config_term *term)
>> +{
>> +       int ret;
>> +       char enable_sink[ENABLE_SINK_MAX];
>> +
>> +       snprintf(enable_sink, ENABLE_SINK_MAX, "%s/%s",
>> +                term->val.drv_cfg, "enable_sink");
>> +
>> +       ret = cs_device__print_file(enable_sink, "%d", 1);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>
>
>
> Don't we have to disable the sink at the end of the session ? How is that
> taken care of ? Did I miss that ?
>

Correct - the sink has to be disabled once it is no longer needed.  It
is a little tricky to do and I haven't decided on the best way to
proceed.  Fortunately that aspect doesn't affect this patchset.

Mathieu

> Suzuki
