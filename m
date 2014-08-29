From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 29 Aug 2014 17:52:53 +0200
Subject: [PATCH 07/15] tty: serial: 8250_dma: enqueue RX dma again on
 completion.
In-Reply-To: <20140818115249.537b3e42@alan.etchedpixels.co.uk>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>	<1408124563-31541-8-git-send-email-bigeasy@linutronix.de>
 <20140818115249.537b3e42@alan.etchedpixels.co.uk>
Message-ID: <5400A1D5.705@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2014 12:52 PM, One Thousand Gnomes wrote:
> 
>>  		if (!up->dma || dma_err)
>>  			status = serial8250_rx_chars(up, status);
>> +
>> +		if (dma_err && port->type == PORT_OMAP_16750)
>> +			serial8250_rx_dma(up, 0);
> 
> Can we stick to a 'has dma' flag and port->rx_dma() type usages so that
> we don't have to rewrite it again to add them the next slightly odd DMA
> user we add 8)

I hide this behind a bug flag, something like UART_NEEDS_DMA_RX_PENDING.

Sebastian
