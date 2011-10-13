From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Oct 2011 19:02:48 -0600
Subject: [PATCH v2 3/5] tty/serial: atmel_serial: whitespace and braces
	modifications
In-Reply-To: <e4c59e6f5ee33c1be57085ac0840b53322526367.1318433947.git.nicolas.ferre@atmel.com>
References: <37a19e194d02144aecd24f284f5e43979643a3c3.1318433947.git.nicolas.ferre@atmel.com>
	<e4c59e6f5ee33c1be57085ac0840b53322526367.1318433947.git.nicolas.ferre@atmel.com>
Message-ID: <20111013010248.GN14042@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2011 at 06:06:58PM +0200, Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/tty/serial/atmel_serial.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index a507daa..bb72354 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1433,10 +1433,10 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
>  
>  	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
>  
> -	if (pdata->regs)
> +	if (pdata->regs) {
>  		/* Already mapped by setup code */
>  		port->membase = pdata->regs;
> -	else {
> +	} else {
>  		port->flags	|= UPF_IOREMAP;
>  		port->membase	= NULL;
>  	}
> @@ -1450,9 +1450,10 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
>  		/* only enable clock when USART is in use */
>  	}
>  
> -	atmel_port->use_dma_rx = pdata->use_dma_rx;
> -	atmel_port->use_dma_tx = pdata->use_dma_tx;
> +	atmel_port->use_dma_rx	= pdata->use_dma_rx;
> +	atmel_port->use_dma_tx	= pdata->use_dma_tx;
>  	atmel_port->rs485	= pdata->rs485;
> +
>  	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
>  	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
>  		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
> -- 
> 1.7.5.4
> 
