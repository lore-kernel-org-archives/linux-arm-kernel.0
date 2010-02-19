From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Feb 2010 08:35:56 +0000
Subject: [PATCH] arm: Allow mounting root on omaps with CPU_V6 and CPU_V7
In-Reply-To: <20100219002748.GB21755@atomide.com>
References: <20100219002748.GB21755@atomide.com>
Message-ID: <20100219083556.GB19649@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 04:27:48PM -0800, Tony Lindgren wrote:
> @@ -779,5 +779,5 @@ config CACHE_XSC3L2
>  
>  config ARM_L1_CACHE_SHIFT
>  	int
> -	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> +	default 6 if (ARCH_OMAP3 || ARCH_S5PC1XX) && !ARCH_OMAP2
>  	default 5

This one is definitely wrong.  Setting the L1 cache line size larger
than it actually is should be safe; setting it smaller is definitely
unsafe.
