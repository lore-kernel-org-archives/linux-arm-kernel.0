From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Jul 2017 08:50:05 +0200
Subject: [PATCH 2/7] serial: imx: move log from error to debug type
In-Reply-To: <20170630120446.13994-3-romain.perier@collabora.com>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-3-romain.perier@collabora.com>
Message-ID: <20170703065005.yekk7asb65fhgzhz@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 02:04:41PM +0200, Romain Perier wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> During DMA startup we have a data race condition since UART port can
> receive data that can generate different type of errors.
> 
> This is not necessarily an error since DMA didn't yet started. The
> situation is minimized but still present even if we try to clear up the
> error before starting the DMA.
> 
> Therefore changing the log to debug type we avoid having "false" error
> messages.

This doesn't look right. You say the message "DMA transaction error." is
wrong sometimes and so hide it a bit by using dev_dbg instead of
dev_err.

I don't like that.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
