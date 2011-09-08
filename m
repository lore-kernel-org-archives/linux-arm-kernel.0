From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 8 Sep 2011 18:14:58 +0100
Subject: [PATCH v2 1/3] ARM: iwmmxt: Fix Makefile rules for building
	iwmmxt for Thumb-2
In-Reply-To: <201109081845.33117.arnd@arndb.de>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-2-git-send-email-dave.martin@linaro.org>
	<201109081845.33117.arnd@arndb.de>
Message-ID: <20110908171457.GF2070@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 06:45:32PM +0200, Arnd Bergmann wrote:
> On Thursday 08 September 2011, Dave Martin wrote:
> > Because gcc/gas have no sane way to turn on individual CPU
> > extensions from the command-line, iwmmxt.S was previously built
> > with -mcpu=iwmmxt.  Unfortunately, this also downgrades the CPU to
> > v5, with the result that this file fails to build for a Thumb-2
> > kernel.
> > 
> > New versions of the tools support -march=<base arch>+iwmmxt, and it
> > seems reasonable to require up-to-date tools when building in
> > Thumb-2.  So, this patch uses -march=armv7-a+iwmmxt for
> > CONFIG_THUMB2_KERNEL=y.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Ok. More complex than I would have liked, but this definitely does
> the right thing in every case, as far as I can tell.

Actually, there is still one problem, which is that the errors/warnings
will be triggered even if iwmmxt is not being built.

This is straightforward to work around, and I have a local fix for it
which I'll incorporate in v3.

> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks

I certainly agree with the comment about complexity -- if anyone
has any better ideas, I'm still interested...

We should eventually be able to get rid of this, but not for years
(until currentl binutils versions are effecitvely obsolete).

Cheers
---Dave
