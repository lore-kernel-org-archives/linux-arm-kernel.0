From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 16 May 2011 16:08:44 +0100
Subject: [PATCH 0/1] ARM: thumb: Fix thumb mode compilation problems.
In-Reply-To: <20110513195845.2FFE540CD1@eskimo.mtv.corp.google.com>
References: <20110513195845.2FFE540CD1@eskimo.mtv.corp.google.com>
Message-ID: <20110516150828.GA22931@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 12:58:45PM -0700, Vadim Bendebury wrote:
> 
> This patch won't necessarily apply as it has not been verified on
> a real hardware, so this is more of an RFC.
> 
> Vadim Bendebury (1):
>   ARM: thumb: Fix thumb mode compilation problems.
> 
>  arch/arm/kernel/fiq.c         |   34 ++++++++++++++++++++++++++--------
>  arch/arm/mach-tegra/headsmp.S |    3 ++-
>  2 files changed, 28 insertions(+), 9 deletions(-)
> 

As a side note, I'm happy to be CC'd if you have Thumb-2 kernel problems
since I've been working on this recently, and would like to get it working
across the broadest range of platforms possible.

I'm definitely interested if you hit any non-platform-specific issues, since
I'm not too familiar with tegra.

So far, omap was the most "interesting" target: if you have problems, the
following commits for omap may contain examples of things you need to fix:

git log -i --grep=thumb -- arch/arm/mach-omap2 arch/arm/plat-omap

dd31394 ARM: omap3: Thumb-2 compatibility for sleep34xx.S
ef7a87d ARM: omap3: Thumb-2 compatibility for sram34xx.S
76d5001 ARM: omap3: Remove hand-encoded SMC instructions
f96bdfa ARM: omap4: Convert END() to ENDPROC() for correct linkage with CONFIG_THUMB2_KERNEL
85243a7 ARM: omap4: Provide do_wfi() for Thumb-2
b6338bd ARM: 6649/1: omap: use fncpy to copy the PM code functions to SRAM
