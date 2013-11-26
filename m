From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Nov 2013 16:17:16 +0100
Subject: [PATCH 5/4] ARM: at91: don't use <mach/timex.h>
In-Reply-To: <1385474690-6483-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1385474690-6483-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5294BB7C.6030307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/11/2013 15:04, Uwe Kleine-K?nig :
> The platform specific <mach/timex.h> will be removed in a later patch.
> So move its only still used symbol to its only user. Also add a few
> explicit includes of <mach/hardware.h> that are implicitly available
> through <mach/timex.h>.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> Hello,
>
> assuming it's OK for you, please only give an ack and don't take that
> patch as I intend to keep it in a series deprecating <mach/timex.h>.

Okay, I let you take this one.

Thanks a lot. bye,

>
> Thanks
> Uwe
>
>   arch/arm/mach-at91/at91rm9200_time.c  | 1 +
>   arch/arm/mach-at91/at91sam926x_time.c | 1 +
>   arch/arm/mach-at91/at91x40.c          | 3 ++-
>   arch/arm/mach-at91/pm.c               | 1 +
>   4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index f607deb..6b68b98 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -31,6 +31,7 @@
>   #include <asm/mach/time.h>
>
>   #include <mach/at91_st.h>
> +#include <mach/hardware.h>
>
>   static unsigned long last_crtr;
>   static u32 irqmask;
> diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
> index bb39232..b9da2b1 100644
> --- a/arch/arm/mach-at91/at91sam926x_time.c
> +++ b/arch/arm/mach-at91/at91sam926x_time.c
> @@ -19,6 +19,7 @@
>   #include <linux/of_irq.h>
>
>   #include <asm/mach/time.h>
> +#include <mach/hardware.h>
>
>   #define AT91_PIT_MR		0x00			/* Mode Register */
>   #define		AT91_PIT_PITIEN		(1 << 25)		/* Timer Interrupt Enable */
> diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
> index bad94b8..c76874e 100644
> --- a/arch/arm/mach-at91/at91x40.c
> +++ b/arch/arm/mach-at91/at91x40.c
> @@ -19,11 +19,12 @@
>   #include <asm/mach/arch.h>
>   #include <mach/at91x40.h>
>   #include <mach/at91_st.h>
> -#include <mach/timex.h>
>
>   #include "at91_aic.h"
>   #include "generic.h"
>
> +#define AT91X40_MASTER_CLOCK	40000000
> +
>   /*
>    * Export the clock functions for the AT91X40. Some external code common
>    * to all AT91 family parts relys on this, like the gpio and serial support.
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 9986542..7afecb8 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -27,6 +27,7 @@
>
>   #include <mach/at91_pmc.h>
>   #include <mach/cpu.h>
> +#include <mach/hardware.h>
>
>   #include "at91_aic.h"
>   #include "generic.h"
>


-- 
Nicolas Ferre
