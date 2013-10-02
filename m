From: marex@denx.de (Marek Vasut)
Date: Wed, 2 Oct 2013 15:30:22 +0200
Subject: [PATCH v2 0/2] serial: mxs-auart: wait for DMA buffer to flush
 before shutdown
In-Reply-To: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
References: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
Message-ID: <201310021530.22317.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Hector Palacios,

> This fixes a bug whereby the AUART was shutdown while bytes
> were still waiting in the DMA buffer to be transmistted.
> 
> Changes since v1:
>  * Split the patch in two: one to set the fifosize to the
>    DMA buffer size, and another to wait for the FIFO to empty
>    before disabling the AUART.
>  * The wait for the fifo to empty is now independent of DMA
>    being enabled.
>  * Fix bug on readl() call
>  * Remove bad URL in commit log
> 
> Hector Palacios (2):
>   serial: mxs-auart: set the FIFO size to DMA buffer size
>   serial: mxs-auart: wait for FIFO to flush before shutdown
> 
>  drivers/tty/serial/mxs-auart.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

Looks OK

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
