From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Jan 2011 09:43:38 +0000
Subject: [PATCH] ARM: mxs: irq_data conversion
In-Reply-To: <1295600518-11300-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1295600518-11300-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110121094338.GE13235@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 10:01:58AM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/Kconfig          |    1 +
>  arch/arm/mach-mxs/gpio.c  |   30 +++++++++++++++---------------
>  arch/arm/mach-mxs/icoll.c |   16 ++++++++--------
>  3 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5cff165..c8d888e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -364,6 +364,7 @@ config ARCH_MXS
>  	select GENERIC_CLOCKEVENTS
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CLKDEV_LOOKUP
> +	select GENERIC_HARDIRQS_NO_DEPRECATED

No.  Let's do it architecture wide otherwise we're going to get into
problems working out what's been done and what hasn't.  By all means
use it as a way of ensuring that your platform is converted, but don't
submit patches with this in.

I thought the point of Lennert's patches were to convert everyone over,
so it should just be those trees which weren't merged at that point who
are missing the fixup.

We'll set this architecture wide for 2.6.39, and I'll see about queueing
it soon so that we catch those places which haven't been done.  That
should allow the remainder to be caught.
