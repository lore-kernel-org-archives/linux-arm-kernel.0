From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 00:12:59 +0100
Subject: [PATCH 05/10] ARM: mach-ixp4xx: move from ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-5-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<1309919442-20451-5-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110706231259.GC8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 10:30:37PM -0400, Nicolas Pitre wrote:
> +#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)

This won't fly.  CONFIG has to be upper case.  Multiple instances of
that in this patch.

> diff --git a/arch/arm/mach-ixp4xx/include/mach/memory.h b/arch/arm/mach-ixp4xx/include/mach/memory.h
> index 34e7940..4caf176 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/memory.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/memory.h
> @@ -14,8 +14,4 @@
>   */
>  #define PLAT_PHYS_OFFSET	UL(0x00000000)
>  
> -#ifdef CONFIG_PCI
> -#define ARM_DMA_ZONE_SIZE	SZ_64M
> -#endif

And the addition of dependence on CONFIG_IXP4XX_INDIRECT_PCI needs someone
from the IXP4xx folk to ACK as that's a functional change.
