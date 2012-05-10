From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 10 May 2012 08:33:39 +0000
Subject: [GIT PULL] ARM: OMAP2+: Misc cleanup
In-Reply-To: <20120508183414.GZ5088@atomide.com>
References: <1336461259-28596-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508183414.GZ5088@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1F2D1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 00:04:14, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120508 00:18]:
> > Tony,
> > 
> > Please pull the following preparatory cleanup series to add OMAP5 minimal
> > support. Boot tested on OMAP2430 SDP, OMAP3430 SDP and OMAP4430 SDP platforms.
> > 
> > I have dropped {[PATCH 7/7] ARM: OMAP4+: Add prm and cm base init function}
> > from this set since Paul is taking that one in his queue.
> 
> OK thanks, pulling this into cleanup-soc and merging into cleanup branch
> with what we have in devel-hwmod.
>  
Tony,


Just observed that, while merging cleanup-soc into cleanup branch you have 
missed couple of lines from Satosh's original patch. Which leads to build 
break on OMAP2 alone build.

Can you please merge below change,

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 833f153..c82783a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -122,6 +122,8 @@ obj-$(CONFIG_SOC_AM33XX)            += $(powerdomain-common)
 clockdomain-common                     += clockdomain.o
 clockdomain-common                     += clockdomains_common_data.o
 obj-$(CONFIG_ARCH_OMAP2)               += $(clockdomain-common)
+obj-$(CONFIG_ARCH_OMAP2)               += clockdomain2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP2)               += clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_SOC_OMAP2420)             += clockdomains2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)             += clockdomains2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)               += $(clockdomain-common)


Thanks,
Vaibhav
