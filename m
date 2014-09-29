From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 29 Sep 2014 20:06:36 +0200
Subject: [PATCH 00/13 v10] omap 8250 based UART + DMA 
Message-ID: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The queue is getting smaller. The highlights of v9?v10
- the DMA stall Frans Klaver reported which popped up in yocto is gone. It
  also seems that the "ack the err-irq even if nothing happened" in EDMA
  can be dropped.
- the RX- and TX-DMA callbacks are now OMAP-only and no "bugs" flags are
  introduced into the generic DMA code. This also means that there is
  custom IRQ routine in case of DMA.

Sebastian
