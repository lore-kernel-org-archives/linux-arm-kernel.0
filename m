From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Oct 2010 11:08:50 +0200
Subject: [PATCH 5/5] ARM: remove per-platform timex.h include files
In-Reply-To: <20101020045200.GB12979@mail.wantstofly.org>
References: <20101020045200.GB12979@mail.wantstofly.org>
Message-ID: <20101020090850.GJ28166@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lennert,

On Wed, Oct 20, 2010 at 06:52:00AM +0200, Lennert Buytenhek wrote:
> As they are now redundant.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
>  arch/arm/mach-aaec2000/include/mach/timex.h   |   18 -----
> [...]
> diff --git a/arch/arm/mach-at91/include/mach/timex.h b/arch/arm/mach-at91/include/mach/timex.h
> deleted file mode 100644
> index 05a6e8a..0000000
> --- a/arch/arm/mach-at91/include/mach/timex.h
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -/*
> - * arch/arm/mach-at91/include/mach/timex.h
> - *
> - *  Copyright (C) 2003 SAN People
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#ifndef __ASM_ARCH_TIMEX_H
> -#define __ASM_ARCH_TIMEX_H
> -
> -#include <mach/hardware.h>
> -
> -#if defined(CONFIG_ARCH_AT91RM9200)
> -
> -#define CLOCK_TICK_RATE		(AT91_SLOW_CLOCK)
> -
> -#elif defined(CONFIG_ARCH_AT91SAM9260)
> -
> -#if defined(CONFIG_MACH_USB_A9260) || defined(CONFIG_MACH_QIL_A9260)
> -#define AT91SAM9_MASTER_CLOCK	90000000
> -#else
> -#define AT91SAM9_MASTER_CLOCK	99300000
> -#endif
I wonder if you checked that the defines you remove here are otherwise
unused?!  a quick grep showed for example that
arch/arm/mach-at91/at91x40.c includes mach/timex.h.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
