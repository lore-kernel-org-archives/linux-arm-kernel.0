From: khilman@ti.com (Kevin Hilman)
Date: Fri, 09 Sep 2011 14:00:28 -0700
Subject: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
In-Reply-To: <CAC83Zv+=gbt=KTx0ZsxRfL1k4=R7c0CLSCRQ_D+PrNQOso3q-g@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Sat, 10 Sep 2011 00:25:46 +0530")
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
	<CAC83ZvL3Y-4f+nAvFb023JTPcBb-joG8JonujCMJCNUmYrSZaA@mail.gmail.com>
	<87pqj9y4mi.fsf@ti.com>
	<CAC83Zv+=gbt=KTx0ZsxRfL1k4=R7c0CLSCRQ_D+PrNQOso3q-g@mail.gmail.com>
Message-ID: <87ty8ltor7.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Fri, Sep 9, 2011 at 11:34 PM, Kevin Hilman <khilman@ti.com> wrote:
>> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>>
>>> [...]
>>>>>
>>>>> +static const struct dev_pm_ops gpio_pm_ops = {
>>>>> + ? ? .suspend ? ? ? ? ? ? ? ?= omap_gpio_suspend,
>>>>> + ? ? .resume ? ? ? ? ? ? ? ? = omap_gpio_resume,
>>>>> +};
>>>>
>>>> Please use SET_SYSTEM_SLEEP_PM_OPS(). ?See <linux/pm.h>
>>> We can use following macro to initialize .suspend and .resume callbacks.
>>> But how do we initialize .runtime_suspend and .runtime_resume callbacks?
>>>
>>> #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>>> const struct dev_pm_ops name = { \
>>> ? ? ? ? SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>>> }
>>>
>>> Do we have something similar to following where we can assign separate
>>> pair of callbacks?
>>
>> SET_RUNTIME_PM_OPS()
> Yes, I have done this way:
>
> static const struct dev_pm_ops gpio_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(omap_gpio_suspend, omap_gpio_resume)
>         SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
>                                                                         NULL)

Perfect.

Kevin
