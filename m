From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Jun 2012 11:12:07 +0200
Subject: [PATCH] usb: chipidea: cleanup dma_pool if udc_start() fails
In-Reply-To: <1340615374-21352-1-git-send-email-mkl@pengutronix.de>
References: <1340615374-21352-1-git-send-email-mkl@pengutronix.de>
Message-ID: <4FE82B67.8010601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2012 11:09 AM, Marc Kleine-Budde wrote:
> If udc_start() fails the qh_pool dma-pool cannot be closed because
> it's still in use. This patch factors out the dma_pool_free() loop
> into destroy_eps() and calls it in the error path of udc_start(),
> too.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---

This patch applies on top of Richard's just published imx-chipindea
tree. (https://github.com/riczhao/kernel-imx/commits/topics/usb-driver)

regards, Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/f9d219da/attachment.sig>
