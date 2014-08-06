From: ronald.wahl@raritan.com (Ronald Wahl)
Date: Thu, 07 Aug 2014 01:33:04 +0200
Subject: [PATCH] spi: atmel: fix corruption caused by too early transfer
 completion
References: 1407330035-2212-1-git-send-email-ronald.wahl@raritan.com
Message-ID: <53E2BB30.1020009@raritan.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-08-06 13:00, Ronald Wahl wrote:
> The PDC (peripheral DMA controller) on AT91 supports two transfer
> counters and associated registers - one for current and one for the
> next transfer. If the current transfer is done the next transfer is
> moved into the current transfer. Now there are two interrupts: one is
> raised whenever a single transfer is done (ENDRX) and the other one is
> raised when the current and the next transfer has finished (RXBUFF).
> The issue is that the driver only enables the ENDRX interrupt which may
> lead to queuing a new request while there is still a transfer running.
> This can lead to overruns and/or corruption. By using the RXBUFF
> interrupt only we queue new requests only when the hardware queue is
> empty avoiding this problem.

Forgot to Cc: Nicolas Ferre ...

- ron
