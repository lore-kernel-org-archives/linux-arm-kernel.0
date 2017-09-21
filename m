From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Sep 2017 20:15:03 +0200
Subject: [PATCH v3 2/6] serial: imx: only set dma_is_rxing when DMA starts
In-Reply-To: <1506010697-22114-3-git-send-email-martyn.welch@collabora.co.uk>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
 <1506010697-22114-3-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <20170921181503.2d4w7fklptt4cktv@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 05:18:13PM +0100, Martyn Welch wrote:
> From: Romain Perier <romain.perier@collabora.com>
> 
> The variable dma_is_rxing is currently set to 1 in imx_disable_rx_int().
> This is problematic as:
> 
> - whilst imx_disable_rx_int() is currently always called before
>   start_rx_dma() this dependency isn't obvious.
> - start_rx_dma() does error checking and might exit without
>   enabling DMA. Currently this will result in dma_is_rxing suggesting
>   that DMA is being used for recieving.
> 
> To avoid these issues, move the setting of dma_is_rxing to
> start_rx_dma() when appropriate.
> 
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
