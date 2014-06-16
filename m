From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Jun 2014 07:17:13 -0700
Subject: [PATCH] ARM: omap: rework platform selection
In-Reply-To: <20140616112610.GE17845@atomide.com>
References: <5701099.0P1SIXsHc1@wuerfel> <20140616110042.GD17845@atomide.com>
 <7892694.KrnV5uCBX6@wuerfel> <20140616112610.GE17845@atomide.com>
Message-ID: <20140616141712.GL17845@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140616 04:31]:
> * Arnd Bergmann <arnd@arndb.de> [140616 04:18]:
> > 
> > Let's see if others have similar opinions Rob's patch as a whole.
> > I'd still like to keep all the parts aside from the OMAP change
> > and just back out the change that caused the problems.
> > 
> > Does that seem reasonable to you?
> 
> Yes makes sense to me if others don't have similar issues. I guess
> it should be possible to verify that by diffing the generated
> .config files compared to the old ones.

If you update Rob's patch and undo the omap2+ changes, you might
want to fold in something like the following to hide the omap
options behind a menu.

So far I have not come up with no great ideas on fixing this
properly short of requiring all omap .config files to add
CONFIG_ARCH_OMAP=y manually. Anybody got good ideas for that?

Regards,

Tony

--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -1,3 +1,5 @@
+menu "TI OMAP/AM/DM/DRA Family"
+
 config ARCH_OMAP
 	bool
 
@@ -342,3 +344,5 @@ config OMAP4_ERRATA_I688
 endmenu
 
 endif
+
+endmenu
