From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Nov 2011 09:00:39 +0000
Subject: [PATCH] arm/imx: remove imx_idle hook and use pm_idle instead
In-Reply-To: <1320988158-9409-1-git-send-email-shawn.guo@linaro.org>
References: <1320988158-9409-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111111090039.GB12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 01:09:18PM +0800, Shawn Guo wrote:
> The patch removes imx_idle hook and use pm_idle instead to get imx
> arch_idle prepared for the cleanup.  It's suggested by Russel King
> as below.
> 
> > The final removal of mach/system.h depends on getting rid of the arch_idle
> > thing.  While going through these headers, I was dismayed to find these:
> >
> > arch/arm/mach-s3c2410/include/mach/system.h:void (*s3c24xx_idle)(void);
> > arch/arm/plat-mxc/include/mach/system.h:extern void (*imx_idle)(void);
> >
> > when we have a perfectly good pm_idle hook already in place - so there's
> > no excuse for these especially when other platforms are already using
> > pm_idle to hook their platform specific idle function into.  This is
> > something that better be gone at the next merge window!
> 
> Suggested-by: Russell King <linux@arm.linux.org.uk>

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>

please.

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
