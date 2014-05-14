From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 May 2014 08:22:07 -0700
Subject: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
In-Reply-To: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140514152206.GB18463@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [140513 07:40]:
> On OMAP4 panda board, there have been several bug reports about boot
> hang and lock-ups with CPU_IDLE enabled. The root cause of the issue
> is missing interrupts while in idle state. Commit cb7094e8 {cpuidle / omap4 :
> use CPUIDLE_FLAG_TIMER_STOP flag} moved the broadcast notifiers to common
> code for right reasons but on OMAP4 which suffers from a nasty ROM code
> bug with GIC, commit ff999b8a {ARM: OMAP4460: Workaround for ROM bug ..},
> we loose interrupts which leads to issues like lock-up, hangs etc.
> 
> Patch reverts commit cb7094 {cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP
> flag} to avoid the issue. With this change, OMAP4 panda boards, the mentioned
> issues are getting fixed. We no longer loose interrupts which was the cause
> of the regression.

Thanks for figuring this regression out. Applying into fixes with Cc
stable.

Regards,

Tony
