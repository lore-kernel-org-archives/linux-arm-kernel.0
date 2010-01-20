From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Jan 2010 20:02:33 +0100
Subject: [PATCH] otg Kconfig: let USB_OTG_UTILS select USB_ULPI option
In-Reply-To: <1264013508-11247-1-git-send-email-valentin.longchamp@epfl.ch>
References: <20100120183450.GA30066@pengutronix.de>
	<1264013508-11247-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20100120190233.GC30066@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 07:51:48PM +0100, Valentin Longchamp wrote:
> With CONFIG_USB_ULPI=y, CONFIG_USB<=m, CONFIG_PCI=n and
> CONFIG_USB_OTG_UTILS=n, which is the default used for mx31moboard,
> the build of all mx3 platform fails because drivers/usb/otg/ulpi.c
> where otg_ulpi_create is defined is not compiled.
> 
> Build error:
> arch/arm/mach-mx3/built-in.o: In function `mxc_board_init':
> kzmarm11.c:(.init.text+0x73c): undefined reference to `otg_ulpi_create'
> kzmarm11.c:(.init.text+0x1020): undefined reference to `otg_ulpi_create'
> 
> This isn't a strong dependency as drivers/usb/otg/ulpi.c doesn't
> use functions defined in drivers/usb/otg/otg.o and is only needed
> to get ulpi.o linked into the kernel image.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
provided you do s/platform/platforms/ above, you get my

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

(Is it better to say "build *for* all mx3 platforms"?)

Thanks
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
