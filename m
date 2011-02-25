From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 25 Feb 2011 11:55:30 +0100
Subject: [PATCH v4] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1298619259-14344-1-git-send-email-shawn.guo@freescale.com>
References: <1298619259-14344-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110225105530.GA2178@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Feb 25, 2011 at 03:34:19PM +0800, Shawn Guo wrote:
> This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> including apbh-dma and apbx-dma.
> 
> * apbh-dma and apbx-dma are supported in the driver as two mxs-dma
>   instances.
> 
> * apbh-dma is different between mx23 and mx28, hardware version
>   register is used to differentiate.
> 
> * mxs-dma supports pio function besides data transfer.  The driver
>   uses dma_data_direction DMA_NONE to identify the pio mode, and
>   steals sgl and sg_len to get pio words and numbers from clients.
> 
> * mxs dmaengine has some very specific features, like sense function
>   and the special NAND support (nand_lock, nand_wait4ready).  These
>   are too specific to implemented in generic dmaengine driver.
> 
> * The driver refers to imx-sdma and only a single descriptor is
>   statically assigned to each channel.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---

What are (roughly) the changes since last version?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110225/7415eff3/attachment.sig>
