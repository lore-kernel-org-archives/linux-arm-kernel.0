From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 14 Sep 2015 10:42:09 -0700
Subject: [PATCH 6/7] ARM: brcmstb: mask GIC IRQs on suspend
In-Reply-To: <55F482BC.4050202@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
 <1434672696-13632-7-git-send-email-computersforpeace@gmail.com>
 <55F482BC.4050202@gmail.com>
Message-ID: <20150914174209.GQ11487@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing:

On Sat, Sep 12, 2015 at 12:53:32PM -0700, Florian Fainelli wrote:
> Le 06/18/15 17:11, Brian Norris a ?crit :
> > Lazily-masked IRQs can cause system suspend problems (e.g., spurious
> > wakeups from WFI), so we need to be sure non-wakeup GIC interrupts get
> > masked, not just disabled, during system suspend.
> > 
> > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> 
> Dropped this patch, no longer needed as of 4.3-rc0 with
> aec89ef72ba6c94420f599dcb684ed66937cdacf ("irqchip/gic: Enable
> SKIP_SET_WAKE and MASK_ON_SUSPEND")

With this patch dropped, then we really don't need
arch/arm/mach-bcm/brcmstb.c any more, AFAICT. Unless you have more plans
for this file, I can send a patch...

Brian
