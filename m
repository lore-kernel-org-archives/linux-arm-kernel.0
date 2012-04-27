From: marex@denx.de (Marek Vasut)
Date: Fri, 27 Apr 2012 17:53:38 +0200
Subject: possible MXS-i2c bug
In-Reply-To: <20120427154119.GF16504@pengutronix.de>
References: <201204261326.29388.marex@denx.de>
 <201204271708.53467.marex@denx.de> <20120427154119.GF16504@pengutronix.de>
Message-ID: <201204271753.39516.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > You can get a large list of i2c messages. In the current implementation,
> > yes, they're iterated in mxs_i2c_xfer_msg. Correct.
> > 
> > If you want to do DMA transfer do/from the i2c controller, you have to
> > take all these messages and create the chain of DMA transfers according
> > to these messages, correct?
> 
> This is what I wonder. I'd think one could work on a per message basis.

But then you don't have the DMA chain linked. Which I wonder if the controller 
has any problem with or not. I tried yesterday, got wrotes working perfectly, 
but still had issues with reads, which is exactly what needs to be chained.

I'll poke further eventually.

> Regarding Figure 27-10, the first I2C write command could be sent
> seperately (probably even via PIOQUEUE).

I wonder if we want to combine pioqueue and DMA, that might create quite some 
franken-driver.

> The only thing to be chained is
> the I2C read command and the actual reading of the data.
> 
> Just checked, the FSL driver does it basically this way, too.

Which doesn't mean FSL driver does it correctly, but it probably worked for them 
and there was some bug in my DMA tinkering.

Best regards,
Marek Vasut
