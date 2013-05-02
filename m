From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 May 2013 00:09:56 +0200
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <5182E11E.5010103@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <alpine.LFD.2.02.1305022324371.2891@ionos> <5182E11E.5010103@gmail.com>
Message-ID: <201305030009.57041.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Sebastian Hesselbarth wrote:
> > Just look at the various implementations in drivers/irqchip/ and find
> > out how similar they are. Moving code to drivers/irqchip/ does not
> > make an excuse for reestablishing the mess which was addressed by the
> > generic irq chip implementation.
> >
> > Can you - and that means all of you ARM folks - please get your gear
> > together and add the missing features to the generic irq chip
> > implementation? I'm not going to accept more of that OF/DT frenzy.
> 
> So you are suggesting to have a "linux,generic-intc" or you want me
> to have "marvell,orion-intc" make use of generic irq chip again?
> 
> The second is easy, the first will take me a while to think about
> proper DT properties how to encode mask/unmask/ack/.. availability
> and offsets.

I think it should not be "linux,..." since the description can
well be OS independent. I don't have a good idea for a generic
name, but it's not very important.

The main missing piece in the generic irqchip code at the moment
is support for the linear irqdomain. Once we have that, a lot of
code can be simplified significantly.

	Arnd
