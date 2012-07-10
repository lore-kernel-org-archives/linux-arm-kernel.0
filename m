From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 12:45:22 +0200
Subject: [PATCH] IIO: Add basic MXS LRADC driver
In-Reply-To: <201207101241.24151.jbe@pengutronix.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
 <4FFC056B.7020106@metafoo.de> <201207101241.24151.jbe@pengutronix.de>
Message-ID: <201207101245.23047.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juergen Beisert,

[...]

> > >> But wait, you're getting interrupts on channel 0. Doesn't seem quite
> > >> right. Did you happen to poke into the code and see where the issue
> > >> might be?
> > > 
> > > No yet. But if you think this is not the intended behaviour of your
> > > driver I will do a deeper look.
> > 
> > I don't know the hardware, but from what I've seen in the driver this
> > behavior looks correct. When reading a physical channel the channel will
> > be mapped to the first free virtual channel, afterward it is unmapped
> > again.
> 
> Makes sense.
> 
> > So if you are only reading a single channel it will always be mapped to
> > first virtual channel. If you'd be using buffered mode and read multiple
> > channels at once you'll probably get multiple interrupts on different
> > virtual channels.
> 
> So, the driver's behaviour is intended. Sorry for the noise.

Heh, my own driver confused me. I really better get back to this thing, I even 
have the touchscreen part in the works. Sorry for the confusion.

> Regards,
> Juergen

Best regards,
Marek Vasut
