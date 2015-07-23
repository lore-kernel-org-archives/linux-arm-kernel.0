From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Jul 2015 00:28:27 -0700
Subject: [PATCH 1/3] ARM: OMAP2+: N900: always enable IBE bit
In-Reply-To: <1437612483-30160-2-git-send-email-sre@kernel.org>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-2-git-send-email-sre@kernel.org>
Message-ID: <20150723072827.GD16878@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [150722 17:50]:
> The kernel's workaround for Errata 430973 consists of a BTAC/BTB
> flush at context switch. This requires the IBE bit being set, which
> should normally be done by the bootloader.
> 
> Since the Nokia N900's bootloader is not easily replaceable,
> a pdata quirk enables the IBE bit for the Nokia N900. Until
> e748994f5cc5, the flush at context switch required
> CONFIG_ARM_ERRATA_430973, so the same check has been used
> for setting the IBE bit.
> 
> Since all sold N900s are assumed to be affected, the guard
> can be removed now, so that the IBE bit is always set.

OK makes sense to me. It's best that you upload these into
Russell's patch tracking system after waiting for some more
comments. Please feel free to add for the whole series:

Acked-by: Tony Lindgren <tony@atomide.com>
