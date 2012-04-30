From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 22:45:57 +0200
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <20120430203016.GD28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302207.39112.marex@denx.de> <20120430203016.GD28226@pengutronix.de>
Message-ID: <201204302245.57958.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > What has the compiler version to do with the relevance? :) This has
> > > nothing to do with adding DMA support. Plus, nobody so far could tell
> > > me what path gcc is seeing there.
> > 
> > It complains that data might be undefined, do you want it in a separate
> > patch then ?
> 
> Yes, but only if you can prove that the compiler is right.

It's not right, because that variable is always initialized, but this at least 
squashes the compile warning.

> > I still havent figured out how to flip between pioqueue mode and dma mode
> > without the controller getting confused, so I prefer to postpone it into
> > subsequent patch. Eventually, I agree it'd be cool to be able to do this
> > switching.
> 
> Yes, send V2 with DMA by default, and I will give a try on the
> mode-switching later, too.

I'd prefer to have PIOQ by default, to avoid breaking some of the boards. Or can 
you test on all of them?

> 
> Thanks,
> 
>    Wolfram

Best regards,
Marek Vasut
