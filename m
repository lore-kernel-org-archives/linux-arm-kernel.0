From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Mon, 4 Jul 2016 11:54:13 +0530
Subject: [PATCH v2 0/9] Improve Rx/Tx DMA implementation
In-Reply-To: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
References: <20160628053235.5114-1-bhuvanchandra.dv@toradex.com>
Message-ID: <00c09dc2-da73-1415-9f9f-5dc6c56034c0@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping!

On 06/28/16 11:02, Bhuvanchandra DV wrote:

> Changes since v1:
> Split suspend/resume patch.
>
> Bhuvanchandra DV (5):
>    tty: serial: fsl_lpuart: Fix broken 8m/s1 support
>    tty: serial: fsl-lpuart: Use cyclic DMA for Rx
>    tty: serial: fsl-lpuart: Use scatter/gather DMA for Tx
>    tty: serial: fsl-lpuart: Update suspend/resume for DMA mode
>    tty: serial: fsl_lpuart: Add support for RS-485
>
> Stefan Agner (4):
>    tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
>    clk: imx: vf610: Disable automatic clock gating for lpuart in LPSTOP mode
>    tty: serial: fsl_lpuart: support suspend/resume
>    tty: serial: fsl_lpuart: fix clearing of receive flag
>
>   drivers/clk/imx/clk-vf610.c     |  12 +-
>   drivers/tty/serial/fsl_lpuart.c | 810 +++++++++++++++++++++++-----------------
>   2 files changed, 482 insertions(+), 340 deletions(-)
>
