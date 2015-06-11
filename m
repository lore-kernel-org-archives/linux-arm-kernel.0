From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Jun 2015 16:58:46 +0200
Subject: [PATCH 2/6] clocksource: arm_global_timer: Migrate to new
 'set-state' interface
In-Reply-To: <20150611145654.GB4386@linux>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <54f346e663f605e2f078a3114de85ba281d1e6d0.1433768426.git.viresh.kumar@linaro.org>
 <5579A011.8030900@linaro.org> <20150611145654.GB4386@linux>
Message-ID: <5579A226.3070704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2015 04:56 PM, Viresh Kumar wrote:
> On 11-06-15, 16:49, Daniel Lezcano wrote:
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Thanks :)
>
>>> -	clk->set_mode = gt_clockevent_set_mode;
>>> +	clk->set_state_shutdown = gt_clockevent_shutdown;
>>> +	clk->set_state_periodic = gt_clockevent_set_periodic;
>>> +	clk->set_state_oneshot = gt_clockevent_shutdown;
>>
>> nit: it sounds weird to use the same function as the purpose of the
>> patch is use the new API which is to ventilate those functions
>> (anyway ...)
>
> Hmm, but there is no point creating two routines to do exactly the
> same thing. And this is making it evident that we actually shutdown
> the device in oneshot-state request. And enable it only when the next
> event is programmed.

Yes, this is really a detail.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
