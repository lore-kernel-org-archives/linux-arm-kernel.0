From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Sep 2017 20:25:56 +0200
Subject: [PATCH v3 4/6] serial: imx: unmap sg buffers when DMA channel is
 released
In-Reply-To: <1506010697-22114-5-git-send-email-martyn.welch@collabora.co.uk>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
 <1506010697-22114-5-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <20170921182556.n7qael3fyorvkfki@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 05:18:15PM +0100, Martyn Welch wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> This commits unmaps sg buffers when the DMA channel is released. It also
> sets to zero `dma_is_rxing` and `dma_is_txing` to state that the
> corresponding channels cannot transmit/receive data, as these are
> disabled.

That's a fix for a race, right? The functions being fixed were
introduced just in the patch before and I guess the race was there
already before. It is best if you could resort your series to have fixes
first. This way they can easily be applied during the rc phase while the
rest waits for the merge window.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
