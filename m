From: Peter.Chen@freescale.com (Peter Chen)
Date: Wed, 16 Jul 2014 11:58:14 +0000
Subject: [PATCH v3 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <5615007.cNNjmu3rBK@wuerfel>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <42036198.zWkqnus6xa@wuerfel> <20140716091533.GB28151@kwain>
 <5615007.cNNjmu3rBK@wuerfel>
Message-ID: <cd73d8a384cc4040a0bbc6afc1f3063d@DM2PR0301MB0783.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >
> > Some people wanted the possibility to set the DMA mask as this USB2 CI
> > driver does not do specific Berlin operation and can be reused later.
> > I don't particularly need to call dma_coerce_mask_and_coherent() in my
> > case, as far as I know.
> 
> Ok, just remove the call then and rely on the default mask.
> 
> > They can maybe give the restrictions they might want to put on the DMA
> > mask.
> 
> If the restriction is from the bus, it should get handled automatically
> by the device probe as long as the correct dma-ranges property is there
> (though we have a small bug there at the moment). If there is a variation
> of ci13xxx that can't do 32-bit DMA, that should use a different
> compatible string and pass a fixed mask into dma_set_mask_and_coherent()
> based on the device.
> 

Correct me if my below understanding is wrong please.

For three chipidea users:
user_a: don't need dma mask
user_b: dma mask value is dma_mask_b
user_c: dma mask value is dma_mask_c

We don't need to call dma_coerce_mask_and_coherent() at generic chipidea
glue driver, and set dma-ranges as dma_mask_b at user_b's dts, and set
dma-ranges as dma_mask_c at user_c's dts.

Peter 
