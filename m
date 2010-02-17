From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 17 Feb 2010 18:13:15 +0100
Subject: [PATCH 1/2] add mx3 cupid bsp cleanup
In-Reply-To: <D99582E5322435468A77E74BB0039E7B176E1F3BBA@SRV02.hamburg.garz-fricke.de>
References: <D99582E5322435468A77E74BB0039E7B176E1F3BBA@SRV02.hamburg.garz-fricke.de>
Message-ID: <20100217171315.GK9007@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 05:54:53PM +0100, Carsten Behling wrote:

[...]

> diff --git a/arch/arm/plat-mxc/include/mach/board-guf_cupid.h b/arch/arm/plat-mxc/include/mach/board-guf_cupid.h
> new file mode 100644
> index 0000000..e10733b
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/board-guf_cupid.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright 2010 Garz & Fricke GmbH All Rights Reserved.
> + *
> + * Author: Carsten Behling <carsten.behling@garz-fricke.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor Boston, MA 02110-1301 USA
> + */
> +
> +#ifndef __MACH_BOARD_GUF_CUPID_H__
> +#define __MACH_BOARD_GUF_CUPID_H__
> +
> +#endif /* __MACH_BOARD_GUF_CUPID_H__ */

Unless you plan to fill that file with live at some later point, you
should remove it.

> Signed-off-by: Carsten Behling <carsten.behling@garz-fricke.com>
> ---
>  arch/arm/mach-mx3/Kconfig                        |    7 ++++++
>  arch/arm/mach-mx3/Makefile                       |    1 +
>  arch/arm/plat-mxc/include/mach/board-guf_cupid.h |   24 ++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-mxc/include/mach/board-guf_cupid.h

And what's that second patch about?

Daniel


> 
> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index 3872af1..a7e40d7 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -114,4 +114,11 @@ config MACH_KZM_ARM11_01
>           Include support for KZM-ARM11-01. This includes specific
>           configurations for the board and its peripherals.
> 
> +config MACH_GUF_CUPID
> +       bool "Support Garz & Fricke Cupid platform"
> +       select ARCH_MX35
> +       help
> +         Include support for Cupid platform. This includes specific
> +         configurations for the board and its peripherals.
> +
>  endif
> diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
> index 5d650fd..7f9ca81 100644
> --- a/arch/arm/mach-mx3/Makefile
> +++ b/arch/arm/mach-mx3/Makefile
> @@ -24,3 +24,4 @@ obj-$(CONFIG_MACH_PCM043)     += mach-pcm043.o
>  obj-$(CONFIG_MACH_ARMADILLO5X0) += mach-armadillo5x0.o
>  obj-$(CONFIG_MACH_MX35_3DS)    += mach-mx35pdk.o
>  obj-$(CONFIG_MACH_KZM_ARM11_01)        += mach-kzm_arm11_01.o
> +obj-$(CONFIG_MACH_GUF_CUPID)   += mach-guf_cupid.o
> diff --git a/arch/arm/plat-mxc/include/mach/board-guf_cupid.h b/arch/arm/plat-mxc/include/mach/board-guf_cupid.h
> new file mode 100644
> index 0000000..e10733b
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/board-guf_cupid.h
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright 2010 Garz & Fricke GmbH All Rights Reserved.
> + *
> + * Author: Carsten Behling <carsten.behling@garz-fricke.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor Boston, MA 02110-1301 USA
> + */
> +
> +#ifndef __MACH_BOARD_GUF_CUPID_H__
> +#define __MACH_BOARD_GUF_CUPID_H__
> +
> +#endif /* __MACH_BOARD_GUF_CUPID_H__ */
> --
> 1.6.0.2
> 
