From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 30 Aug 2012 19:46:32 +0530
Subject: [PATCH v3 3/3] spi: spi-davinci: convert to DMA engine API
In-Reply-To: <1345684176-21472-4-git-send-email-mporter@ti.com>
References: <1345684176-21472-1-git-send-email-mporter@ti.com>
 <1345684176-21472-4-git-send-email-mporter@ti.com>
Message-ID: <503F75C0.1050507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On 8/23/2012 6:39 AM, Matt Porter wrote:
> Removes use of the DaVinci EDMA private DMA API and replaces
> it with use of the DMA engine API.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>

I tried testing this patch on my OMAP-L138 EVM, but SPI fails to 
initialize after applying the patch.

root at arago:~# dmesg | grep -i spi                                               
spi_davinci spi_davinci.1: request RX DMA channel failed                        

without these 3 patches, SPI flash is detected fine (same kernel 
configuration):

root at arago:~# dmesg | grep spi                                                  
spi_davinci spi_davinci.1: DMA: supported                                       
spi_davinci spi_davinci.1: DMA: RX channel: 18, TX channel: 19, event queue: 0  
spi_davinci spi_davinci.1: master is unqueued, this is deprecated               
m25p80 spi1.0: m25p64 (8192 Kbytes)                                             
spi_davinci spi_davinci.1: Controller at 0xfef0e000                             

Any idea what could be wrong? This is v3.6-rc3 kernel. I can provide 
full bootlogs or any other debug information if that helps.

Thanks,
Sekhar
