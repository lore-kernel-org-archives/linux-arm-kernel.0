From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 31 May 2011 13:20:33 +0800
Subject: [PATCH 2/3] ARM: mx5: convert to new leds-gpio registration helper
In-Reply-To: <1306609503-31746-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1306609503-31746-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1306609503-31746-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110531052032.GA32080@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, if you receive it twice.  I did not see the first message
delivered.

On Sat, May 28, 2011 at 09:05:02PM +0200, Uwe Kleine-K?nig wrote:
> This gets rid of per machine struct platform_device definitions and allows
> to move the platform data and led definition to .init.rodata.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mx5/Kconfig                    |    4 ++++
>  arch/arm/mach-mx5/board-mx51_efikamx.c       |   15 ++++-----------
>  arch/arm/mach-mx5/board-mx51_efikasb.c       |   16 ++++------------
>  arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c |   18 +++---------------
>  arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |   19 ++++---------------
>  5 files changed, 19 insertions(+), 53 deletions(-)
> 
Hi Uwe,

I'm building Sascha's imx-for-3.0 tree where this patch got applied,
and seeing the following.

  CC      arch/arm/mach-mx5/board-mx51_efikamx.o
arch/arm/mach-mx5/board-mx51_efikamx.c: In function ?mx51_efikamx_init?:
arch/arm/mach-mx5/board-mx51_efikamx.c:241:3: error: assignment of read-only location ?mx51_efikamx_leds[2]?
arch/arm/mach-mx5/board-mx51_efikamx.c:244:2: error: implicit declaration of function ?gpio_leds_register_device?

-- 
Regards,
Shawn
