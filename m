From: davem@davemloft.net (David Miller)
Date: Fri, 12 Dec 2014 15:18:01 -0500 (EST)
Subject: [PATCH v3 0/1] net/macb: add TX multiqueue support for gem
In-Reply-To: <cover.1418383702.git.cyrille.pitchen@atmel.com>
References: <cover.1418383702.git.cyrille.pitchen@atmel.com>
Message-ID: <20141212.151801.1028504001305533230.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Date: Fri, 12 Dec 2014 13:26:43 +0100

> At the first look this patch may look quite big but it cannot be splitted.
> Each queue has its own dedicated IRQ, which should be handled.
> Also the Transmit Base Queue Pointer register of each available queue must be
> initialized before starting the transmission, otherwise the transmission will be
> halted immediately as HRESP errors are likely to occur.
> In addition, some fields had to be moved from struct macb into struct macb_queue
> so a common code could manage the queues.
> 
> This patch was applied to net-next and tested on a sama5d36ek board, which embeds
> both macb and gem IPs, to check the backward compatibility.
> 
> Also it was tested on a sama5dx FPGA platform with a gem designed to use 3 queues.
> Then we used the tc program to set a queue discipline policy as describe in the
> Documentation/networking/multiqueue.txt: we successfully used each queue.

Applied, thanks.
