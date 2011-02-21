From: shweta.gulati@ti.com (Gulati, Shweta)
Date: Mon, 21 Feb 2011 10:21:26 +0530
Subject: [PATCH 2/3] OMAP: voltage: move plat/voltage.h to
	mach-omap2/voltage.h
In-Reply-To: <20110221020855.7598.95586.stgit@twilight.localdomain>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
	<20110221020855.7598.95586.stgit@twilight.localdomain>
Message-ID: <AANLkTimkoaKxWVJTd7TLj5W4Ly-bSEagokPekwwp4L8K@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 21, 2011 at 7:38 AM, Paul Walmsley <paul@pwsan.com> wrote:
> At this point in time, there's no reason for this header file to be in
> plat-omap/include/plat/voltage.h. ?It should not be included by device
> drivers, and the code that uses it is currently all under mach-omap2/.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> ?arch/arm/mach-omap2/omap_twl.c ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-omap2/pm.c ? ? ? ? ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-omap2/smartreflex.h ? ? ? ? ? ?| ? ?3 ++-
> ?arch/arm/mach-omap2/sr_device.c ? ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-omap2/voltage.c ? ? ? ? ? ? ? ?| ? ?3 ++-
> ?arch/arm/mach-omap2/voltage.h ? ? ? ? ? ? ? ?| ? ?0
> ?arch/arm/plat-omap/include/plat/omap_hwmod.h | ? ?1 -
> ?7 files changed, 7 insertions(+), 6 deletions(-)
> ?rename arch/arm/{plat-omap/include/plat/voltage.h => mach-omap2/voltage.h} (100%)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index 00e1d2b..ad8c18a 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -18,7 +18,7 @@
> ?#include <linux/kernel.h>
> ?#include <linux/i2c/twl.h>
>
> -#include <plat/voltage.h>
> +#include "voltage.h"
Extra Blank Line
> ?#include "pm.h"
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index d5a102c..4baa674 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -18,8 +18,8 @@
> ?#include <plat/omap-pm.h>
> ?#include <plat/omap_device.h>
> ?#include <plat/common.h>
> -#include <plat/voltage.h>
>
> +#include "voltage.h"
> ?#include "powerdomain.h"
> ?#include "clockdomain.h"
> ?#include "pm.h"
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index 6568c88..5f35b9e 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -21,7 +21,8 @@
> ?#define __ASM_ARM_OMAP_SMARTREFLEX_H
>
> ?#include <linux/platform_device.h>
> -#include <plat/voltage.h>
> +
> +#include "voltage.h"
>
> ?/*
> ?* Different Smartreflex IPs version. The v1 is the 65nm version used in
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> index a636604..10d3c5e 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -23,9 +23,9 @@
> ?#include <linux/io.h>
>
> ?#include <plat/omap_device.h>
> -#include <plat/voltage.h>
>
> ?#include "smartreflex.h"
> +#include "voltage.h"
> ?#include "control.h"
> ?#include "pm.h"
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 12be525..3c9bcdc 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -26,7 +26,6 @@
> ?#include <linux/slab.h>
>
> ?#include <plat/common.h>
> -#include <plat/voltage.h>
>
> ?#include "prm-regbits-34xx.h"
> ?#include "prm-regbits-44xx.h"
> @@ -35,6 +34,8 @@
> ?#include "prminst44xx.h"
> ?#include "control.h"
Extra Blank line
> +#include "voltage.h"
> +
> ?#define VP_IDLE_TIMEOUT ? ? ? ? ? ? ? ?200
> ?#define VP_TRANXDONE_TIMEOUT ? 300
> ?#define VOLTAGE_DIR_SIZE ? ? ? 16
> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/mach-omap2/voltage.h
> similarity index 100%
> rename from arch/arm/plat-omap/include/plat/voltage.h
> rename to arch/arm/mach-omap2/voltage.h
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1eee85a..93beae2 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -34,7 +34,6 @@
> ?#include <linux/ioport.h>
> ?#include <linux/spinlock.h>
> ?#include <plat/cpu.h>
> -#include <plat/voltage.h>
"voltage.h" is not added.
> ?struct omap_device;
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>



-- 
Thanks,
Regards,
Shweta
