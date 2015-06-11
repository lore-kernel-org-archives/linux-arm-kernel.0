From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 11 Jun 2015 20:26:54 +0530
Subject: [PATCH 2/6] clocksource: arm_global_timer: Migrate to new
 'set-state' interface
In-Reply-To: <5579A011.8030900@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <54f346e663f605e2f078a3114de85ba281d1e6d0.1433768426.git.viresh.kumar@linaro.org>
 <5579A011.8030900@linaro.org>
Message-ID: <20150611145654.GB4386@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-06-15, 16:49, Daniel Lezcano wrote:
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks :)

> >-	clk->set_mode = gt_clockevent_set_mode;
> >+	clk->set_state_shutdown = gt_clockevent_shutdown;
> >+	clk->set_state_periodic = gt_clockevent_set_periodic;
> >+	clk->set_state_oneshot = gt_clockevent_shutdown;
> 
> nit: it sounds weird to use the same function as the purpose of the
> patch is use the new API which is to ventilate those functions
> (anyway ...)

Hmm, but there is no point creating two routines to do exactly the
same thing. And this is making it evident that we actually shutdown
the device in oneshot-state request. And enable it only when the next
event is programmed.

-- 
viresh
