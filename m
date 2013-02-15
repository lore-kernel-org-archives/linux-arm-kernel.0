From: mporter@ti.com (Matt Porter)
Date: Fri, 15 Feb 2013 14:45:48 -0500
Subject: randconfig errors
In-Reply-To: <c01a8ed845054b9d9cbddb341bac5f0e@DLEE74.ent.ti.com>
References: <511E6FA4.2000709@gmail.com>
 <c01a8ed845054b9d9cbddb341bac5f0e@DLEE74.ent.ti.com>
Message-ID: <20130215194548.GC2244@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 06:00:36PM +0000, Arnd Bergmann wrote:
> On Friday 15 February 2013, Rob Herring wrote:
> > Errors from randconfig builds restricted to multi-platform configs on
> > the current linux-next. I know I've seen a fix on the first one from
> > Arnd, but have not investigated any of these.
> 
> I have seen some of these before with the allyesconfig builds.
> Investigating randconfig is on my list for next week.
> 
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/kernel/arch_timer.c:55:11: error: 'ENXIO' undeclared (first use in this function)
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-imx/mach-imx6q.c:248:2: error: implicit declaration of function 'of_init_opp_table' [-Werror=implicit-function-declaration]
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/omap_hwmod_reset.c:47:11: error: 'EINVAL' undeclared (first use in this function)
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:118:19: error: redefinition of 'soc_is_omap'
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:184:1: error: redefinition of 'is_omap24xx'
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:185:1: error: redefinition of 'is_omap34xx'
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:186:1: error: redefinition of 'is_omap44xx'
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/arch/arm/mach-omap2/soc.h:187:1: error: redefinition of 'is_am35xx'
> 
> Patch is queued in arm-soc now.
> 
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/clk/clk-vt8500.c:160:24: error: 'prate' undeclared (first use in this function)
> 
> I've seen this one with allyesconfig but have not tried to make a fix
> 
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/crypto/omap-aes.c:363:2: error: implicit declaration of function 'dma_request_slave_channel_compat' [-Werror=implicit-function-declaration]
> > /var/lib/jenkins/jobs/linux-randconfig/workspace/drivers/crypto/omap-sham.c:1707:2: error: implicit declaration of function 'dma_request_slave_channel_compat' [-Werror=implicit-function-declaration]
> 
> These are waiting for a patch from Matt Porter, "[PATCH v7 07/10] dmaengine: add
> dma_request_slave_channel_compat()". Matt, what is your plan for this? I assume
> it's too late to get the entire series into 3.9, but you have Vinod's Ack on this
> one, and it should probably get merged early on because of the other subsystems
> that are not tracking their dependencies ;-)

Yeah, probably too late for the dmaengine edma series. I need to update to
fix the first patch bisect issues and the DT portions lack an ack from Rob
or Grant. 

I'd be happy to see at least the compat() patch be picked up. Chris had
to drop the omap_hsmmc dt dmaengine patches until that one is merged. I'm
not sure whose tree that one should go through at this point...perhaps
via Chris' tree now?

-Matt
