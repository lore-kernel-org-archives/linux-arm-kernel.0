From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 18 Jun 2015 09:09:29 +0200
Subject: [PATCH v3] ARM: tegra: cpuidle: implement
 cpuidle_state.enter_freeze()
In-Reply-To: <1773599.T1QStsTFTH@vostro.rjw.lan>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com>
 <1773599.T1QStsTFTH@vostro.rjw.lan>
Message-ID: <CAAObsKCURyo-ujcA7r+UYqSw6ie-aBxKiYEdTKwe-HrL14RkBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 May 2015 at 03:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, May 19, 2015 04:49:12 PM Tomeu Vizoso wrote:
>> This callback is expected to do the same as enter() but it has to
>> guarantee that interrupts aren't enabled at any point in its execution,
>> as the tick is frozen.
>>
>> It will be called when the system goes to suspend-to-idle and will
>> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
>>
>> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
>> for both the enter() and enter_freeze() callbacks.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Makes sense to me, but I suppose it should go in via arm-soc.

Hi Thierry,

what's the plan regarding merging of this patch?

It needs df8d9ee ("cpuidle: Run tick_broadcast_exit() with disabled
interrupts") so it doesn't break boot.

Thanks,

Tomeu
