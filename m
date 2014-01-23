From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Thu, 23 Jan 2014 13:16:21 +0000
Subject: [PATCH 19/73] arm: mach-s3c64xx mach-crag6410-module.c is not
 modular
In-Reply-To: <1390339396-3479-20-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-20-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20140123131621.GD11589@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 04:22:22PM -0500, Paul Gortmaker wrote:
> Despite the name mach-crag6410-module.c, the code is built for
> MACH_WLF_CRAGG_6410 -- which is bool, and hence this code is
> either present or absent.  It will never be modular, so using
> module_init as an alias for __initcall can be somewhat
> misleading.
> 
> Fix this up now, so that we can relocate module_init from
> init.h into module.h in the future.  If we don't do this, we'd
> have to add module.h to obviously non-modular code, and that
> would be a worse thing.
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of device_initcall
> directly in this change means that the runtime impact is
> zero -- it will remain at level 6 in initcall ordering.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: patches at opensource.wolfsonmicro.com
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
