From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Jan 2015 12:12:54 -0800
Subject: [PATCH v2] ARM: OMAP: Work around hardcoded interrupts
In-Reply-To: <20150119201404.GA18738@kahuna>
References: <1421490068-20385-1-git-send-email-marc.zyngier@arm.com>
 <20150119201404.GA18738@kahuna>
Message-ID: <20150119201253.GF18552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150119 12:17]:
> On 10:21-20150117, Marc Zyngier wrote:
> > Commit 9a1091ef0017 (irqchip: gic: Support hierarchy irq domain)
> should have been
> Commit 9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain")
> 
> > changed the GIC driver to use a non-legacy IRQ domain on DT
> > platforms. This patch assumes that DT-driven systems are getting
> > all of their interrupts from device tree.
> > 
> > Turns out that OMAP has quite a few hidden gems, and still uses
> > hardcoded interrupts despite having fairly complete DTs.
> > 
> > This patch attempts to work around these by offering a translation
> > method that can be called directly from the hwmod code, if present.
> > The same hack is sprinkled over PRCM and TWL.
> > 
> > It isn't pretty, but it seems to do the job without having to add
> > more hacks to the interrupt controller code.
> > 
> > Tested on OMAP4 (Panda-ES) and OMAP5 (UEVM5432).
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Other than that, This looks good to me.
> Acked-by: Nishanth Menon <nm@ti.com>

OK thanks applying into omap-for-v3.19/fixes and will send out a
pull request later on today after some make randconfig builds.

Regards,

Tony
