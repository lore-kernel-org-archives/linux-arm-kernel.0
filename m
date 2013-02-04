From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Feb 2013 16:01:33 +0000
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130204160133.GH17786@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 10:45:20AM +0800, Shawn Guo wrote:
> Instead of giving zero support of uncompress debug for multiplatform
> build, the patch turns uncompress debug into one part of DEBUG_LL
> support.  When DEBUG_LL is turned on for a particular platform,
> uncompress debug works too for that platform.
> 
> It reuses the platform DEBUG_LL macros by creating a simple
> arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
> included there, and implements a generic putc() using those macros.

Ok, I've applied this on the previso that _no one_ in future whinges if
the debug infrastructure doesn't quite meet their expectation.  The
debug infrastructure remains first and foremost that: a simple debug
infrastructure suitable for use in the early assembly and the like.

That is its primary concern and trumps any requirements from consoles,
early printk, decompressor output, and the like.
