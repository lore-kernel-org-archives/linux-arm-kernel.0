From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 18 Mar 2014 08:43:09 +0100
Subject: [PATCH RESEND v2 2/2] ixp4xx_eth: Setup coherent_dma_mask
In-Reply-To: <20140317144244.6d2e09f9@marrow.netinsight.se> ("Simon
 =?utf-8?B?S8OlZ3N0csO2bSIncw==?= message of "Mon, 17 Mar 2014 14:42:44
 +0100")
References: <20140317144016.0508cc4d@marrow.netinsight.se>
 <20140317144244.6d2e09f9@marrow.netinsight.se>
Message-ID: <m3eh20j6k2.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:

> +++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> @@ -1426,6 +1426,10 @@ static int eth_init_one(struct platform_device *pdev)
>  	port->netdev = dev;
>  	port->id = pdev->id;
>  
> +	err = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
> +	if (err < 0)
> +		goto err_free;
> +

Yeah. One could also set both masks with the new single call. The driver
uses both streaming and coherent mapping.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
