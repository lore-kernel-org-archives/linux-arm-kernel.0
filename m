From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2012 11:59:14 +0000
Subject: [PATCH] ARM: S3C24XX: Fix build error for missing
 <mach/system-reset.h>
In-Reply-To: <010101cccd32$2cf0cfe0$86d26fa0$%kim@samsung.com>
References: <010101cccd32$2cf0cfe0$86d26fa0$%kim@samsung.com>
Message-ID: <20120107115914.GE13857@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2012 at 08:47:47PM +0900, Kukjin Kim wrote:
> Since the arch/arm/mach-s3c2410/include/mach/system-reset.h has
> been removed by commit f88b8979 ("ARM: restart: remove the now
> empty arch_reset()"), so the inclusion of <mach/system-reset.h>
> should be removed at the plat-s3c24xx/cpu.c file.
> 
> The build error happens like following:
>   arch/arm/plat-s3c24xx/cpu.c:41: fatal error: mach/system-reset.h: No such file or directory
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Russell,
> 
> I think, you missed removing this in your patch.

This rather proves the point that the way Samsung stuff is organized is
just too complicated to be properly understood.  Yes, it's getting better
as a result of some of the points I raised, but I feel its still too
opaque for anyone except those who know it intimiately to get to grips
with it properly, and follow how the code is organized through all those
plat-* and mach-* directories.

> If you have patches to send to Linus for this merge window,
> could you please send this together? Or...?

Please put it in the patch system and I'll queue it up.  Thanks.
