From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 21 Sep 2017 20:28:17 +0200
Subject: [PATCH v3 5/6] serial: imx: update the stop rx,tx procedures
In-Reply-To: <1506010697-22114-6-git-send-email-martyn.welch@collabora.co.uk>
References: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
 <1506010697-22114-6-git-send-email-martyn.welch@collabora.co.uk>
Message-ID: <20170921182817.wejxqp5e733systb@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 05:18:16PM +0100, Martyn Welch wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> According to "Documentation/serial/driver" both procedures should stop
> receiving or sending data. Based on this the procedures should stop the
> activity regardless if DMA is enabled or not.
> 
> This commit updates both imx_stop_{rx|tx} procedures to stop the
> activity and disable the interrupts related to that.
> 
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>  drivers/tty/serial/imx.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index ed02783..256b128 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -388,15 +388,14 @@ static void imx_stop_tx(struct uart_port *port)
>  	struct imx_port *sport = (struct imx_port *)port;
>  	unsigned long temp;
>  
> -	/*
> -	 * We are maybe in the SMP context, so if the DMA TX thread is running
> -	 * on other cpu, we have to wait for it to finish.
> -	 */

did you understand this comment you're removing here? I admit I don't
but unless it is non-sensical you're doing something wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
