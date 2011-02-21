From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 21 Feb 2011 10:55:58 +0100
Subject: [PATCH 1/3] OMAP: smartreflex: move plat/smartreflex.h
	to	mach-omap2/smartreflex.h
In-Reply-To: <20110221020851.7598.57763.stgit@twilight.localdomain>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
	<20110221020851.7598.57763.stgit@twilight.localdomain>
Message-ID: <4D6236AE.7000407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 2/21/2011 3:08 AM, Paul Walmsley wrote:
> There's no reason for this header file to be in
> plat-omap/include/plat/smartreflex.h.  The hardware devices are in
> OMAP2+ SoCs only.  Leaving this header file in plat-omap causes
> problems due to cross-dependencies with other header files that should
> live in mach-omap2/.
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
>   arch/arm/mach-omap2/smartreflex-class3.c      |    2 +-
>   arch/arm/mach-omap2/smartreflex.c             |    2 +-
>   arch/arm/mach-omap2/smartreflex.h             |    0
>   arch/arm/mach-omap2/sr_device.c               |    2 +-
>   5 files changed, 4 insertions(+), 4 deletions(-)
>   rename arch/arm/{plat-omap/include/plat/smartreflex.h =>  mach-omap2/smartreflex.h} (100%)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 8d81813..7f0b5e7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -21,13 +21,13 @@
>   #include<plat/l4_3xxx.h>
>   #include<plat/i2c.h>
>   #include<plat/gpio.h>
> -#include<plat/smartreflex.h>

In fact that include is not used for OMAP4 data and does not seems to be 
used either in this file.
I guess you can simply remove it.

Benoit
