From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 20:36:06 -0700
Subject: [PATCH 07/12] ARM: shmobile: r8a7740: Add OF support to
 initialze the GIC
In-Reply-To: <1369645193-3595-8-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-8-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130528033606.GH13532@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 27, 2013 at 05:59:48PM +0900, Simon Horman wrote:
> From: Bastian Hecht <hechtb@gmail.com>
> 
> We add a variant to initalize the interrupt controller in case we describe
> the GIC using the Device Tree and not platform data.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
>  arch/arm/mach-shmobile/intc-r8a7740.c         |   24 ++++++++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
> index abdc4d4..19c0423 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
> @@ -534,6 +534,7 @@ enum {
>  
>  extern void r8a7740_meram_workaround(void);
>  extern void r8a7740_init_irq(void);
> +extern void r8a7740_init_irq_of(void);
>  extern void r8a7740_map_io(void);
>  extern void r8a7740_add_early_devices(void);
>  extern void r8a7740_add_standard_devices(void);

This is not a comment on this patch per se, but this header file should
probably be directly under the mach directory instead of under include/mach.

In particular, if/when the shmobile platforms get converted to
multiplatform, the header file has to move. And I see that most of these
functions are only used locally in that directory anyway.

It'd be nice to see some of that addressed by 3.12 or so, if you have a chance.


-Olof
