From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Feb 2010 09:51:26 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
Message-ID: <20100224085126.GC8068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 24, 2010 at 03:23:37AM +0100, Hector Martin wrote:
> The -Dstatic= stuff in the Makefile is a hack and subtly breaks the
> current inflate implementation, because the fixed inflate tables are
> included into a function and removing static places them in the stack,
> which bloats the stack and breaks references after the function returns.
> So get rid of the hack.
> 
> Instead, clean up the stub loader and unify it. The loader is now
> exactly the same regardless of whether you've enabled CONFIG_ZBOOT_ROM
> or not, and runs from RAM in PIC mode. CONFIG_ZBOOT_ROM simply enables
> an extra section of stub code that lets the zImage boot from ROM by
> copying itself to RAM first.
This is a big regression as this introduces two new copies.  And as
CONFIG_ZBOOT_ROM isn't primary about saving RAM at the early boot stages
but for fast booting this is not acceptable.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
