From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 00:15:21 +0100
Subject: [PATCH 07/10] ARM: mach-realview: move from ARM_DMA_ZONE_SIZE
	to mdesc->dma_zone_size
In-Reply-To: <1309919442-20451-7-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<1309919442-20451-7-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110706231521.GD8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 10:30:39PM -0400, Nicolas Pitre wrote:
> -#ifdef CONFIG_ZONE_DMA
> -#define ARM_DMA_ZONE_SIZE	SZ_256M
> -#endif
...
> +	.dma_zone_size	= SZ_128M,
> +	.dma_zone_size	= SZ_128M,
> +	.dma_zone_size	= SZ_128M,
> +	.dma_zone_size	= SZ_128M,
> +	.dma_zone_size	= SZ_128M,

Too small...

I think you're rushing to get these patches ready for the 3.1 merge
window...

Given that these patches have only just appeared, and the number of
sillies in them, they should wait for the next merge window _unless_
they get a thorough review and test.
