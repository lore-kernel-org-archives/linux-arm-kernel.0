From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Apr 2013 09:51:21 +0100
Subject: [PATCH 15/32] dmaengine: ste_dma40: Separate Logical Global
 Interrupt Mask (GIM) unmasking
In-Reply-To: <20130422104012.GL3432@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-16-git-send-email-lee.jones@linaro.org>
 <20130422095130.GM24632@intel.com>
 <20130422104012.GL3432@gmail.com>
Message-ID: <20130424085121.GI17416@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Apr 2013, Lee Jones wrote:

> > >  void d40_phy_cfg(struct stedma40_chan_cfg *cfg,
> > >  		 u32 *src_cfg, u32 *dst_cfg, bool is_log)
> > > @@ -107,11 +113,6 @@ void d40_phy_cfg(struct stedma40_chan_cfg *cfg,
> > >  			src |= 1 << D40_SREG_CFG_PRI_POS;
> > >  			dst |= 1 << D40_SREG_CFG_PRI_POS;
> > shouldnt these be converted to BIT() macro and in gim_unmask above?
> > Driver needs to be consistent in doing things
> 
> Absolutely they do. I haven't converted ste_dma40_ll.c to BIT yet
> though. I have this on my TODO and it will happen in the next
> patch-set.

Vinod, are you happy to Ack this on the proviso that I follow it up
with a subsequent patch converting the ste_dma40_ll driver to BIT()?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
