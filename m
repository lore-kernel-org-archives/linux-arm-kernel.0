From: srinidhi.kasagar@stericsson.com (srinidhi)
Date: Tue, 17 Aug 2010 16:37:49 +0530
Subject: [PATCH 4/4] omap: Fix SMP on UP interrupt handling for multi-omap
In-Reply-To: <20100817105332.19061.44765.stgit@baageli.muru.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100817105332.19061.44765.stgit@baageli.muru.com>
Message-ID: <1282043269.32205.13.camel@bnru01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-17 at 12:53 +0200, Tony Lindgren wrote:
> Fix SMP on UP interrupt handling for multi-omap
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/include/mach/entry-macro.S |   22 ++++++++++++++++++++++
>  arch/arm/mach-omap2/omap-smp.c                 |   16 ++++++++++++----
>  arch/arm/mach-omap2/timer-gp.c                 |    7 +++++--
>  3 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> index 06e64e1..75c67aa 100644
> --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S

There is one patch lying in Russell's tracker (6284/1) which attempts to
use the common IRQ helper macros instead of platforms duplicating this
file. Perhaps you may need to re-base to that if Russell is ok with that
patch, of course.

srinidhi
