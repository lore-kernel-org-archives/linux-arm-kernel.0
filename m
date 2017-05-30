From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 29 May 2017 21:33:16 -0500
Subject: [PATCH] spi: add null check before pointer dereference
In-Reply-To: <20170529035925.oibpv254lyrdzoba@gangnam.samsung>
References: <CGME20170523002511epcas4p3b7737552432363b089e4a9018e43f6f5@epcas4p3.samsung.com>
 <20170523002507.GA16670@embeddedgus>
 <20170529035925.oibpv254lyrdzoba@gangnam.samsung>
Message-ID: <20170529213316.Horde.E_8getHmJAKt7ZcMf5DCefq@gator4166.hostgator.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andi,

Quoting Andi Shyti <andi.shyti@samsung.com>:

> Hi Gustavo,
>
>>  	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>>  				       dma->direction, DMA_PREP_INTERRUPT);
>>
>> +	if (!desc) {
>> +		dev_err(&sdd->master->dev,
>> +			"%s:dmaengine_prep_slave_sg Failed\n", __func__);
>> +		return;
>> +	}
>> +
>
> I'm sorry, I would nack this patch for now. There was a smilar I
> sent before, but, as Krzysztof said, this needs more testing and
> a proper solution.
>

Yeah, I get it.

> That's anyway in my todo list.
>

That's great.

> Thanks,
> Andi

Thanks!
--
Gustavo A. R. Silva
