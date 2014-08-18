From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 18 Aug 2014 11:52:49 +0100
Subject: [PATCH 07/15] tty: serial: 8250_dma: enqueue RX dma again on
 completion.
In-Reply-To: <1408124563-31541-8-git-send-email-bigeasy@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-8-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140818115249.537b3e42@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  		if (!up->dma || dma_err)
>  			status = serial8250_rx_chars(up, status);
> +
> +		if (dma_err && port->type == PORT_OMAP_16750)
> +			serial8250_rx_dma(up, 0);

Can we stick to a 'has dma' flag and port->rx_dma() type usages so that
we don't have to rewrite it again to add them the next slightly odd DMA
user we add 8)
