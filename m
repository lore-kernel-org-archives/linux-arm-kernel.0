From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 16 Apr 2012 07:18:11 +0000
Subject: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
In-Reply-To: <alpine.DEB.2.00.1204130440390.25832@utopia.booyaka.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204130440390.25832@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83E9EDCA9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 16:13:07, Paul Walmsley wrote:
> Hi Vaibhav,
> 
> On Fri, 13 Apr 2012, Hiremath, Vaibhav wrote:
> 
> > Yes, we are using am3517evm file for AM33XX MACHINE_INIT definition here.
> > These patches have been reviewed and accepted in the list, only thing is
> > they couldn't make it to upstream during v3.4 merge window.
> > 
> > I believe Tony is going to push them for v3.5 now.
> 
> Hmm, but if you modify the AM3517EVM board file to call 
> am33xx_init_early(), won't that break the AM3517EVM board?
> Wouldn't a separate board file be needed for the AM33xx?
> 
Paul,
It has been taken care of in Makefile,

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 49f92bc..f51ce0b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -236,6 +236,7 @@ obj-$(CONFIG_MACH_CRANEBOARD)               += board-am3517crane.o
 obj-$(CONFIG_MACH_SBC3530)             += board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)           += board-ti8168evm.o
 obj-$(CONFIG_MACH_TI8148EVM)           += board-ti8168evm.o
+obj-$(CONFIG_MACH_AM335XEVM)           += board-am3517evm.o


Thanks,
Vaibhav

> 
> - Paul
> 
