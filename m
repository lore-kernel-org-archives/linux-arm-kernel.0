From: khilman@ti.com (Kevin Hilman)
Date: Thu, 26 Apr 2012 13:08:08 -0700
Subject: [PATCH 1/3] ARM: omap2+: set IRQCHIP_SKIP_SET_WAKE for INTC
 interrupts.
In-Reply-To: <20120425030524.7832.52047.stgit@notabene.brown> (NeilBrown's
 message of "Wed, 25 Apr 2012 13:05:24 +1000")
References: <20120425025637.7832.14013.stgit@notabene.brown>
 <20120425030524.7832.52047.stgit@notabene.brown>
Message-ID: <87sjfq9ryv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NeilBrown <neilb@suse.de> writes:

> All interrupts can wake-from-sleep (I think) so it should be
> permissible to call enable_irq_wake().  Setting this flag allows that.
>
> It is needed because without this, an interrupt which is delivered
> during late suspend will get ignored but will not cause suspend to
> abort.
> If enable_irq_wake() is called and succeeds, check_wakuep_irqs()
> will abort the suspend if the interrupt has fired.
>
> Signed-off-by: NeilBrown <neilb@suse.de>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, should I queue this one in my OMAP PM features for v3.5 branch?
or do you want to take it?

Kevin
