From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Dec 2011 01:02:21 +0000
Subject: [PATCH] ARM: provide XIP_VIRT_ADDR for no-MMU builds
In-Reply-To: <1323467451-12128-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323467451-12128-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111210010221.GN14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 10:50:51PM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Lack of changelog.  Say why this change is required.

> ---
>  arch/arm/include/asm/memory.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index a8997d7..fcb5757 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -116,6 +116,8 @@
>  #define MODULES_END		(END_MEM)
>  #define MODULES_VADDR		(PHYS_OFFSET)
>  
> +#define XIP_VIRT_ADDR(physaddr)  (physaddr)
> +
>  #endif /* !CONFIG_MMU */
>  
>  /*
> -- 
> 1.7.7.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
