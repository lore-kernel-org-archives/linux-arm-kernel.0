From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Feb 2013 10:34:21 +0530
Subject: [PATCH 4/4] ARM: timer-sp: Set dynamic irq affinity
In-Reply-To: <CAKohpomj1mueL9NETb1xfXTpnKnXCtb9Secu3q5vZTS9dJd0Vg@mail.gmail.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org>
 <1361917047-29230-5-git-send-email-daniel.lezcano@linaro.org>
 <512D91E8.6050706@ti.com>
 <CAKohpomj1mueL9NETb1xfXTpnKnXCtb9Secu3q5vZTS9dJd0Vg@mail.gmail.com>
Message-ID: <512D93D5.3010501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 February 2013 10:29 AM, Viresh Kumar wrote:
> On 27 February 2013 10:26, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> On Wednesday 27 February 2013 03:47 AM, Daniel Lezcano wrote:
>>>
>>> From: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>> When a cpu goes to a deep idle state where its local timer is shutdown, it
>>> notifies the time frame work to use the broadcast timer instead.
>>>
>>> Unfortunately, the broadcast device could wake up any CPU, including an
>>> idle one
>>> which is not concerned by the wake up at all.
>>>
>> Broad-cast device will only open the CPU for which the timer IRQ
>> affined to. And infact with subject series the affinity also is
>> updated for the CPU which owns the last timer expiry event.
>>
>> What am I missing here ?
>
> Dynamic affinity will work only if the following flag is set for a
> clock_event_device: CLOCK_EVT_FEAT_DYNIRQ, otherwise wakeup
> would happen on the cpu to which static affinity was set to.
>
I should have looked at the patches in order first :)
Sorry for the noise.

Regards,
Santosh
