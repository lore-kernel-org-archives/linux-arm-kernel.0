From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 22:03:54 +0000
Subject: [PATCH v4 05/19] ARM: GIC: remove direct use of gic_raise_softirq
In-Reply-To: <50E5E74C.20008@wwwdotorg.org>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-6-git-send-email-robherring2@gmail.com>
 <50E5E74C.20008@wwwdotorg.org>
Message-ID: <201301032203.54267.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013, Stephen Warren wrote:
> On 01/03/2013 10:54 AM, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > In preparation of moving gic code to drivers/irqchip, remove the direct
> > platform dependencies on gic_raise_softirq. Move the setup of
> > smp_cross_call into the gic code and use arch_send_wakeup_ipi_mask
> > function to trigger wake-up IPIs.
> 
> For all the Tegra-related parts,
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Will this series be put into an arm-soc (or other stable) branch that I
> can pull into any Tegra branches in case there are any merge conflicts?

Yes, I think we should have it in arm-soc, there would be a lot of
nasty conflicts otherwise.

It probably makes sense to also have it in the tip tree if since
Thomas Gleixner as the IRQ maintainer is the owner of this subsystem,
unless he has other preferences.

I would also suggest adding the patch below to the series. Note that
I don't care who is maintaining drivers/irqchip, and Rob might want
to be listed as well, but Thomas mentioned a couple of months ago
that he wanted to get Cc'd on irqchip drivers patches.

8<-----
irqchip: add MAINTAINERS entry for drivers/irqchip

The drivers/irqchip directory now contains generic irqchip drivers,
so it makes sense to add them to the MAINTAINERS entry for the
IRQ subsystem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2a1f6..a828240 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4185,6 +4185,7 @@ M:	Thomas Gleixner <tglx@linutronix.de>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	kernel/irq/
+F:	drivers/irqchip/
 
 IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
