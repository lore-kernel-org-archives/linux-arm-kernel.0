From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jan 2014 12:02:48 +0100
Subject: [PATCHv9 2/2] dma: Add Freescale eDMA engine driver support
In-Reply-To: <1389839400-29728-3-git-send-email-b35083@freescale.com>
References: <1389839400-29728-1-git-send-email-b35083@freescale.com>
 <1389839400-29728-3-git-send-email-b35083@freescale.com>
Message-ID: <201401161202.49333.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 January 2014, Jingchang Lu wrote:
> Add Freescale enhanced direct memory(eDMA) controller support.
> This module can be found on Vybrid and LS-1 SoCs.
> 
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

Very nice! All my previous comments have been addressed, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

One small comment still:

> +
> +static DEFINE_MUTEX(fsl_edma_mutex);
> +

I think this mutex should be part of struct fsl_edma_engine, not global.

	Arnd
