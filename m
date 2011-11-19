From: nm@ti.com (Menon, Nishanth)
Date: Fri, 18 Nov 2011 18:35:53 -0600
Subject: [PATCH/RESEND #3 1/7] OMAP3+: PM: SR: add suspend/resume handlers
In-Reply-To: <87vcqj62gd.fsf@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
 <1321346765-16633-2-git-send-email-balbi@ti.com> <87vcqj62gd.fsf@ti.com>
Message-ID: <CAOMWX4egSeBfHdD4LHxtvvaQj+MK0ecRrQGdQ+ELDRUz5tFUEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 18:02, Kevin Hilman <khilman@ti.com> wrote:
> Felipe Balbi <balbi@ti.com> writes:
>
>> From: Nishanth Menon <nm@ti.com>
>>
>> SmartReflex should be disabled while entering low power mode due to
>> the following reasons:
> [...]
>
> Nishanth, in the end, didn't you decide to drop this patch?
>

Yes, I did eventually, once we implemented DVFS for GPU, Ducati, HSI,
and other drivers, there was no real way to ensure sequence of suspend
sequencing even after moving this to suspend_noirq. some of the other
reasons:

if I disabled Smartreflex and went to Nominal voltage on MPU, and say
MPU was at "performance" mode of 1.5GHz or so, thermal scenarios got
worse due on hot corner samples - these tend to have higher leakage
and thermal characteristics tend to be more pronounced. The option of
throttling frequency down while suspend was not really a good option
in comparison to switching off smart reflex in the last possible
moment - in pmxxx.c

Regards,
Nishanth Menon
