From: marex@denx.de (Marek Vasut)
Date: Sat, 21 Jul 2012 17:54:29 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120721154153.GA25874@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <201207211611.58956.marex@denx.de> <20120721154153.GA25874@pengutronix.de>
Message-ID: <201207211754.29372.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > Yet, if I know the compatible property for the mxs I2C driver, and also
> > > know the CPU type (be it MX23 or MX28), I can deduce from that a lot of
> > > information, including DMA channel. That is fix. Why encode it?
> > 
> > You know the compatible and the "fallback compatible". From the later
> > one, you can deduce nothing if that happens to kick in.
> 
> Even if the driver was matched because of an MX23-I2C "compatible"
> binding, both devicetree and runtime could provide data that it actually
> runs on MX28. That shouldn't be a problem.

You mean like ... cpu_is_mx28() ? We got rid of that in favor of DT.

> > btw. the PIO discussion on DT discuss is completely ignored. How shall we
> > proceed, this driver is stalled for too long.
> 
> IIRC I mentioned that a discussion about the bindings won't make the
> next merge window.

Yet another merge window, I have to mention. And only because very long pauses 
inbetween reviews and very minor nitpicks. I'm being annoyed by this patch so 
much I'm thinking of giving up on this. I wasted too much of my free time on 
this and the result is as is.

> That's why I proposed either module_parameter

Which I explained is not a way to go.

> or
> dropping the binding entirely as possible inbetween options.

Which is not an option either. And this discussion is only further stalling the 
patch.

We're adding fsl,something properties all over the DT all the time, yet this one 
is of concern?

Best regards,
Marek Vasut
