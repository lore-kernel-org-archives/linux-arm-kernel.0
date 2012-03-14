From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Mar 2012 11:28:58 -0400 (EDT)
Subject: [PATCH v3 3/5] ARM: force branch instructions to use long distance
 encoding
In-Reply-To: <1331720516-11801-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120314101928.GA29474@pengutronix.de>
 <1331720516-11801-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1203141126470.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Mar 2012, Uwe Kleine-K?nig wrote:

> This fixes a linker error when the kernel image gets bigger than approx.
> 1 MiB.
> 
> This is done analogous to the change to head.S in commit
> 
> 	a75e524 (ARM: 6504/1: Thumb-2: Fix long-distance conditional 
branches in head.S for Thumb-2.)
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/kernel/head-nommu.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index d46f259..1aca35d 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -51,6 +51,7 @@ ENTRY(stext)
>  #endif
>  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
>  	movs	r10, r5				@ invalid processor (r5=0)?
> +	it	eq

Like in the other cases, please add a short comment on that line 
justifying it, otherwise it may look redundant.


Nicolas
