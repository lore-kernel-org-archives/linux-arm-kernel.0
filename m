From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 14 Mar 2017 09:40:13 +0530
Subject: [PATCH v2 06/12] dmaengine: sun6i: make gate bit in sun8i's DMA
 engines a common quirk
In-Reply-To: <20170305133709.6288-7-icenowy@aosc.xyz>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
 <20170305133709.6288-7-icenowy@aosc.xyz>
Message-ID: <20170314041013.GB2843@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 05, 2017 at 09:37:03PM +0800, Icenowy Zheng wrote:
> Originally we enable a special gate bit when the compatible indicates
> A23/33.
> 
> But according to BSP sources and user manuals, more SoCs will need this
> gate bit.
> 
> So make it a common quirk configured in the config struct.
> 
> The BSP source also indicates that A83T will need this gate bit (there's
> "SUN8IW6" in the #ifdef's), so also enable this gate bit for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  drivers/dma/sun6i-dma.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a2358780ab2c..889fb24023cd 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -101,6 +101,7 @@ struct sun6i_dma_config {
>  	u32 nr_max_channels;
>  	u32 nr_max_requests;
>  	u32 nr_max_vchans;
> +	bool gate_needed;

can you please explain what gate means here

-- 
~Vinod
