From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 May 2013 09:33:20 +0100
Subject: [PATCH] ARM: OMAP-USB: Fix possible memory leak
In-Reply-To: <20130503083009.GA19377@arwen.pp.htv.fi>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna> <1367512124.978518915@f372.mail.ru>
 <20130502164058.GC8577@arwen.pp.htv.fi>
 <20130502231353.GF21614@n2100.arm.linux.org.uk>
 <20130503061931.GB27451@arwen.pp.htv.fi>
 <20130503081510.GG21614@n2100.arm.linux.org.uk>
 <20130503083009.GA19377@arwen.pp.htv.fi>
Message-ID: <20130503083320.GI21614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 11:30:09AM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Fri, May 03, 2013 at 09:15:10AM +0100, Russell King - ARM Linux wrote:
> > > > This is exactly why we have platform_device_alloc(),
> > > > platform_device_register_full() and friends - so that people don't have to
> > > > fsck around with kzalloc themselves and get it wrong like the above does.
> > > > 
> > > > Would you like me to pass your details to gregkh for another one of his
> > > > public humilation exercises over basic kernel programming stuff? :)
> > > 
> > > How about we pass yours for not reading the patch before flaming ? Note
> > > that $SUBJECT is *not* touching at all that line which kzallocs a
> > > platform_device. Wrong as it is, it's not part of $SUBJECT.
> > 
> > It's really simple.  You do not use k*alloc with platform devices.  And
> 
> agree, no discussions here
> 
> > you reject any patch which contains that, and point it out to the patch
> > author.
> > 
> > It really doesn't matter if there's a kfree or not.  The fact is you do
> > not allow it in any situation, because such bad practises get copied
> > and then you end up with kfree's.
> > 
> > How about you gain an understanding of this stuff and why this stuff is
> > soo "hot".
> 
> how about you look at the git log to figure out I had nothing to do with
> that original patch which added k*alloc to the pdev ?

How about you realise I haven't got time to fuck around like that at the
moment, so in the interests of getting people to fix the glaring error
I commented on it instead in a relevant thread in the hope that some
prat like you would take notice and ask for it to be fixed by someone
working on the driver.
