From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 2 Aug 2016 17:28:35 +0200
Subject: [PATCH RESEND v2 0/8] Improve Rx/Tx DMA implementation
In-Reply-To: <a5d420fa-0837-f0af-dee9-a61562d473c2@toradex.com>
References: <20160719074310.16872-1-bhuvanchandra.dv@toradex.com>
 <a5d420fa-0837-f0af-dee9-a61562d473c2@toradex.com>
Message-ID: <20160802152835.GC21602@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 01:23:32PM +0530, Bhuvanchandra DV wrote:
> Hello,
> 
> Any comments on this patchset?

I tested v1 on my Vybrid board and it fixed the corruption issues i
was seeing with the console on a serial port. I will try to test this
version.

    Andrew

> 
> On 07/19/16 13:13, Bhuvanchandra DV wrote:
> 
> >Drop the clock change patch from v2 patchset[1] since it is applied.
> >
> >Changes since v1:
> >Split suspend/resume patch.
> >
> >[1] https://lkml.org/lkml/2016/6/28/124
> >
> >Bhuvanchandra DV (5):
> >   tty: serial: fsl_lpuart: Fix broken 8m/s1 support
> >   tty: serial: fsl_lpuart: Use cyclic DMA for Rx
> >   tty: serial: fsl_lpuart: Use scatter/gather DMA for Tx
> >   tty: serial: fsl_lpuart: Update suspend/resume for DMA mode
> >   tty: serial: fsl_lpuart: Add support for RS-485
> >
> >Stefan Agner (3):
> >   tty: serial: fsl_lpuart: consider TX FIFO too in tx_empty
> >   tty: serial: fsl_lpuart: support suspend/resume
> >   tty: serial: fsl_lpuart: fix clearing of receive flag
> >
> >  drivers/tty/serial/fsl_lpuart.c | 810 +++++++++++++++++++++++-----------------
> >  1 file changed, 476 insertions(+), 334 deletions(-)
> >
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
