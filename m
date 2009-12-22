From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Dec 2009 17:28:27 +0100
Subject: [PATCH] pcmcia/at91_cf: don't redefine SZ_2K
In-Reply-To: <20091222152827.GB17191@n2100.arm.linux.org.uk>
References: <1261343434-3920-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091222152827.GB17191@n2100.arm.linux.org.uk>
Message-ID: <20091222162827.GA20681@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 03:28:27PM +0000, Russell King - ARM Linux wrote:
> On Sun, Dec 20, 2009 at 10:10:34PM +0100, Uwe Kleine-K?nig wrote:
> > This fixes:
> > 
> > 	drivers/pcmcia/at91_cf.c:55:1: warning: "SZ_2K" redefined
> > 
> > Since
> > 
> > 	c1191b0 ([ARM] Kirkwood: create a mapping for the Security Accelerator SRAM)
> 
> Have you checked whether everything which uses at91_cf still builds after
> this patch has been applied (eg, AVR32 stuff?)
I wasn't aware that the driver is used on AVR32, too.

Hmmmm, drivers/pcmcia/Kconfig has:

	config AT91_CF
		tristate "AT91 CompactFlash Controller"
		depends on PCMCIA && ARCH_AT91RM9200
		...

So unless ARCH_AT91RM9200 is used on AVR32 there is no problem.
Moreover AVR32 doesn't seem to provide <asm/sizes.h>.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
