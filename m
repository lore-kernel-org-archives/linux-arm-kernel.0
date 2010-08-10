From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Tue, 10 Aug 2010 21:33:57 +0200
Subject: [PATCH 11/19] ARM: cam60: move cam60_spi_devices to .init.data
In-Reply-To: <1281017333-5563-11-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
	<1281017333-5563-11-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTikhwjTc2eHwp8rh2HMi93NjNhoN2A8p07eN4OMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Uwe,

> cam60_spi_devices is passed to at91_add_device_spi which calls
> spi_register_board_info. ?The latter makes a copy of it, so living in
> .init.data is OK.
>
> This fixes the following warning in cam60_defconfig:
> ? ? ? ?WARNING: vmlinux.o(.data+0x2a00): Section mismatch in reference from the variable cam60_spi_devices to the (unknown reference) .init.data:(unknown)
> ? ? ? ?The variable cam60_spi_devices references
> ? ? ? ?the (unknown reference) __initdata (unknown)
> ? ? ? ?If the reference is valid then annotate the
> ? ? ? ?variable with __init* or __refdata (see linux/init.h) or name the variable:
> ? ? ? ?*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Andrew Victor <linux@maxim.org.za>
