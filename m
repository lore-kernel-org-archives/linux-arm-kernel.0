From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 4 Jul 2011 10:48:28 -0600
Subject: [PATCH 0/5] remove spi-s3c24xx-gpio driver
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <20110704164828.GE28042@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 02:49:12PM +0200, Peter Korsgaard wrote:
> The spi-s3c24xx-gpio driver is functionally equivalent to the spi-gpio
> driver (but precedes it). The driver has seen very little development 
> since it got added back in 2006, and there's only 2 in-tree users of it.
> 
> This patch series moves the remaining users to the spi-gpio driver and
> then finally removes the driver.
> 
> Compile tested only as I don't have access to the hardware.
> 
>  arch/arm/mach-s3c2410/include/mach/spi-gpio.h |   28 ----
>  arch/arm/mach-s3c2410/mach-qt2410.c           |   34 +----
>  arch/arm/mach-s3c2412/mach-jive.c             |   41 ++----
>  arch/arm/mach-s3c2440/mach-gta02.c            |    1 -
>  drivers/spi/Kconfig                           |   10 --
>  drivers/spi/Makefile                          |    1 -
>  drivers/spi/spi-s3c24xx-gpio.c                |  200 -------------------------

I'm tempted to merge this, just because I like the diffstat.  Kgene,
what say you?

g.
