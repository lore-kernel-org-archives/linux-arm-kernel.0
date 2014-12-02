From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 02 Dec 2014 13:37:59 +0000
Subject: [PATCH v8 1/4] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <CAMuHMdWj0Z66fya=7oN=ZUoz0TQOHFxBe0wyHmkDDVzU8Lafog@mail.gmail.com>
References: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>	<1416902662-19281-2-git-send-email-yingjoe.chen@mediatek.com>
 <CAMuHMdWj0Z66fya=7oN=ZUoz0TQOHFxBe0wyHmkDDVzU8Lafog@mail.gmail.com>
Message-ID: <547DC0B7.6050600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/14 13:27, Geert Uytterhoeven wrote:
> On Tue, Nov 25, 2014 at 9:04 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>> Add support to use gic as a parent for stacked irq domain.
>>
>> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> 
> This change (which is now in -next as commit 9a1091ef0017c40a) breaks
> booting on r8a7740/armadillo-legacy.
> 
> It hangs because the timers cannot get their interrupts:
> 
> console [tty0] enabled
>  sh-tmu.0: ch0: used for clock events
>  sh-tmu.0: ch0: used for periodic clock events
>  sh-tmu.0: ch0: failed to request irq 230
>  sh-tmu.0: ch1: used as clock source
>  sh-cmt-48.1: ch0: failed to request irq 90
>  sh-cmt-48.1: ch0: registration failed
> earlytimer: unable to probe sh-cmt-48 early.
> Calibrating delay loop...

Grmbl... Are you, by any (lack of) chance, using a setup where the GIC
is probed via DT, but the timers have their IRQs hardcoded?

	M.
-- 
Jazz is not dead. It just smells funny...
