From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Mar 2012 17:01:11 -0500 (EST)
Subject: [PATCH v5 7/7] ARM: remove compile time
 __arch_ioremap/__arch_iounmap
In-Reply-To: <1331070317-9598-7-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331070317-9598-1-git-send-email-robherring2@gmail.com>
 <1331070317-9598-7-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1203061700490.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Mar 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that all custom ioremap/iounmap users are converted to runtime hook,
> remove the compile time defines.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/io.h |   15 +++++----------
>  1 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 6c363c1..6f7555d 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -269,16 +269,11 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>   * Documentation/io-mapping.txt.
>   *
>   */
> -#ifndef __arch_ioremap
> -#define __arch_ioremap			__arm_ioremap
> -#define __arch_iounmap			__arm_iounmap
> -#endif
> -
> -#define ioremap(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE)
> -#define ioremap_nocache(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE)
> -#define ioremap_cached(cookie,size)	__arch_ioremap((cookie), (size), MT_DEVICE_CACHED)
> -#define ioremap_wc(cookie,size)		__arch_ioremap((cookie), (size), MT_DEVICE_WC)
> -#define iounmap				__arch_iounmap
> +#define ioremap(cookie,size)		__arm_ioremap((cookie), (size), MT_DEVICE)
> +#define ioremap_nocache(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE)
> +#define ioremap_cached(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE_CACHED)
> +#define ioremap_wc(cookie,size)		__arm_ioremap((cookie), (size), MT_DEVICE_WC)
> +#define iounmap				__arm_iounmap
>  
>  /*
>   * io{read,write}{8,16,32} macros
> -- 
> 1.7.5.4
> 
