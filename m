From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 17 Feb 2016 14:42:33 +0100
Subject: [PATCH] i.MX SPI DMA cleanup
In-Reply-To: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <56C478C9.6050706@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 17.02.2016 14:28, Sascha Hauer wrote:
> This picks up a series sent by Anton Bondarenko last year. It
> contains the remaining not yet upstreamed patches from Antons series
> plus some more DMA related cleanup patches.
>
> My mission was to hunt a bug in the DMA code path sometimes causing
> an additional word in the RX FIFO which locked up the driver in the
> next transfer. It turned out that this was no bug in the driver but
> instead in the device tree: We used the wrong SDMA script for i.MX6.
> The ECSPI cores are connected through the SPBA, so according to the
> reference manual we need the shp/mcu scripts rather than the app/mcu
> scripts.


Are you talking about what is known as "TKT238285 hardware issue"

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c8022

?

Or are you talking about a different issue?

Best regards

Dirk
