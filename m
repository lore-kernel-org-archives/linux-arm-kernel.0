From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 26 Jul 2013 17:11:08 -0600
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726215859.GA19469@glitch>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
 <20130726215859.GA19469@glitch>
Message-ID: <20130726231108.GA10812@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 11:59:00PM +0200, Domenico Andreoli wrote:

> In mach-bcm we (or I, it's not very clear to me) want to have support for
> multiple SoCs.
> 
> In trying the approach
> 
> machine-$(CONFIG_ARCH_BCM)		+= bcm
> machine-$(CONFIG_ARCH_BCM4760)		+= bcm
> 
> I got linker complains about multiple symbol definitiion in case both the
> config options are selected.

You can't repeat the same dir. Maybe this?

bcm-machine-$(CONFIG_ARCH_BCM) := bmc
bcm-machine-$(CONFIG_ARCH_BCM4760) := bmc
machine-y += $(bcm-machine-y)

Regards,
Jason
