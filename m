From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 7 Oct 2010 15:56:12 -0700
Subject: [PATCH] ARM: imx serial driver: fix resume
In-Reply-To: <1286384236-4241-1-git-send-email-daniel@caiaq.de>
References: <1286384236-4241-1-git-send-email-daniel@caiaq.de>
Message-ID: <20101007155612.b8f690fd.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  6 Oct 2010 18:57:16 +0200
Daniel Mack <daniel@caiaq.de> wrote:

> From: Volker Ernst <volker.ernst@txtr.com>
> 
> I just came across a bug in the IMX31 serial driver which is still
> present in the newest kernels and which prevents successful
> resume-operation for the IMX31 serial ports.
> 
> What happens is that in "drivers/serial/imx.c" on resume function
> "serial_imx_resume" gets called. This function in turn calls
> "uart_resume_port" (in the generic serial driver "serial_core.c"),
> which in turn calls "imx_start_tx" in "imx.c" (in case the SIO-port
> was really suspended) which in turn calls "imx_transmit_buffer".
> 
> However calling "imx_transmit_buffer" with an empty TX-fifo (as is
> usually the case) will result in the serial port starting to transmit
> (actually the old [already sent] tx-buffer), as there is no check if
> the tx-buffer is empty before starting to feed tx-fifo-data to the
> serial port hardware.
> 
> Signed-off-by: Volker Ernst <volker.ernst@txtr.com>
> Cc: Daniel Mack <daniel@caiaq.de>

This should have been Signed-off-by:, as you were on the patch delivery
path.

I made that change to my copy of the patch, thanks.

> Cc: Andy Green <andy@warmcat.com>
