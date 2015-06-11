From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Jun 2015 18:13:59 +0200
Subject: [PATCH 3/6] clocksource: bcm2835: Migrate to new 'set-state'
 interface
In-Reply-To: <20150611160048.GC4386@linux>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <b0bf70d911dffe170b0d2b2b3e680bb445c15fc4.1433768426.git.viresh.kumar@linaro.org>
 <5579A864.5010500@linaro.org> <20150611160048.GC4386@linux>
Message-ID: <5579B3C7.5030305@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2015 06:00 PM, Viresh Kumar wrote:
> On 11-06-15, 17:25, Daniel Lezcano wrote:
>> Please mention in the log you removed the RESUME because it does
>> nothing and the core code will just ignore it.
>
> Okay.
>
>> The patch is ok but there is an inconsistency on how are handled the
>> different callbacks. tick_resume can be omitted but not
>> state_shutdown and state_oneshot forcing the drivers to define empty
>> functions.
>
> It was done because they are thought to be compulsory, but even I
> am not sure if we should make all callbacks as optional.

Yes, I think it would make sense to ignore NULL callback in 
__clockevents_set_state, otherwise we will end up to fill the different 
drivers with duplicated noop functions.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
