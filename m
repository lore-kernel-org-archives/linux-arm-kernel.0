From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 5 Jul 2013 15:56:32 +0200
Subject: [PATCH v9 01/10] ASoC: imx-pcm-dma: DT support
In-Reply-To: <51C7351D.9080004@tabi.org>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
 <51C7351D.9080004@tabi.org>
Message-ID: <20130705135632.GE16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 12:49:17PM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> > This patch removes the NO_DT flag. The pdev pointer may have a proper
> > of_node with the dmas property, so we can use it to request DMA
> > channels.
> >
> > Signed-off-by: Markus Pargmann<mpa@pengutronix.de>
> > Tested-by: Shawn Guo<shawn.guo@linaro.org>
> > ---
> 
> I won't have access to functioning hardware for another month or two, so I 
> can't test to see if this patchset breaks PowerPC, but at least it does 
> compile.  I'm a little worried that the DMA changes won't actually run on 
> PowerPC, but I can't test that now.

The DMA channels should end up to be NULL on PowerPC within the generic
dmaengine pcm, so it should fall back to NO_DT automatically.

> 
> So for the time being:
> 
> Acked-by: Timur Tabi <timur@tabi.org>
> 
> -- 
> Timur Tabi
> 

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
