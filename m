From: philippe.retornaz@gmail.com (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Thu, 31 Oct 2013 08:54:12 +0100
Subject: [PATCH v2 3/4] ASoC: fsl_ssi: Add dual fifo mode support
In-Reply-To: <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
References: <cover.1383197521.git.b42378@freescale.com>
 <0e947536358af7bd6e179559006a3526801a1abe.1383197521.git.b42378@freescale.com>
Message-ID: <52720CA4.3090003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

>
> +			/* When using dual fifo mode, we need to keep watermark
> +			 * as even numbers due to dma script limitation.
> +			 */
> +			ssi_private->dma_params_tx.maxburst /= 2;
> +			ssi_private->dma_params_tx.maxburst *= 2;
> +			ssi_private->dma_params_rx.maxburst /= 2;
> +			ssi_private->dma_params_rx.maxburst *= 2;
>

Why not using a mask here ?
ssi_private->dma_params_tx.maxburst &= ~0x1;
ssi_private->dma_params_rx.maxburst &= ~0x1;

Regards,

Philippe
