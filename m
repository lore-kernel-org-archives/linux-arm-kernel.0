From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 17 Sep 2012 22:08:40 +0000 (UTC)
Subject: [PATCH] mfd: Fix compile for twl-core.c by removing cpu_is_omap
 usage
In-Reply-To: <20120917202943.GV4521@atomide.com>
References: <20120917202943.GV4521@atomide.com>
Message-ID: <alpine.DEB.2.00.1209172207480.16117@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Sep 2012, Tony Lindgren wrote:

> Commit 7d7e1eba (ARM: OMAP2+: Prepare for irqs.h removal) broke
> compile for non-omap as include plat/cpu.h was added:
> 
> drivers/mfd/twl-core.c:49:22: fatal error: plat/cpu.h: No such file or directory
> 
> This header was indirectly included earlier when SPARSE_IRQ was not
> set, but does not exist on most platforms.
> 
> Fix the problem by removing the cpu_is_omap usage that should
> not exist in drivers at all. We can do this by adding proper
> clock aliases for the twl-core.c drivers, and drop separate
> handling for cases when clock framework is not available as
> the behaviour will stay the same.
> 
> Note that we need to add a platform device to avoid using the
> i2c provided names that may be different on various omaps.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Samuel, I'd like to queue this via arm-soc as that's where I have
> the breaking patch is if this patch is OK with you.

It would be ideal if I could queue this one, due to the clock dependency.  
Still hoping that we can get the CCF conversion patches in for 3.7.


- Paul
