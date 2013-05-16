From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 May 2013 08:26:34 +0100
Subject: [PATCH 01/39] dmaengine: ste_dma40: Separate Logical Global
 Interrupt Mask (GIM) unmasking
In-Reply-To: <20130516063513.GC14863@intel.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-2-git-send-email-lee.jones@linaro.org>
 <CACRpkdZJp-WRGNgzwqERVBtb_WxQGybmMjnnLTAoX66qECNh7g@mail.gmail.com>
 <20130516063513.GC14863@intel.com>
Message-ID: <20130516072634.GE3269@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 May 2013, Vinod Koul wrote:

> On Wed, May 15, 2013 at 06:29:51PM +0200, Linus Walleij wrote:
> > On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > > During the initial setup of a logical channel, it is necessary to unmask
> > > the GIM in order to receive generated terminal count and error interrupts.
> > > We're separating out this required code so it will be possible to move
> > > the remaining code in d40_phy_cfg(), which is mostly runtime configuration
> > > into the runtime_config() routine.
> > >
> > > Cc: Vinod Koul <vinod.koul@intel.com>
> > > Cc: Dan Williams <djbw@fb.com>
> > > Cc: Per Forlin <per.forlin@stericsson.com>
> > > Cc: Rabin Vincent <rabin@rab.in>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Tentatively applied to my ux500-dma40 branch.
> > 
> > This lacks an ACK from Vinod...
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > I cannot get any of this stack of patches up to ARM SoC
> > before I have Vinod's ACK on all hitting drivers/dma/*
> Wip ... :)

Nice! :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
