From: khilman@ti.com (Kevin Hilman)
Date: Thu, 16 Jun 2011 08:22:19 -0700
Subject: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
In-Reply-To: <1308229940-27025-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Thu, 16 Jun 2011 18:42:20 +0530")
References: <1308229940-27025-1-git-send-email-premi@ti.com>
Message-ID: <877h8lsswk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanjeev,

Sanjeev Premi <premi@ti.com> writes:

> When multiple wakeup sources are defined in a system,
> there is a small window, when more than one source
> can trigger wakeup interrupt.
>
> In the current implementation, the do-while() loop
> can handle all wakeup sources that are recorded when
> probing the status register in prcm_interrupt_handler().
>
> When the ISR executes due to next queued wakeup, it
> there is nothing to be handled and value of "c" is 0.

Thanks for tracking this one down.

However, It's still not clear to me what is happening here.

Why is the IRQ firing if there is nothing to be handled?  That suggests
to me that the IRQ status is not properly being cleared.

Kevin
