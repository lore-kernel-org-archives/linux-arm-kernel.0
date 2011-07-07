From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 08:52:02 +0100
Subject: [PATCH] ARM: cns3xxx: Add support for L2 Cache Controller
In-Reply-To: <201107070916.20750.arnd@arndb.de>
References: <20110706140832.GA15946@oksana.dev.rtsoft.ru>
	<CAK1hUK-gFwcHzEqFz8+T8Vm7CL5GnHAXureVizfNOBm=8h2mRw@mail.gmail.com>
	<201107070916.20750.arnd@arndb.de>
Message-ID: <20110707075202.GE8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 09:16:20AM +0200, Arnd Bergmann wrote:
> A more correct but also more complex solution would be
> 
>  config CACHE_PL310
>          bool
>          depends on CACHE_L2X0
> -        default y if CPU_V7 && !(CPU_V6 || CPU_V6K)
> +        default y if CPU_V7 && (!(CPU_V6 || CPU_V6K) || ARCH_CNS3XXX)
>          help
>            This option enables optimisations for the PL310 cache
>            controller.
> 
> If we get more of these, we might want to turn around the logic.

Or we actually want to fix cache-l2x0.c to detect the cache type at
runtime and decide what to do.
