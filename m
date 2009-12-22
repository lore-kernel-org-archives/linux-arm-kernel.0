From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2009 15:28:27 +0000
Subject: [PATCH] pcmcia/at91_cf: don't redefine SZ_2K
In-Reply-To: <1261343434-3920-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1261343434-3920-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091222152827.GB17191@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 20, 2009 at 10:10:34PM +0100, Uwe Kleine-K?nig wrote:
> This fixes:
> 
> 	drivers/pcmcia/at91_cf.c:55:1: warning: "SZ_2K" redefined
> 
> Since
> 
> 	c1191b0 ([ARM] Kirkwood: create a mapping for the Security Accelerator SRAM)

Have you checked whether everything which uses at91_cf still builds after
this patch has been applied (eg, AVR32 stuff?)
