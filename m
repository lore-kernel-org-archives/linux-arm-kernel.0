From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 17 Aug 2011 10:41:44 +0530
Subject: [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON when
	using clockdomain force wakeup
In-Reply-To: <alpine.DEB.2.00.1108161946550.9948@utopia.booyaka.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
	<1310527588-13022-2-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1107150159580.16606@utopia.booyaka.com>
	<4E214267.2090700@ti.com> <4E43E23C.2080207@ti.com>
	<alpine.DEB.2.00.1108120730220.10963@utopia.booyaka.com>
	<alpine.DEB.2.00.1108161946550.9948@utopia.booyaka.com>
Message-ID: <4E4B4D90.9040103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 August 2011 07:17 AM, Paul Walmsley wrote:
>
> Hi everyone
>
> I've updated this patch per my earlier comments and also to apply.
> Please let me know if you have any issues with it ASAP.
>
>
> - Paul
>
> From: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Date: Sat, 13 Aug 2011 08:56:28 +0530
> Subject: [PATCH] [PATCH] OMAP: clockdomain: Wait for powerdomain to be ON
>   when using clockdomain force wakeup
>
> While using clockdomain force wakeup method, not waiting for powerdomain
> to be effectively ON may end up locking the clockdomain FSM until a
> next wakeup event occurs.
>
> One such issue was seen on OMAP4430, where L4_PER was periodically
> getting stuck in in-transition state when transitioning from from OSWR to ON.
>
> This issue was reported and investigated by Patrick Titiano<p-titiano@ti.com>
>
> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> Reported-by: Patrick Titiano<p-titiano@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> [paul at pwsan.com: updated to apply; added transition wait on clkdm_deny_idle();
>   remove two superfluous pwrdm_wait_transition() calls]
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
Thanks Paul. Patch looks good to me.

Regards
Santosh
