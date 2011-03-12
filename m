From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Mar 2011 10:45:00 +0100
Subject: [PATCH 01/10] ux500: Introducing foundation for snowball board.
In-Reply-To: <1299884892-6766-2-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201103121045.00928.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:03 mathieu.poirier at linaro.org wrote:
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 9d6feaa..e9f780e 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -3316,3 +3316,4 @@ rover_g8          MACH_ROVER_G8           ROVER_G8                3335
>  t5388p                 MACH_T5388P             T5388P                  3336
>  dingo                  MACH_DINGO              DINGO                   3337
>  goflexhome             MACH_GOFLEXHOME         GOFLEXHOME              3338
> +snowball               MACH_U8500_SNOWBALL     SNOWBALL                3363

I think Russell prefers to update the mach-types file himself
to add all the new types, so while your patch looks totally
fine, it will not go upstream this way.

I'd suggest splitting out the one-line mach-types patch into one
that is only used for review and testing, but leaving the other
changes.

It's also recommended to add the Kconfig change as the final
patch, so that the tree can be compiled at each step of partially
applied patches (if that doesn't already work).

	Arnd
