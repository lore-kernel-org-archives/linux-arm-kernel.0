From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 11 Apr 2012 18:15:25 -0500
Subject: [PATCH] Fix build breakage in ep93xx-core
In-Reply-To: <4F860FBB.4050102@gmail.com>
References: <4F860FBB.4050102@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206986C070F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 11, 2012 4:12 PM, Ryan Mallon wrote:
> Commit ede55aaa8bb2dd37e302b2f94312306d216e5f97 "arm: ep93xx: use
> DEFINE_RES_* macros" introduced a build breakage in ep93xx due to a
> typo. Fix it.
>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>

Doh! It's correct in my tree but somehow I fubared it when I created the
patch.  Sorry for the trouble.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

> ---
>
> I should have caught this when I applied it to my tree, but its now
> already got a patch sitting on top of it. I'll be doing test builds for
> each applied patch in future :-).
>
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 8771076..66b1494 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -357,7 +357,7 @@ static struct ep93xx_eth_data ep93xx_eth_data;
>  
>  static struct resource ep93xx_eth_resource[] = {
>  	DEFINE_RES_MEM(EP93XX_ETHERNET_PHYS_BASE, 0x10000),
> -	DEFINE_REQ_IRQ(IRQ_EP93XX_ETHERNET),
> +	DEFINE_RES_IRQ(IRQ_EP93XX_ETHERNET),
>  };
>  
>  static u64 ep93xx_eth_dma_mask = DMA_BIT_MASK(32);
