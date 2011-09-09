From: khilman@ti.com (Kevin Hilman)
Date: Fri, 09 Sep 2011 11:04:05 -0700
Subject: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
In-Reply-To: <CAC83ZvL3Y-4f+nAvFb023JTPcBb-joG8JonujCMJCNUmYrSZaA@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Fri, 9 Sep 2011 18:02:33 +0530")
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
	<CAC83ZvL3Y-4f+nAvFb023JTPcBb-joG8JonujCMJCNUmYrSZaA@mail.gmail.com>
Message-ID: <87pqj9y4mi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> [...]
>>>
>>> +static const struct dev_pm_ops gpio_pm_ops = {
>>> + ? ? .suspend ? ? ? ? ? ? ? ?= omap_gpio_suspend,
>>> + ? ? .resume ? ? ? ? ? ? ? ? = omap_gpio_resume,
>>> +};
>>
>> Please use SET_SYSTEM_SLEEP_PM_OPS(). ?See <linux/pm.h>
> We can use following macro to initialize .suspend and .resume callbacks.
> But how do we initialize .runtime_suspend and .runtime_resume callbacks?
>
> #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
> const struct dev_pm_ops name = { \
>         SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> }
>
> Do we have something similar to following where we can assign separate
> pair of callbacks?

SET_RUNTIME_PM_OPS()

Kevin
