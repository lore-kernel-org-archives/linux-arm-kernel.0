From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 21 Mar 2012 08:10:40 +0530
Subject: [PATCH v4 RESEND 6/7] gpio/omap: fix incorrect update to
 context.irqenable1
In-Reply-To: <87zkbbywwz.fsf@ti.com>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
 <1332240799-6748-7-git-send-email-tarun.kanti@ti.com>
 <87zkbbywwz.fsf@ti.com>
Message-ID: <CAC83ZvKRbvVU5Qa1jwud0E6WT-DBU1Z1XEweiXay9x+eLcn0hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 11:31 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
>> gpio_mask can be directly set by writing to set_irqenable register
>> without overwriting current value. In order to ensure the same is
>> stored in context.irqenable1, we must read from regs->irqenable
>> instead of overwriting it with gpio_mask.
>
>> The overwriting makes sense only in the second case where irqenable
>> is explicitly read and updated with new gpio_mask before writing it
>> back. However, for consistency reading regs->irqenable into the
>> bank->context.irqenable1 takes care of both the scenarios.
>
> ...except that the code doesn't do this anymore.
Yes.
>
> I like the newer version (I hope so, since I suggested it :), but please
> update the changlog to describe what the code is actually doing.
Sure.
--
Tarun
>
> Thanks,
>
> Kevin
