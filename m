From: andi.shyti@samsung.com (Andi Shyti)
Date: Mon, 29 May 2017 12:59:25 +0900
Subject: [PATCH] spi: add null check before pointer dereference
In-Reply-To: <20170523002507.GA16670@embeddedgus>
References: <CGME20170523002511epcas4p3b7737552432363b089e4a9018e43f6f5@epcas4p3.samsung.com>
 <20170523002507.GA16670@embeddedgus>
Message-ID: <20170529035925.oibpv254lyrdzoba@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gustavo,

>  	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>  				       dma->direction, DMA_PREP_INTERRUPT);
>  
> +	if (!desc) {
> +		dev_err(&sdd->master->dev,
> +			"%s:dmaengine_prep_slave_sg Failed\n", __func__);
> +		return;
> +	}
> +

I'm sorry, I would nack this patch for now. There was a smilar I
sent before, but, as Krzysztof said, this needs more testing and
a proper solution.

That's anyway in my todo list.

Thanks,
Andi
