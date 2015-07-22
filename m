From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 22 Jul 2015 15:32:33 -0700
Subject: [Patch v3 1/5] mtd: nand: tegra: add devicetree binding
In-Reply-To: <1437596129.2289.2.camel@lynxeye.de>
References: <1431282602-7137-1-git-send-email-dev@lynxeye.de>
 <1431282602-7137-2-git-send-email-dev@lynxeye.de>
 <20150721210537.GL24125@google.com>
 <1437596129.2289.2.camel@lynxeye.de>
Message-ID: <20150722223233.GA8876@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 10:15:29PM +0200, Lucas Stach wrote:
> Am Dienstag, den 21.07.2015, 14:05 -0700 schrieb Brian Norris:
> > > +Optional properties:
> > > +- nvidia,wp-gpios: GPIO used to disable write protection of the flash
> > 
> > I think write-protect is a pretty common function, so we might want to
> > just remove the 'nvidia,' prefix, so we can eventually move your code to
> > the core nand_base.c library (BTW, I noticed you grab the GPIO, but you
> > don't do anything with it; is that intentional?). In fact, I've seen
> > requests for that very feature on the mailing list.
> > 
> 
> Actually I request and activate the GPIO in the driver, so the chip is
> permanently unprotected.

Whoops, I missed that part. I'm not too familiar with the GPIO API.
Thanks for clearing that up.

> I agree that it would be nice to integrate this better into the NAND
> core. If it's okay for you I'll drop the nvidia prefix and follow up
> with patches to move this to the core after this driver is in. I don't
> really want this driver get blocked on more dependencies.

Perfect. Yes, sorry for the delays, and I think most things look really
good, actually.

And I guess I wasn't clear: I'd only ask you to change the binding name
now, since we can't change that later; the code can be moved at a later
time, once the DT ABI is set. FWIW, there are other features that might
be useful alongside common NAND write-protect support. For instance, a
user might want to gain a little extra safety by having MTD bring WP#
low only when erasing/writing, so that most of the time, the flash is
protected. 

Brian
