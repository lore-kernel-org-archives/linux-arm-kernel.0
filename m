From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 Jun 2016 13:05:49 +0000
Subject: [PATCH] irqchip/bcm2836: make bcm2836_smp_boot_secondary static
In-Reply-To: <0c23b47a-f718-1024-c93a-be8b15e2cd48@codethink.co.uk>
References: <1465407697-8116-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160613011852.GI24391@io.lakedaemon.net>
 <0c23b47a-f718-1024-c93a-be8b15e2cd48@codethink.co.uk>
Message-ID: <20160616130549.GE6216@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 01:48:45PM +0100, Ben Dooks wrote:
> On 13/06/16 02:18, Jason Cooper wrote:
> > Hey Ben,
> > 
> > On Wed, Jun 08, 2016 at 06:41:37PM +0100, Ben Dooks wrote:
> >> The bcm2836_smp_boot_secondary() is not declared or used elsewhere
> >> so make it static to fix the following warning:
> >>
> >> drivers/irqchip/irq-bcm2836.c:227:12: warning: symbol 'bcm2836_smp_boot_secondary' was not declared. Should it be static?
> >>
> >> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> >> ---
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Jason Cooper <jason@lakedaemon.net>
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> ---
> >>  drivers/irqchip/irq-bcm2836.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > This, and the rest of the irqchip/ ones, applied to irqchip/misc.
> 
> Thank you, so hopefully it'll be included in -next soon?

hmmm, I just checked myself.  It appears that the series in irqchip/misc
has been in at least two runs of linux-next.  Do you see something
different?

Here's the commit hashes:

$ git ldo --graph v4.7-rc1^..HEAD
*   ebf63bb87f67 (HEAD -> irqchip/for-next, infradead/irqchip/for-next) Merge branch 'irqchip/misc' into irqchip/for-next
|\  
| * df042a5f4ce4 (infradead/irqchip/misc, irqchip/misc) irqchip/vic: Make vic_syscore_ops and vic_of_init static
| * f3142635de32 irqchip/omap-intc: Fix missing <linux/irqchip/irq-omap-intc.h> include
| * 7c034f169973 irqchip/gic-v2m: Fix missing include of <linux/irqchip/arm-gic.h>
| * 2ae9add9d82d irqchip/brcmstb-l2: Make of probe function static
| * dde7e6d1abdc irqchip/bcm7120-l2: Make probe functions static
| * 1eeb67362d93 irqchip/bcm2836: Make bcm2836_smp_boot_secondary static
| * 6c880902419e irqchip/armada-370-xp: Make syscore_ops static
| * f6fbaaa4c0fc irqchip/tegra: Fix sparse warnings on __iomem
| * 4a3691ccb3ce irqchip/sirfsoc: Fix sparse warnings on __iomem
* | d7e3528eed85 (infradead/irqchip/bcm, irqchip/bcm) irqchip: bcm2835: Avoid arch/arm-specific handle_IRQ
|/  
* 1a695a905c18 (tag: v4.7-rc1, linux-phy/next, infradead/irqchip/urgent, infradead/irqchip/core, arm-soc/master, irqchip/urgent, irqchip/core) Linux 4.7-rc1

hth,

Jason.
