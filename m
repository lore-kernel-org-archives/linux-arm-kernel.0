From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Tue, 10 Aug 2010 21:37:34 +0200
Subject: [PATCH 12/19] ARM: cam60: don't use __init for
	cam60_spi_{flash_platform_data, partitions}
In-Reply-To: <1281017333-5563-12-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100805140813.GA13859@pengutronix.de>
	<1281017333-5563-12-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <AANLkTinvL7RGof_ny85JFLZDFxS8RhLY-qL1B5rqMauu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Uwe,

> These two structs are referenced by cam60_spi_devices. ?The latter is
> copied at init time to kmalloced memory and so the copy isn't freed after
> booting. ?So it must not contain references to .init memory.
>
> This isn't noticed by modpost as cam60_spi_devices is in .init.data, too.
>
> Noticed-by: Andrew Victor <avictor.za@gmail.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Andrew Victor <linux@maxim.org.za>

Please submit to Russell King's patch-system .
