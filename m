From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 18:00:25 -0700
Subject: [PATCH v2 01/16] ARM: Make global handler and
	CONFIG_MULTI_IRQ_HANDLER mutually exclusive
In-Reply-To: <1317034955-1029-2-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110928010024.GS6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110926 03:30]:
> Even when CONFIG_MULTI_IRQ_HANDLER is selected, the core code
> requires the arch_irq_handler_default macro to be defined as
> a fallback.
> 
> It turns out nobody is using that particular feature as both PXA
> and shmobile have all their machine descriptors populated with
> the interrupt handler, leaving unused code (or empty macros) in
> their entry-macro.S file just to be able to compile entry-armv.S.
> 
> Make CONFIG_MULTI_IRQ_HANDLER exclusive wrt arch_irq_handler_default,
> which allows to remove one test from the hot path. Also cleanup both
> PXA and shmobile entry-macro.S.
> 
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Tony Lindgren <tony@atomide.com>
