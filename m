From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 16 Dec 2011 16:25:40 +0100
Subject: [PATCH 1/3] ARM: OMAP2+: kconfig: Enable devicetree by default
 for OMAP2+ systems
In-Reply-To: <20111213223855.GW32251@atomide.com>
References: <y> <1323190149-6492-2-git-send-email-b-cousson@ti.com>
 <1323782836.1877.79.camel@deskari> <4EE75448.4010701@ti.com>
 <20111213223855.GW32251@atomide.com>
Message-ID: <4EEB62F4.2010202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 12/13/2011 11:38 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [111213 05:02]:
>> On 12/13/2011 2:27 PM, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On Tue, 2011-12-06 at 17:49 +0100, Benoit Cousson wrote:
>>>> devicetree will become the mandatory boot method for OMAP2+.
>>>> In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
>>>> select USE_OF by default for every OMAP2+ systems.
>>>> Select as well the APPENDED_DTB and ATAG_DTB_COMPAT to allow legacy
>>>> boot loader to keep working properly.
>>>
>>> APPENDED_DTB sounds a bit dangerous to be enabled by default according
>>> to the config help text.
>>
>> The help is indeed really scary :-)
> 
> Heh, but it's also true.
> 
>> Tony,
>> Do we want to keep it by default? Or should we fix the kconfig help?
> 
> Let's just leave out those two from omap2plus_defconfig then.

Here is the updated version.
Just let me know if you'd like to get the full series re-posted.

Thanks,
Benoit

---
>From b33d4be0213ab0c630b87bd3df77035cbb109cd0 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Thu, 1 Dec 2011 10:21:16 +0100
Subject: [PATCH] ARM: OMAP2+: kconfig: Enable devicetree by default for OMAP2+ systems

devicetree will become the mandatory boot method for OMAP2+.
In order to avoid cluttering the OMAP code with #ifdef CONFIG_OF,
select USE_OF by default for every OMAP2+ systems.

Enable PROC_DEVICETREE as well.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    1 -
 arch/arm/plat-omap/Kconfig  |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b662513..bdd5b68 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -111,7 +111,6 @@ comment "OMAP Board Type"
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP2+ board"
 	depends on ARCH_OMAP2PLUS
-	select USE_OF
 	default y
 	help
 	  Support for generic TI OMAP2+ boards using Flattened Device Tree.
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index aa59f42..734009a 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -24,6 +24,8 @@ config ARCH_OMAP2PLUS
 	select CLKDEV_LOOKUP
 	select GENERIC_IRQ_CHIP
 	select OMAP_DM_TIMER
+	select USE_OF
+	select PROC_DEVICETREE
 	help
 	  "Systems based on OMAP2, OMAP3 or OMAP4"
 
-- 
1.7.0.4
