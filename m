From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jul 2018 09:50:47 -0600
Subject: [PATCH] ARM: at91: remove unnecessary of_platform_default_populate
 calls
In-Reply-To: <20180619214020.18608-1-robh@kernel.org>
References: <20180619214020.18608-1-robh@kernel.org>
Message-ID: <CAL_JsqLfnSOgOMdaJU3Q4h5_PGnNgd4rx+vKXdFVZnNEo6+JZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 3:40 PM Rob Herring <robh@kernel.org> wrote:
>
> The DT core will call of_platform_default_populate, so it is not
> necessary for machine specific code to call it unless there are custom
> match entries, auxdata or parent device. Neither of those apply here, so
> remove the call.
>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-at91/at91rm9200.c | 5 -----
>  arch/arm/mach-at91/at91sam9.c   | 5 -----
>  arch/arm/mach-at91/sama5.c      | 5 -----
>  3 files changed, 15 deletions(-)

Ping?

>
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index 656ad409a253..42583261951e 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -8,17 +8,12 @@
>   * Licensed under GPLv2 or later.
>   */
>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
> -
>  #include <asm/mach/arch.h>
>
>  #include "generic.h"
>
>  static void __init at91rm9200_dt_device_init(void)
>  {
> -       of_platform_default_populate(NULL, NULL, NULL);
> -
>         at91rm9200_pm_init();
>  }
>
> diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
> index 3dbdef4d3cbf..863a0e7ba00f 100644
> --- a/arch/arm/mach-at91/at91sam9.c
> +++ b/arch/arm/mach-at91/at91sam9.c
> @@ -7,9 +7,6 @@
>   * Licensed under GPLv2 or later.
>   */
>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
> -
>  #include <asm/mach/arch.h>
>  #include <asm/system_misc.h>
>
> @@ -17,8 +14,6 @@
>
>  static void __init at91sam9_init(void)
>  {
> -       of_platform_default_populate(NULL, NULL, NULL);
> -
>         at91sam9_pm_init();
>  }
>
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index 3d0bf95a56ae..e3a84a59db76 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -7,9 +7,6 @@
>   * Licensed under GPLv2 or later.
>   */
>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
> -
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/system_misc.h>
> @@ -18,7 +15,6 @@
>
>  static void __init sama5_dt_device_init(void)
>  {
> -       of_platform_default_populate(NULL, NULL, NULL);
>         sama5_pm_init();
>  }
>
> @@ -47,7 +43,6 @@ MACHINE_END
>
>  static void __init sama5d2_init(void)
>  {
> -       of_platform_default_populate(NULL, NULL, NULL);
>         sama5d2_pm_init();
>  }
>
> --
> 2.17.1
>
