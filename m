From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 16 Nov 2017 08:30:20 +0100
Subject: [PATCH v4 1/1] tty: serial: imx: remove imx_disable_rx_int
In-Reply-To: <20171115225931.22718-1-troy.kisky@boundarydevices.com>
References: <20171115225931.22718-1-troy.kisky@boundarydevices.com>
Message-ID: <20171116073020.oyltyoqa4keiyped@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 03:59:31PM -0700, Troy Kisky wrote:
> Since imx_disable_rx_int is only called by imx_startup,
> let's integrate it into that function. Notice UCR2_ATEN
> is never set in the driver, but I keep the clear so
> that I am only moving thing. Hopefully, the ageing timer
> will soon be used.

I'd drop the last sentence and write about ATEN: Notice UCR2_ATEN is
never set by the driver. The bit is still cleaned to make this patch a
noop.

> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
