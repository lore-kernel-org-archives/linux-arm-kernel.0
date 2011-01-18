From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 16:18:28 +0000
Subject: [PATCH V4 26/62] ST SPEAr: Adding support for SSP PL022
In-Reply-To: <870d02e83bc5d3b3e2053dfd97a12b921d7242a3.1295333958.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<870d02e83bc5d3b3e2053dfd97a12b921d7242a3.1295333958.git.viresh.kumar@st.com>
Message-ID: <20110118161828.GE16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 12:41:53PM +0530, Viresh Kumar wrote:
> diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
> index ad1c6a0..088bf52 100644
> --- a/arch/arm/mach-spear13xx/spear1300_evb.c
> +++ b/arch/arm/mach-spear13xx/spear1300_evb.c
> @@ -12,7 +12,10 @@
>   */
>  
>  #include <linux/types.h>
> +#include <linux/gpio.h>

:-)

> diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
> index c219691..0e3d8f3 100644
> --- a/arch/arm/mach-spear3xx/spear300_evb.c
> +++ b/arch/arm/mach-spear3xx/spear300_evb.c
> @@ -15,10 +15,14 @@
>  #include <linux/mtd/fsmc.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
>  #include <mach/generic.h>
> +#include <mach/gpio.h>

:-(

> diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
> index d216c94..6daacbb 100644
> --- a/arch/arm/mach-spear3xx/spear310_evb.c
> +++ b/arch/arm/mach-spear3xx/spear310_evb.c
> @@ -15,9 +15,13 @@
>  #include <linux/mtd/fsmc.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
>  #include <mach/generic.h>
> +#include <mach/gpio.h>

:-(

> diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
> index 15db267..baa4574 100644
> --- a/arch/arm/mach-spear3xx/spear320_evb.c
> +++ b/arch/arm/mach-spear3xx/spear320_evb.c
> @@ -15,9 +15,13 @@
>  #include <linux/mtd/fsmc.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
>  #include <mach/generic.h>
> +#include <mach/gpio.h>

:-(

> diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
> index 32d3855..fe9a8c8 100644
> --- a/arch/arm/mach-spear6xx/spear600_evb.c
> +++ b/arch/arm/mach-spear6xx/spear600_evb.c
> @@ -15,15 +15,23 @@
>  #include <linux/mtd/fsmc.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
> +#include <linux/gpio.h>
> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
>  #include <mach/generic.h>
> +#include <mach/gpio.h>

:-(

> diff --git a/arch/arm/plat-spear/include/plat/spi.h b/arch/arm/plat-spear/include/plat/spi.h
> new file mode 100644
> index 0000000..24d57e1
> --- /dev/null
> +++ b/arch/arm/plat-spear/include/plat/spi.h
> @@ -0,0 +1,74 @@
> +/*
> + * arch/arm/plat-spear/include/plat/spi.h
> + *
> + * SPI board specific definitions common to multiple boards on multiple
> + * machines.
> + *
> + * Copyright (C) 2010 ST Microelectronics
> + * Viresh Kumar<viresh.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __PLAT_SPI_H
> +#define __PLAT_SPI_H
> +
> +#include <linux/amba/pl022.h>
> +#include <linux/gpio.h>

:-)
