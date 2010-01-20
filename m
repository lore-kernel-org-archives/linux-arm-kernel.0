From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Jan 2010 19:34:50 +0100
Subject: [PATCH] otg Kconfig: select USB_OTG_UTILS wtih USB_ULPI option
In-Reply-To: <1264011971-10560-1-git-send-email-valentin.longchamp@epfl.ch>
References: <4B5747D5.9080104@epfl.ch>
	<1264011971-10560-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20100120183450.GA30066@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valentin,

s/wtih/with/ in the Subject.  Or maybe still better:  

	otg Kconfig: let USB_ULPI select USB_OTG_UTILS

On Wed, Jan 20, 2010 at 07:26:11PM +0100, Valentin Longchamp wrote:
> With CONFIG_USB_ULPI=y, CONFIG_USB<=m, CONFIG_PCI=n and
> CONFIG_USB_OTG_UTILS=n, which is the default used for mx31moboard,
> the build of all mx3 platform fails because drivers/usb/otg/ulpi.c
> where otg_ulpi_create lies is not built.
s/ulpi.c/ulpi.o/ or s/built/compiled/

s/lies/is defined/

> Build error:
> arch/arm/mach-mx3/built-in.o: In function `mxc_board_init':
> kzmarm11.c:(.init.text+0x73c): undefined reference to `otg_ulpi_create'
> kzmarm11.c:(.init.text+0x1020): undefined reference to `otg_ulpi_create'
And maybe add something like:

	This isn't a strong dependency as drivers/usb/otg/ulpi.c doesn't
	use functions defined in drivers/usb/otg/otg.o and is only
	needed to get ulpi.o linked into the kernel image.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
