From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Jun 2015 15:02:38 -0700
Subject: [PATCH RESEND] mach-omap2:Remove unnessary return statement from
 the void function, omap2_show_dma_caps
In-Reply-To: <1432825205-4663-1-git-send-email-xerofoify@gmail.com>
References: <1432825205-4663-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20150601220237.GI30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicholas Krause <xerofoify@gmail.com> [150528 08:06]:
> This removes the no longer required return statement at the end
> of the void function, omap2_show_dma_cap due to no need for a
> return statement due to this function always running successfully.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-omap2/dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index e1a56d8..1ed4be1 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -117,7 +117,6 @@ static void omap2_show_dma_caps(void)
>  	u8 revision = dma_read(REVISION, 0) & 0xff;
>  	printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
>  				revision >> 4, revision & 0xf);
> -	return;
>  }
>  
>  static unsigned configure_dma_errata(void)

Sorry for the delay, applying this into omap-for-v4.2/fixes as
it's not urgent.

Regards,

Tony
