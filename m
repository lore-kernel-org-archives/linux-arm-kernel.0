From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 23 Oct 2018 12:13:03 +0200
Subject: [PATCH] ARM: dts: fix imx7d boot spi dma setup error
In-Reply-To: <20181023083356.17579-1-xiaoning.wang@nxp.com>
References: <20181023083356.17579-1-xiaoning.wang@nxp.com>
Message-ID: <20181023101302.ttniiewnouyrufdg@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 08:36:17AM +0000, Clark Wang wrote:
> Add dmas and dma-names for ecspi1~4 to fix kernel boot error:
> "spi_imx 30840000.ecspi: dma setup error -19, use pio".

Actually this should not be an error and the message is supposed to say:

	Unable to setup DMA, falling back to PIO

So IMHO this should be downgraded from dev_err to dev_info and reworded.
Maybe even try DMA-setup on devices where it is known to fail and don't
emit a message on -ENODEV at all.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
