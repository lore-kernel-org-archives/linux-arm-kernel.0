From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 22 Jul 2012 10:33:43 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <201207211754.29372.marex@denx.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <201207211611.58956.marex@denx.de>
 <20120721154153.GA25874@pengutronix.de>
 <201207211754.29372.marex@denx.de>
Message-ID: <20120722083343.GA31508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Even if the driver was matched because of an MX23-I2C "compatible"
> > binding, both devicetree and runtime could provide data that it actually
> > runs on MX28. That shouldn't be a problem.
> 
> You mean like ... cpu_is_mx28() ? We got rid of that in favor of DT.

Might be. But the information is probably somewhere.

> > IIRC I mentioned that a discussion about the bindings won't make the
> > next merge window.
> 
> Yet another merge window, I have to mention. And only because very long pauses 
> inbetween reviews and very minor nitpicks. I'm being annoyed by this patch so 
> much I'm thinking of giving up on this. I wasted too much of my free time on 
> this and the result is as is.

For you it might be a minor nitpick, for me (as a maintainer) it is not.
You have to deal with just one binding, I have to deal with many. And
since they have to be supported forever, this can easily mess up code
and make the subsystem clumsy and whatnot.

> > That's why I proposed either module_parameter
> 
> Which I explained is not a way to go.

That's why I called it inbetween solution so the patch could go in.
It's fine if you don't like it, I prefer dropping the binding as well.

> > or
> > dropping the binding entirely as possible inbetween options.
> 
> Which is not an option either.

It would enable you to add the binding as an out-of-tree patch.

> And this discussion is only further stalling the 
> patch.


> We're adding fsl,something properties all over the DT all the time, yet this one 
> is of concern?

Yes. Adding all these properties is IMO not the right way, and I have
the impression they often came in because of time pressure like this. If
I think it is wrong for the kernel, I have to reject a patch unless I am
convinced otherwise. Which did not happen yet; as you found out
discussions on devicetree-discuss are slow. Might be another indication
that devictree things happen too much at the time currently. This is not
specific to your patch, there are more which need discussion or had to
be reworked.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120722/ce0a1af1/attachment.sig>
