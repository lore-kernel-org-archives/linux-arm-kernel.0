From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Dec 2012 14:02:50 +0000
Subject: [PATCH] ARM: decompressor: include CONFIG_DEBUG_LL_INCLUDE
 rather than mach/debug-macro.S
In-Reply-To: <20121210015916.GA30766@S2101-09.ap.freescale.net>
References: <1355104168-30581-1-git-send-email-shawn.guo@linaro.org>
 <20121210015916.GA30766@S2101-09.ap.freescale.net>
Message-ID: <20121210140250.GL14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 09:59:18AM +0800, Shawn Guo wrote:
> On Mon, Dec 10, 2012 at 09:49:28AM +0800, Shawn Guo wrote:
> > Commit 91a9fec (ARM: move debug macros to common location) moves
> > arch/arm/kernel/debug.S and arch/arm/kernel/head.S to
> > CONFIG_DEBUG_LL_INCLUDE, but leaves arch/arm/boot/compressed/head.S
> > still with mach/debug-macro.S.  This causes the following build error
> > on platforms that moved to new DEBUG_LL inclusion mechanism, when
> > arch/arm/boot/compressed/head.S is compiled with DEBUG turned on.
> > 
> >   AS      arch/arm/boot/compressed/head.o
> > arch/arm/boot/compressed/head.S:49:30: fatal error: mach/debug-macro.S: No such file or directory
> > compilation terminated.
> > 
> > Fix the problem by replacing mach/debug-macro.S inclusion with
> > CONFIG_DEBUG_LL_INCLUDE one.
> > 
> > Reported-by: Steev Klimaszewski <steev@genesi-usa.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: stable at vger.kernel.org
> 
> I copied stable with assuming that the patch is not going to catch
> on the final 3.7 release.  If it's not the case or maintainer does not
> think it's a stable material at all, we can just drop the tag.

That worries me a bit because I can see this ending up getting applied to
multiple stable kernel trees, even those without CONFIG_DEBUG_LL_INCLUDE.
So, let's have it in the patch system without the stable tag.

Thanks.
