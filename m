From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2012 14:58:39 +0000
Subject: [PATCH 1/2] ARM: kirkwood: Basic support for DNS-320 and DNS-325
In-Reply-To: <20120312142716.GA5050@titan.lakedaemon.net>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
 <op.wa197mq94cuzmg@gonzo.lentin.co.uk>
 <20120312142716.GA5050@titan.lakedaemon.net>
Message-ID: <201203121458.39524.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012, Jason Cooper wrote:
> > 
> > It probably depends on how easy it is to add the gpiochips into
> > devicetree. Being able to put the LED, buttons and fans in
> > devicetree would make board-dt.c much more manageable. I started to
> > look into it and wasn't immediately obvious, but will have a closer
> > look.

I would think that gpio should not be too hard, since it has very
little dependencies on other things. GPIO on kirkwood seems to be
tightly coupled with the irq stuff, so I guess these should be done
together. We can discuss how to do these on #linaro-kernel on 
irc.freenode.net if you like.

Once interrupts and GPIO are done, that will enable a lot of
the things that already have bindings like gpio-led and gpio-key.
AFAICT, those won't even need any code changes, only a correct
specification of the device node according to the bindings in
Documentation/devicetree/bindings/gpio/*.

> > Happy to resubmit, breaking it out into a board-dnskw.c though.
> 
> Yeah, let's go ahead and do that.  pinmux and the above are going to take
> a while to sort out.  In the mean time, there's:
> 
> sheevaplug
> guruplug
> guruplug-serverplus
> Lacie-*
> Seagate-*
> rd-boards-*
> 
> just to name a few.  Plus it'll give me something to do while we wait
> for pinmux/common clock to land.

Ok, fair enough. We might also see some interest in having some of the
existing board files moved over to DT based probing in order to slim
them down, which fits in nicely with this approach.

	Arnd
