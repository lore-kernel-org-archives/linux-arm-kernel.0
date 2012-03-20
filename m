From: khilman@ti.com (Kevin Hilman)
Date: Tue, 20 Mar 2012 11:01:00 -0700
Subject: [PATCH v4 RESEND 6/7] gpio/omap: fix incorrect update to
 context.irqenable1
In-Reply-To: <1332240799-6748-7-git-send-email-tarun.kanti@ti.com> (Tarun
 Kanti DebBarma's message of "Tue, 20 Mar 2012 16:23:18 +0530")
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com>
 <1332240799-6748-7-git-send-email-tarun.kanti@ti.com>
Message-ID: <87zkbbywwz.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
> gpio_mask can be directly set by writing to set_irqenable register
> without overwriting current value. In order to ensure the same is
> stored in context.irqenable1, we must read from regs->irqenable
> instead of overwriting it with gpio_mask.

> The overwriting makes sense only in the second case where irqenable
> is explicitly read and updated with new gpio_mask before writing it
> back. However, for consistency reading regs->irqenable into the
> bank->context.irqenable1 takes care of both the scenarios.

...except that the code doesn't do this anymore.

I like the newer version (I hope so, since I suggested it :), but please
update the changlog to describe what the code is actually doing.

Thanks,

Kevin
