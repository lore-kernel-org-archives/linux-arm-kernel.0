From: vkoul@infradead.org (Vinod Koul)
Date: Fri, 31 Aug 2012 06:25:54 +0530
Subject: [PATCH v3 3/3] spi: spi-davinci: convert to DMA engine API
In-Reply-To: <20120830144307.GA26737@beef>
References: <1345684176-21472-1-git-send-email-mporter@ti.com>
 <1345684176-21472-4-git-send-email-mporter@ti.com>
 <503F75C0.1050507@ti.com> <20120830144307.GA26737@beef>
Message-ID: <1346374554.15463.6.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-08-30 at 10:43 -0400, Matt Porter wrote:
> On Thu, Aug 30, 2012 at 07:46:32PM +0530, Sekhar Nori wrote:
> > Hi Matt,
> > 
> > On 8/23/2012 6:39 AM, Matt Porter wrote:
> > > Removes use of the DaVinci EDMA private DMA API and replaces
> > > it with use of the DMA engine API.
> > > 
> > > Signed-off-by: Matt Porter <mporter@ti.com>
> > 
> > I tried testing this patch on my OMAP-L138 EVM, but SPI fails to 
> > initialize after applying the patch.
> > 
> > root at arago:~# dmesg | grep -i spi                                               
> > spi_davinci spi_davinci.1: request RX DMA channel failed                        
> 
> Hi Sekhar,
> 
> Most likely CONFIG_TI_EDMA is off as it defaults to off in the v3
> series. Try enabling this and if it's the problem then this error
> path can be fixed to properly fallback to PIO only or fail to
> initialize as needed.
I didnt see any update on this one, is it okay, if so care to send a
tested-by?

-- 
~Vinod Koul
Intel Corp.
