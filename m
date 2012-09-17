From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 18 Sep 2012 00:59:30 +0200
Subject: [PATCH] mfd: Fix compile for twl-core.c by removing cpu_is_omap
 usage
In-Reply-To: <20120917202943.GV4521@atomide.com>
References: <20120917202943.GV4521@atomide.com>
Message-ID: <20120917225930.GV3647@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, Sep 17, 2012 at 01:29:44PM -0700, Tony Lindgren wrote:
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
That's fine with me:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
