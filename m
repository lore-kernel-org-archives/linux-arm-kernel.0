From: sean.wang@mediatek.com (Sean Wang)
Date: Sat, 8 Jul 2017 14:56:41 +0800
Subject: [PATCH] net: ethernet: mediatek: remove useless code in
 mtk_probe()
In-Reply-To: <20170707202333.GA5114@embeddedgus>
References: <20170707202333.GA5114@embeddedgus>
Message-ID: <1499497001.16278.19.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,  Gustavo

It indeed is useless at the current time point.


but actually I will add new SoC support to the driver in the next week,
which requires the variable match :-(

	Sean


On Fri, 2017-07-07 at 15:23 -0500, Gustavo A. R. Silva wrote:
> Remove useless local variables _match_, _soc_ and the code related.
> 
> Notice that
> 
> const struct of_device_id of_mtk_match[] = {
>         { .compatible = "mediatek,mt2701-eth" },
>         {},
> };
> 
> So match->data is NULL.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index adaaafc..b9a5a65 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -2401,15 +2401,10 @@ static int mtk_probe(struct platform_device *pdev)
>  {
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	struct device_node *mac_np;
> -	const struct of_device_id *match;
> -	struct mtk_soc_data *soc;
>  	struct mtk_eth *eth;
>  	int err;
>  	int i;
>  
> -	match = of_match_device(of_mtk_match, &pdev->dev);
> -	soc = (struct mtk_soc_data *)match->data;
> -
>  	eth = devm_kzalloc(&pdev->dev, sizeof(*eth), GFP_KERNEL);
>  	if (!eth)
>  		return -ENOMEM;
