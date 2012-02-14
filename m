From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Feb 2012 11:14:20 +0000
Subject: [PATCH 2/2] ARM: OMAP4: Move the barrier memboclk_steal() as
 part of reserve callback
In-Reply-To: <4F3A2025.9000609@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
 <20120210191926.GV1426@atomide.com> <4F3A2025.9000609@ti.com>
Message-ID: <20120214111420.GG15338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 02:19:41PM +0530, Santosh Shilimkar wrote:
> >From 4d1ea22985adfe458275b9ae3e00edc6e41a267f Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Thu, 2 Feb 2012 15:59:51 +0530
> Subject: [PATCH 1/2] ARM: OMAP4: Move the barrier memboclk_steal() as
> part of reserve callback
> 
> Commit 716a3dc{ARM: Add arm_memblock_steal() to allocate memory away
> from the kernel} introduced arm_memblock_steal() which lead to
> OMAP4_ERRATA_I688 to be broken and needed to be fixed.

That is misleading.  Please don't attribute blame for this breakage to
that patch, which has nothing to do with introducing the breakage.  The
errata was broken right from the start.
