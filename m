From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 30 May 2013 22:56:49 +0530
Subject: [PATCH 0/3] at_hdmac: dt dma bindings update
In-Reply-To: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
References: <1369930103-11963-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20130530172649.GC3767@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 06:08:20PM +0200, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Hi,
> 
> This set of patches update the dt dma binding for at_hdmac since we need one
> more parameter. In order to keep backward compatibility, an existing cell will
> be used to add this parameter. Since the content of that cell will become a
> magic value due to the concatenation of the two parameters, it is time to
> use macros.
which tree is this targetted to be applied? 

Arnd, can you review this series and ack if this needs to be applied thru
dmaengine?

--
~Vinod
> 
> Regards
> 
> Ludovic Desroches (3):
>   ARM: at91: dt: add header to define at_hdmac configuration
>   ARM: at91: dt: switch DMA DT bindings to pre-processor
>   at_hdmac: add FIFO configuration parameter to DMA DT binding
> 
>  .../devicetree/bindings/dma/atmel-dma.txt          |  7 ++++--
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |  5 ++--
>  arch/arm/boot/dts/at91sam9n12.dtsi                 | 11 +++++----
>  arch/arm/boot/dts/at91sam9x5.dtsi                  | 17 +++++++-------
>  arch/arm/boot/dts/sama5d3.dtsi                     | 19 +++++++--------
>  drivers/dma/at_hdmac.c                             | 25 ++++++++++++++++----
>  include/dt-bindings/dma/at91.h                     | 27 ++++++++++++++++++++++
>  7 files changed, 81 insertions(+), 30 deletions(-)
>  create mode 100644 include/dt-bindings/dma/at91.h
> 
> -- 
> 1.7.11.3
> 

-- 
