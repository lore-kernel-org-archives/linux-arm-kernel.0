From: rdunlap@xenotime.net (Randy Dunlap)
Date: Wed, 16 Feb 2011 09:29:02 -0800
Subject: [PATCH] ARM: reenable DEBUG_SECTION_MISMATCH
In-Reply-To: <1297876993-4146-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1297876993-4146-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110216092902.3e6e97b2.rdunlap@xenotime.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Feb 2011 18:23:13 +0100 Uwe Kleine-K?nig wrote:

> For 2.6.38-rc4-git9 only 29 out of 133 defconfigs still produce section
> mismatches.  These defconfigs produce 55 mismatches (weighted sum, so
> maybe less uniq mismatches).
> 
> This is in my opinion enough to start scaring people about the remaining
> problems.

Yes, we have way too many of these and need more eyes on them.


> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> ---
>  lib/Kconfig.debug |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 3967c23..1130dd4 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -102,7 +102,7 @@ config HEADERS_CHECK
>  
>  config DEBUG_SECTION_MISMATCH
>  	bool "Enable full Section mismatch analysis"
> -	depends on UNDEFINED || (BLACKFIN)
> +	depends on ARM || BLACKFIN

I would even like something like this:

	depends on ARM || BLACKFIN || KERNEL_DEVELOPER

or even
	select DEBUG_SECTION_MISMATCH if KERNEL_DEVELOPER

to make these warnings appear... but even with today's other warnings, lots
of them are ignored.


>  	default y
>  	# This option is on purpose disabled for now.
>  	# It will be enabled when we are down to a reasonable number
> -- 


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
