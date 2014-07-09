From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Jul 2014 10:47:30 +0100
Subject: [PATCH 0/2] arm: add early_ioremap support
In-Reply-To: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
References: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140709094730.GC9485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 10:39:50AM +0100, Leif Lindholm wrote:
> early_ioremap()/early_memremap() create temporary virtual mappings
> in the fixmap region during boot time. Part of the support now exists
> in core code, but depends on the generic fixmap support.
> 
> This set converts arm to use the generic fixmap support, and adds the
> architecture-specific part of early_ioremap support.
> 
> The fixmap/kmap changes in 3.15 complicated things slightly compared
> to previous iterations of these patches - this version works around
> that by introducing local macros in arm/mm/highmem.c.
> 
> Tested on TC2 and software models, with/without LPAE.
> 
> Mark Salter (2):
>   arm: use generic fixmap.h
>   arm: add early_ioremap support

Curious: why are you sending these patches instead of Mark?

Will
