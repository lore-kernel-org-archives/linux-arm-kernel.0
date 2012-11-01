From: marex@denx.de (Marek Vasut)
Date: Thu, 1 Nov 2012 17:12:33 +0100
Subject: [PATCH] i2c: mxs: remove broken PIOQUEUE support
In-Reply-To: <20121101160828.GA18425@pengutronix.de>
References: <1351771003-6071-1-git-send-email-w.sang@pengutronix.de>
 <201211011528.17596.marex@denx.de> <20121101160828.GA18425@pengutronix.de>
Message-ID: <201211011712.33729.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> On Thu, Nov 01, 2012 at 03:28:17PM +0100, Marek Vasut wrote:
> > Dear Wolfram Sang,
> > 
> > > This I2C master can do DMA and PIOQUEUE (PIO with FIFO). Originally,
> > > only PIOQEUE
> > 
> > PIOQUEUE ;-)
> 
> Yup, right!
> 
> > > was supported, then DMA support was added. The original
> > > intention was to keep PIOQUEUE since it has less overhead what is nice
> > > for small transfers. However, runtime switching between PIOQEUE and DMA
> > > depending on the transfer size never worked despite a lot of trying.
> > > Since PIOQUEUE mode itself was flaky (polling at places where
> > > interrupts failed to work) and the implementation also imposed a size
> > > limit for transfers, it is best to remove the support altogether which
> > > makes the driver a lot cleaner and more robust. If somebody really
> > > wants less overhead, plain PIO mode could still be implemented with
> > > the addidtional advantage that this mode is also available on MX23,
> > > too.
> > 
> > Yes, looks to be the way to go.
> > 
> > Reviewed-by: Marek Vasut <marex@denx.de>
> 
> Thanks.
> 
> BTW have you tried combining all i2c-messages (msgs[]) of the transfer
> into one DMA chain? That would reduce overhead, too, no?

Yes, that'd work. But then, you usually don't transfer enough messages to notice 
the effect. Implementing PIO transfer for small messages would be much more 
beneficial.

Best regards,
Marek Vasut
