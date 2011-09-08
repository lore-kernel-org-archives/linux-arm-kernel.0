From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 18:45:32 +0200
Subject: [PATCH v2 1/3] ARM: iwmmxt: Fix Makefile rules for building
	iwmmxt for Thumb-2
In-Reply-To: <1315497854-13311-2-git-send-email-dave.martin@linaro.org>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-2-git-send-email-dave.martin@linaro.org>
Message-ID: <201109081845.33117.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011, Dave Martin wrote:
> Because gcc/gas have no sane way to turn on individual CPU
> extensions from the command-line, iwmmxt.S was previously built
> with -mcpu=iwmmxt.  Unfortunately, this also downgrades the CPU to
> v5, with the result that this file fails to build for a Thumb-2
> kernel.
> 
> New versions of the tools support -march=<base arch>+iwmmxt, and it
> seems reasonable to require up-to-date tools when building in
> Thumb-2.  So, this patch uses -march=armv7-a+iwmmxt for
> CONFIG_THUMB2_KERNEL=y.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Ok. More complex than I would have liked, but this definitely does
the right thing in every case, as far as I can tell.

Acked-by: Arnd Bergmann <arnd@arndb.de>
