From: johnstul@us.ibm.com (john stultz)
Date: Fri, 17 Sep 2010 10:41:38 -0700
Subject: [PATCH] at91: fix arch_gettimeoffset fallout
In-Reply-To: <1284730276-21657-1-git-send-email-jacmet@sunsite.dk>
References: <1284730276-21657-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <1284745298.2451.6.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-09-17 at 15:31 +0200, Peter Korsgaard wrote:
> 5cfc8ee0bb51 (ARM: convert arm to arch_gettimeoffset()) marked all of
> at91 AND at91x40 as needing ARCH_USES_GETTIMEOFFSET, and hence no high
> res timer support / accurate clock_gettime() - But only at91x40 needs it.

Huh, sorry I missed that subtlety! Thanks for hunting this down!

Acked-by: John Stultz <johnstul@us.ibm.com>

> Signed-off-by: Peter Korsgaard <peter.korsgaard@barco.com>
> ---
>  arch/arm/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 553b7cf..a1907b2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -271,7 +271,6 @@ config ARCH_AT91
>  	bool "Atmel AT91"
>  	select ARCH_REQUIRE_GPIOLIB
>  	select HAVE_CLK
> -	select ARCH_USES_GETTIMEOFFSET
>  	help
>  	  This enables support for systems based on the Atmel AT91RM9200,
>  	  AT91SAM9 and AT91CAP9 processors.
