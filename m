From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 29 Aug 2013 22:12:30 +0800
Subject: [PATCH] serial: imx: initialize the local variable
In-Reply-To: <1377764965-2000-1-git-send-email-b32955@freescale.com>
References: <1377764965-2000-1-git-send-email-b32955@freescale.com>
Message-ID: <20130829141228.GO18729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 04:29:25PM +0800, Huang Shijie wrote:
> The slave_config is not initialized, so some of its fields may
> be set with random data which may causes the failure in the following
> dmaengine_prep_slave_sg().
> 
> This patch fixes this issue.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/tty/serial/imx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 2c13155..a0ebbc9 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -979,7 +979,7 @@ static void imx_uart_dma_exit(struct imx_port *sport)
>  
>  static int imx_uart_dma_init(struct imx_port *sport)
>  {
> -	struct dma_slave_config slave_config;
> +	struct dma_slave_config slave_config = {};
>  	struct device *dev = sport->port.dev;
>  	int ret;
>  
> -- 
> 1.7.1
> 
> 
