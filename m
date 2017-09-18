From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Sep 2017 10:19:28 +0200
Subject: [PATCH v2 08/10] dmaengine: sun6i: Add support for Allwinner A64
 and compatibles
In-Reply-To: <20170917031956.28010-9-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <20170917031956.28010-9-stefan.bruens@rwth-aachen.de>
Message-ID: <20170918081928.eex7njub6atasj6x@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 05:19:54AM +0200, Stefan Br?ns wrote:
> The A64 SoC has the same dma engine as the H3 (sun8i), with a
> reduced amount of physical channels. To allow future reuse of the
> compatible, leave the channel count etc. in the config data blank
> and retrieve it from the devicetree.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> ---
>  drivers/dma/sun6i-dma.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index b5ecc97a0d5a..118b29bb1eac 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -1127,6 +1127,28 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
>  };
>  
> +/*
> + * The A64 binding uses the number of dma channels from the
> + * device tree node.
> + */
> +static struct sun6i_dma_config sun50i_a64_dma_cfg = {
> +	.nr_max_channels = 0,
> +	.nr_max_requests = 0,
> +	.nr_max_vchans   = 0,

Those are the default values. I appreciate that you wanted them here
for documentation, but the comment above already fills up that role
fine.

Once removed,

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/995421ee/attachment.sig>
