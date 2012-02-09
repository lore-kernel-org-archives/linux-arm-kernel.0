From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 9 Feb 2012 15:17:03 +0100
Subject: [PATCH 1/2] i.MX DMA: Add support for 2D transfers.
In-Reply-To: <1328285474-26365-1-git-send-email-javier.martin@vista-silicon.com>
References: <1328285474-26365-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20120209141703.GB3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 05:11:13PM +0100, Javier Martin wrote:
> DMAC present in i.MX2 and i.MX1 chips have two
> 2D configuration slots that any DMA channel can
> use to make 2D DMA transfers.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

My problem with this patch is that it adds new code to
arch/arm/mach-imx/dma-v1.c.
The original intention of having a legacy driver in arch/arm/mach-imx/dma-v1.c
and a dmaengine driver in drivers/dma was that we move remove the
arch/arm parts to drivers/dma once all users have switched to the new
API.  I fixed the sound drivers and the mxcmmc driver already.  We
currently have the imxmmc driver and the i.MX1/2 camera drivers left
in the tree.  The imxmmc driver is broken for ages and I think we can
remove it when nobody takes care of putting it back to work. You seem to
work on the i.MX2 camera driver and thus you should be able to fix it
(do you use DMA here or the EMMA engine?). This leaves the i.MX1 driver
and I have no possibility to fix it. I once pinged Paulius about this
issue but appearently nothing has happened.
I think we should start cleaning this up even if we risk breaking
something. Otherwise we are stuck with the legacy driver forever.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
