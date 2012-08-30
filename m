From: mporter@ti.com (Matt Porter)
Date: Thu, 30 Aug 2012 10:43:07 -0400
Subject: [PATCH v3 3/3] spi: spi-davinci: convert to DMA engine API
In-Reply-To: <503F75C0.1050507@ti.com>
References: <1345684176-21472-1-git-send-email-mporter@ti.com>
 <1345684176-21472-4-git-send-email-mporter@ti.com>
 <503F75C0.1050507@ti.com>
Message-ID: <20120830144307.GA26737@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 07:46:32PM +0530, Sekhar Nori wrote:
> Hi Matt,
> 
> On 8/23/2012 6:39 AM, Matt Porter wrote:
> > Removes use of the DaVinci EDMA private DMA API and replaces
> > it with use of the DMA engine API.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> 
> I tried testing this patch on my OMAP-L138 EVM, but SPI fails to 
> initialize after applying the patch.
> 
> root at arago:~# dmesg | grep -i spi                                               
> spi_davinci spi_davinci.1: request RX DMA channel failed                        

Hi Sekhar,

Most likely CONFIG_TI_EDMA is off as it defaults to off in the v3
series. Try enabling this and if it's the problem then this error
path can be fixed to properly fallback to PIO only or fail to
initialize as needed.

-Matt
