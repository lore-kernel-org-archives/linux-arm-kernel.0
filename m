From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Feb 2011 21:10:47 +0100
Subject: [PATCH] ARM: Fix compile after delay page freeing patch
In-Reply-To: <20110222195929.GA31275@n2100.arm.linux.org.uk>
References: <20110222194332.GQ15225@atomide.com>
	<20110222195929.GA31275@n2100.arm.linux.org.uk>
Message-ID: <20110222201047.GE22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, Feb 22, 2011 at 07:59:29PM +0000, Russell King - ARM Linux wrote:
> Note that arch/x86/mm/init.c and arch/x86/mm/pgtable.c both include
> asm/tlb.h without linux/pagemap.h, and use the generic version.  I bet
> no one's tried building x86 with CONFIG_SWAP=n yet...
I did, and it doesn't fail.

include/asm-generic/tlb.h includes <asm/pgalloc.h> which for x86
includes <linux/pagemap.h>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
