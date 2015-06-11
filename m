From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Jun 2015 17:53:11 +0200
Subject: [PATCH 6/6] clocksource: em_sti: Migrate to new 'set-state'
 interface
In-Reply-To: <a2be865369ac18c3fb9e014514f4be4d6fc9ebae.1433768426.git.viresh.kumar@linaro.org>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <a2be865369ac18c3fb9e014514f4be4d6fc9ebae.1433768426.git.viresh.kumar@linaro.org>
Message-ID: <5579AEE7.4070104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 03:40 PM, Viresh Kumar wrote:
> Migrate em_sti driver to the new 'set-state' interface provided by
> the clockevents core, the earlier 'set-mode' interface is marked
> obsolete now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> NOTE: This also drops a special check:
>
> 	if (old_mode == CLOCK_EVT_MODE_ONESHOT)
> 		em_sti_stop(p, USER_CLOCKEVENT);
>
> as it doesn't look like that important. This driver only supports
> ONESHOT and we can only move only to SHUTDOWN from ONESHOT and.
> Also on second call (on shutdown), em_sti_stop() would return without
> disabling the device again.
>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
