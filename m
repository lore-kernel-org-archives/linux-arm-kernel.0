From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 31 Oct 2013 15:44:37 +0800
Subject: [PATCH v2 3/4] ASoC: fsl_ssi: Add dual fifo mode support
In-Reply-To: <52720CA4.3090003@gmail.com>
References: <cover.1383197521.git.b42378@freescale.com>
 <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
 <52720CA4.3090003@gmail.com>
Message-ID: <20131031074436.GG9605@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Philippe

On Thu, Oct 31, 2013 at 08:54:12AM +0100, Philippe R?tornaz wrote:
> Hi
> 
> >
> >+			/* When using dual fifo mode, we need to keep watermark
> >+			 * as even numbers due to dma script limitation.
> >+			 */
> >+			ssi_private->dma_params_tx.maxburst /= 2;
> >+			ssi_private->dma_params_tx.maxburst *= 2;
> >+			ssi_private->dma_params_rx.maxburst /= 2;
> >+			ssi_private->dma_params_rx.maxburst *= 2;
> >
> 
> Why not using a mask here ?
> ssi_private->dma_params_tx.maxburst &= ~0x1;
> ssi_private->dma_params_rx.maxburst &= ~0x1;

I'll use this in v3. Thank you!

Nicolin Chen

> 
> Regards,
> 
> Philippe
> 
> 
