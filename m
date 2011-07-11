From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Jul 2011 09:31:36 +0200
Subject: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
In-Reply-To: <19994.41750.920408.162356@ipc1.ka-ro>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
	<19994.41750.920408.162356@ipc1.ka-ro>
Message-ID: <20110711073136.GA13840@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 09:15:34AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > spi_imx_devtype_data has already been driver private data.  There is
> > really no need to make a copy in spi_imx_data.  Instead, a reference
> > pointer works perfectly fine.
> > 
> You obviously overlooked, that the copy is done on purpose to keep
> only the data that is actually needed and discard everything else
> after initialisation.
though you could argue that __devinitdata isn't discarded on modern
systems anyhow (and Shawn's patch takes care of removing that
annotation).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
