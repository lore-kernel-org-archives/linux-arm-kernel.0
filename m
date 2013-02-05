From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 14:11:25 -0800
Subject: Latest additional build warnings
In-Reply-To: <20130205175126.GH25185@atomide.com>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
 <20130205175126.GH25185@atomide.com>
Message-ID: <20130205221125.GB13768@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 09:51:26AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [130205 06:25]:
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> > arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used
> 
> Thanks looks like I missed that one somehow. Here's a fix for
> it.
> 
> Arnd & Olof, care to apply this directly into the arm-soc multiplatform
> branch?
> 
> Regards,
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 5 Feb 2013 09:48:08 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix warning for hwspinlock omap_postcore_initcall
> 
> Commit 816a65ef4 (ARM: OMAP2+: Limit omap initcalls to omap only on
> multiplatform kernels) fixed up things for multiplatform booting
> but failed to include soc.h causing a new warning:
> 
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used
> 
> Reported-by: Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied to next/multiplatform with the reported-by line fixed up.


-Olof
