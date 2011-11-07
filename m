From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 7 Nov 2011 09:45:15 +0000
Subject: [PATCH v3 01/17] ARM: Make global handler and
 CONFIG_MULTI_IRQ_HANDLER mutually exclusive
In-Reply-To: <1320425871-30564-2-git-send-email-marc.zyngier@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
 <1320425871-30564-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20111107094515.GA6939@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Fri, Nov 04, 2011 at 04:57:35PM +0000, Marc Zyngier wrote:
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

Tested-by: Jamie Iles <jamie@jamieiles.com>

My VIC patches are using this so if it goes in through the GIC patches 
first then that would be great!

Thanks,

Jamie
