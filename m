From: tony@atomide.com (Tony Lindgren)
Date: Sun, 10 Jun 2012 23:48:55 -0700
Subject: [PATCH] ARM: OMAP2+: cpu: Add am33xx device under
 cpu_class_is_omap2
In-Reply-To: <4FD593E9.402@ti.com>
References: <1339253773-24088-1-git-send-email-hvaibhav@ti.com>
 <20120611063816.GU12766@atomide.com> <4FD593E9.402@ti.com>
Message-ID: <20120611064855.GW12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120610 23:49]:
> On 6/11/2012 12:08 PM, Tony Lindgren wrote:
> >* Vaibhav Hiremath <hvaibhav@ti.com> [120609 08:00]:
> >>Newly added AM33XX device falls under omap2 class, so
> >>make cpu_class_is_omap2() true for AM33XX
> >>(Add soc_is_am33xx() check).
> >>
> >>Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> >>---
> >>  arch/arm/plat-omap/include/plat/cpu.h |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >>diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> >>index 14f050f..5e36564 100644
> >>--- a/arch/arm/plat-omap/include/plat/cpu.h
> >>+++ b/arch/arm/plat-omap/include/plat/cpu.h
> >>@@ -375,7 +375,7 @@ IS_OMAP_TYPE(3430, 0x3430)
> >>  #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
> >>  				cpu_is_omap16xx())
> >>  #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
> >>-				cpu_is_omap44xx())
> >>+				cpu_is_omap44xx() || soc_is_am33xx())
> >>  /* Various silicon revisions for omap2 */
> >>  #define OMAP242X_CLASS		0x24200024
> >I think this can be now simply !cpu_class_is_omap1() as there is
> >a very slim chance that we'll ever be compiling omap1 and omap2+ together
> >because of the different compiler flags needed.
> >
> >Regards,
> >
> >Tony
> 
> Ok...
> 
> Shall I submit patch with this change?

Yes thanks.

Tony
