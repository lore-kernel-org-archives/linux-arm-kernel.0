From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Jun 2015 18:36:36 +0200
Subject: [PATCH linux-next v2 3/4] tty/serial: at91: add support to FIFOs
In-Reply-To: <e9b7445f103969a286d586054d79461a6efacd65.1434038494.git.cyrille.pitchen@atmel.com>
References: <cover.1434038494.git.cyrille.pitchen@atmel.com>
 <e9b7445f103969a286d586054d79461a6efacd65.1434038494.git.cyrille.pitchen@atmel.com>
Message-ID: <20150618163636.GP27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/06/2015 at 18:20:16 +0200, Cyrille Pitchen wrote :
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Seems good to me, a few comments:

> +	if (port->fifo_size < 8 || port->fifo_size > 32) {

I'm not sure why you limit the size to 32. At some point, a new SoC may
be release with a bigger FIFO then we'll have to change the code instead
of just putting the appropriate value in the device tree.

> +		port->fifo_size = 0;
> +		dev_err(&pdev->dev, "Invalid FIFO size\n");
> +		return;
> +	}
> +
> +	/*
> +	 * 0 <= rts_low <= rts_high <= fifo_size
> +	 * Once their CTS line asserted by the remote peer, some x86 UARTs tend
> +	 * to flush their internal TX FIFO, commonly up to 8 data, before
> +	 * actually stopping to send new data. So we try to set the RTS High
> +	 * Threshold to a raisonable high value respecting this 8 data empirical
              reasonably --^

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
