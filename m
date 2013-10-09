From: b32955@freescale.com (Huang Shijie)
Date: Wed, 9 Oct 2013 15:55:08 +0800
Subject: [PATCH v3 2/2] serial: mxs-auart: wait for FIFO to flush before
 shutdown
In-Reply-To: <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
References: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
 <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
Message-ID: <52550BDC.70204@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?10?03? 15:32, Hector Palacios ??:
> This lead to many bytes not being transferred (specially at low
> baudrates), as they were still in the DMA buffer when the AUART was
> shutdown.
I meet a similar bug with the imx.c which is used for the I.MX.

I did not implement the uart_ops->flush_buffer() hook, so the DMA may fails.

So could we add a new flush_buffer hook for mxs-auart?

Please see the Documentation/serail/driver.

thanks
Huang Shijie
