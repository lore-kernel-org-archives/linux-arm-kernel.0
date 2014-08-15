From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 15 Aug 2014 21:14:00 +0200
Subject: [PATCH v7] 8250-core based serial driver for OMAP + DMA
In-Reply-To: <20140815181704.GH17769@csclub.uwaterloo.ca>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <20140815181704.GH17769@csclub.uwaterloo.ca>
Message-ID: <53EE5BF8.3010007@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2014 08:17 PM, Lennart Sorensen wrote:

> Are you saying that with the new driver you have to respond to the RX
> irq faster than before to avoid overflows?  It is not quite clear.

Yes. The irq fires 46 bytes giving you 16 bytes buffer before overflow
vs 63 bytes buffer the old one had.

> I do think 40000 interrupts to handle 40000 bytes of date does seem a
> tad inefficient, so dropping to 854 looks a lot nicer.  Was the omap
> driver not using the fifo trigger levels at all?

It configured the trigger levels to 1 for RX and 16 for TX.

Sebastian
