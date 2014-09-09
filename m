From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Sep 2014 10:07:40 +0200
Subject: [PATCH] arm64, defconfig: Increase NR_CPUS default to 64
In-Reply-To: <1410176689-20020-1-git-send-email-rric@kernel.org>
References: <1410176689-20020-1-git-send-email-rric@kernel.org>
Message-ID: <20140909080740.GP23009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 01:44:48PM +0200, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> Raising the current maximum limit to 64. This is needed for Cavium's
> Thunder systems that will have at least 48 cores per die.
> 
> The change keeps the current memory footprint in cpu mask structures.
> It does not break existing code. Setting the maximum to 64 cpus still
> boots systems with less cpus.
> 
> Mark's Juno happily booted with a NR_CPUS=64 kernel.
> 
> Tested on our Thunder system with 48 cores. We could see interrupts to
> all cores.
> 
> Cc: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd4e81a4e1ce..67fca2ea81a7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -252,11 +252,11 @@ config SCHED_SMT
>  	  places. If unsure say N here.
>  
>  config NR_CPUS
> -	int "Maximum number of CPUs (2-32)"
> -	range 2 32
> +	int "Maximum number of CPUs (2-64)"
> +	range 2 64
>  	depends on SMP
>  	# These have to remain sorted largest to smallest
Unrelated to the patch: What does this comment mean? There is only one
line following, so it's sorted implicitly.

Best regards
Uwe

> -	default "8"
> +	default "64"

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
