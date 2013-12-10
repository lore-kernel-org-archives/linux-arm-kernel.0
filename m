From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 10 Dec 2013 14:33:31 +0800
Subject: questions of cpuidle
In-Reply-To: <52A5D0E0.7050201@linaro.org>
References: <52A5C846.30308@linaro.org> <52A5D0E0.7050201@linaro.org>
Message-ID: <52A6B5BB.3060506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 10:17 PM, Daniel Lezcano wrote:
> 
> Concerning the wake up of the cpu: the cpu disabled the irq and goes to
> sleep, it is up to the firmware to wake up the cpu when an interrupt
> occurs. It will exits its sleep state, call clock_events_notify(EXIT),
> by this way re-switching to the local timer, and then re-enabling the
> local interrupt which leads to the interrupt handler.

Thanks a lots for excellent article and detailed explains!

So, if the firmware is in response to wake up cpu. that means there is a
unit which control the firmware and it can not be power down. Do you
know which unit running the firmware to wake up deep idle CPU.
And does the wake up pass via GIC to CPU? If so, does the GIC need keep
awake when all cpu idle? If not, how the firmware give the interrupt to
CPU? And I am wondering if the deep idle cpu voltage get to near 0.
How the cpu get the interrupt signal?

> 
> There are some more informations in the wiki page [1].
> 
>   -- Daniel
> 
> [1] https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/WakeUpSources


-- 
Thanks
    Alex
