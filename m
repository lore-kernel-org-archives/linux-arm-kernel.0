From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Mon, 18 Aug 2014 16:57:37 +0300
Subject: [PATCH 06/15] tty: serial: 8250_dma: handle error on TX submit
In-Reply-To: <1408124563-31541-7-git-send-email-bigeasy@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-7-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140818135737.GB32400@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 07:42:34PM +0200, Sebastian Andrzej Siewior wrote:
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index b161eee..02e82dc 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -85,6 +85,7 @@ struct uart_8250_port {
>  	unsigned char		mcr_force;	/* mask of forced bits */
>  	unsigned char		cur_iotype;	/* Running I/O type */
>  	unsigned char		rpm_tx_active;
> +	unsigned char		dma_tx_err;

Why not make this member of uart_8250_dma instead?

-- 
heikki
