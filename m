From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 24 Feb 2018 10:13:04 +0100
Subject: [PATCH v4 1/1] tty: serial: imx: allow breaks to be received
 when using dma
In-Reply-To: <20180224022750.20942-1-troy.kisky@boundarydevices.com>
References: <20180224022750.20942-1-troy.kisky@boundarydevices.com>
Message-ID: <20180224091304.y4z24frpy53nrgiy@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 06:27:50PM -0800, Troy Kisky wrote:
> This allows me to login after sending a break when service
> serial-getty at ttymxc0.service is running
> 
> The "tty_insert_flip_char(port, 0, TTY_BREAK)" in clear_rx_errors
> fixes this by allowing the higher layers to see a break.
> 
> Also, call uart_handle_break to handle possible
> "secure attention key."
> 
> FYI: Martin said the ROM sdma firmware works with this patch,
> but external sdma firmware still does not send breaks on a
> i.mx6UL
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Tested-by: Martin Hicks <mort@bork.org>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
