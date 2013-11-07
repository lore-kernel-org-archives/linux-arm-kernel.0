From: olof@lixom.net (Olof Johansson)
Date: Thu, 7 Nov 2013 11:48:08 -0800
Subject: [PATCH v2] serial: omap: Add support for optional wake-up
In-Reply-To: <20131107194553.GL15154@atomide.com>
References: <20131022134947.GK15154@atomide.com> <87siv8rqmj.fsf@linaro.org>
 <20131107194553.GL15154@atomide.com>
Message-ID: <CAOesGMhoA3_ZcdsgANqrpY+U0uNiszOe3RUDk6hDNZ1+HMsTCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 11:45 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Kevin Hilman <khilman@linaro.org> [131107 10:53]:
>>
>> A bunch of DT boot failures on OMAP3 platforms with latest mainline were
>> bisected down to this patch.  Boot results here:
>> http://lists.linaro.org/pipermail/kernel-build-reports/2013-November/000954.html
>>
>> This doesn't seem to properly handle the OMAP3 case where we have DT
>> nodes, but no reg or interrupts properties since they're still using
>> hwmod.
>>
>> The problems seems to be because these OMAP3 platforms don't list any
>> interrupts in their DTS files for the UARTs, but a quick hack at adding
>> interrupts to omap3.dtsi didn't help either so something else is going
>> on.
>>
>> This patch should probably be reverted until it gets broader testing.
>
> Hmm I'm not seeing this with my tree, and sounds like it should be
> already fixed by commit d7c8f2596 (ARM: dts: Add missing reg,
> interrupt and dma entries for omap3).
>
> Can you check that you have that commit in your tree?

Ah, that explains why we haven't seen it in -next.

We should probably queue up our branches for Linus to merge ASAP,
that'll take care of it.


-Olof
