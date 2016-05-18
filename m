From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 18 May 2016 13:24:44 +0300
Subject: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
In-Reply-To: <1463561115-31798-3-git-send-email-kishon@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
Message-ID: <b66f678a-be74-d5f7-f2ef-93b5c9f29b92@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/16 11:45, Kishon Vijay Abraham I wrote:
> omap hsmmc host controller has ADMA2 feature. Enable it here
> for better read and write throughput. Add a new dt binding
> "ti,use_adma" to enable ADMA2.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
>  drivers/mmc/host/omap_hsmmc.c                      |  320 ++++++++++++++++----
>  include/linux/platform_data/hsmmc-omap.h           |    1 +
>  3 files changed, 256 insertions(+), 66 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 74166a0..eb5ceec2 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -28,6 +28,7 @@ specifier is required.
>  dma-names: List of DMA request names. These strings correspond
>  1:1 with the DMA specifiers listed in dmas. The string naming is
>  to be "rx" and "tx" for RX and TX DMA requests, respectively.
> +ti,use_adma: enable adma2 feature

Do we have use case when you want to fall back to generic DMA instead of aDMA2?
IMHO if the driver supports aDMA2, it is going to use it instead of the
generic s/eDMA.
What I mean is:
the driver implements the aDMA2 support.
if the IP has support for aDMA2, then it is going to use it, otherwise it will
use the generic DMA.

-- 
P?ter
