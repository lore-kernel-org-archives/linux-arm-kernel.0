From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 09:42:53 +0100
Subject: [PATCH v2 05/15] ARM: mxs: Add low-level debug UART support
In-Reply-To: <AANLkTikbiPCtGG9S2YsAPHdNqUGGB_iFrHtGTzNAEx88@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-4-git-send-email-shawn.guo@freescale.com>
	<20101208202735.GC17441@pengutronix.de>
	<AANLkTikbiPCtGG9S2YsAPHdNqUGGB_iFrHtGTzNAEx88@mail.gmail.com>
Message-ID: <20101209084253.GQ17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Thu, Dec 09, 2010 at 10:02:48AM +0800, Shawn Guo wrote:
> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >> +#ifndef __MACH_MXS_UNCOMPRESS_H__
> >> +#define __MACH_MXS_UNCOMPRESS_H__
> >> +
> >> +#define __MXS_BOOT_UNCOMPRESS
is this used, BTW?

> >> +
> >> +#include <asm/mach-types.h>
> >> +
> >> +static unsigned long uart_base;
> >> +
> >> +#define UART(x) (*(volatile unsigned long *)(uart_base + (x)))
> >> +
> >> +#define DR ? ? ? ? ? 0x00
> >> +#define FR ? ? ? ? ? 0x18
> >> +#define FR_BUSY ? ? ? ? ? ? ?(1 << 3)
> >> +#define FR_TXFE ? ? ? ? ? ? ?(1 << 7)
> >> +#define CR ? ? ? ? ? 0x30
> >> +#define CR_UARTEN ? ?1
> > Maybe namespace these? ?Maybe better define CR_UARTEN as (1 << 0) for
> > consistency?
> >
> Are you expecting namespace "MXS_" or "DUART_" for better?
both?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
