From: mgreer@animalcreek.com (Mark A. Greer)
Date: Mon, 26 Nov 2012 14:00:38 -0700
Subject: [PATCH] Don't mark shared helper functions as inline
In-Reply-To: <20121126195742.21126.16500@nucleus>
References: <1353957609-1295-1-git-send-email-Russ.Dill@ti.com>
 <20121126195742.21126.16500@nucleus>
Message-ID: <20121126210038.GA3987@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 11:57:42AM -0800, Mike Turquette wrote:
> Quoting Russ Dill (2012-11-26 11:20:09)
> > The helper functions that access the opaque struct clk should
> > not be marked inline since they are contained in clk.c, but expected
> > to be used by other compilation units. This causes compile errors
> > under gcc-4.7
> > 
> > In file included from arch/arm/mach-omap2/clockdomain.c:25:0:
> > arch/arm/mach-omap2/clockdomain.c: In function ?clkdm_clk_disable?:
> > include/linux/clk-provider.h:338:12: error: inlining failed in call to always_inline ?__clk_get_enable_count?: function body not available
> > arch/arm/mach-omap2/clockdomain.c:1001:28: error: called from here
> > make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> > 
> 

Hi Mike.

> Regardless, I'm still considering this patch.  I've heard many times
> that we should trust the compiler to optimize for us and some folks look
> down on inlining in general.  If anyone has an opinion on removing
> inlines from the common clk core then please do speak up.

You should take a look at "Chapter 15: The inline disease" in
Documentation/CodingStyle.

Mark
--
