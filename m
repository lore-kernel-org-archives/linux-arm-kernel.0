From: Stefan.Bruens@rwth-aachen.de (=?iso-8859-1?Q?Br=FCns=2C_Stefan?=)
Date: Mon, 16 Oct 2017 14:21:02 +0000
Subject: [PATCH v4 07/11] dmaengine: sun6i: Retrieve channel count/max
 request from devicetree
In-Reply-To: <20171016070217.GO30097@localhost>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
 <6277478a-601a-48b0-8e1f-1d309049d4f4@rwthex-w2-a.rwth-ad.de>
 <20171016070217.GO30097@localhost>
Message-ID: <1918888.BSE68NRsHe@sbruens-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Montag, 16. Oktober 2017 09:02:17 CEST Vinod Koul wrote:
> On Thu, Sep 28, 2017 at 03:49:24AM +0200, Stefan Br?ns wrote:
> > To avoid introduction of a new compatible for each small SoC/DMA
> > controller
> > variation, move the definition of the channel count to the devicetree.
> > 
> > The number of vchans is no longer explicit, but limited by the highest
> > port/DMA request number. The result is a slight overallocation for SoCs
> > with a sparse port mapping.
> 
> This doesnt apply for me, please check

The hunk below fails after https://git.kernel.org/pub/scm/linux/kernel/git/
vkoul/slave-dma.git/commit/?h=topic/
sun&id=8f3b00347bf075fb457f90ce76573615f567e7bc
, which removed the "const struct of_device_id *device;" declaration.


> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 7fce976a13d8..b5906da2a975 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -42,6 +42,9 @@
...
> @@ -1155,6 +1159,7 @@ MODULE_DEVICE_TABLE(of, sun6i_dma_match);
>  static int sun6i_dma_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *device;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct sun6i_dma_dev *sdc;
>  	struct resource *res;
>  	int ret, i;

Can you fix this up, or should I send a new version of this patch?

Kind regards,

Stefan
