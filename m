From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 May 2013 11:30:09 +0300
Subject: [PATCH] ARM: OMAP-USB: Fix possible memory leak
In-Reply-To: <20130503081510.GG21614@n2100.arm.linux.org.uk>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna> <1367512124.978518915@f372.mail.ru>
 <20130502164058.GC8577@arwen.pp.htv.fi>
 <20130502231353.GF21614@n2100.arm.linux.org.uk>
 <20130503061931.GB27451@arwen.pp.htv.fi>
 <20130503081510.GG21614@n2100.arm.linux.org.uk>
Message-ID: <20130503083009.GA19377@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 03, 2013 at 09:15:10AM +0100, Russell King - ARM Linux wrote:
> > > This is exactly why we have platform_device_alloc(),
> > > platform_device_register_full() and friends - so that people don't have to
> > > fsck around with kzalloc themselves and get it wrong like the above does.
> > > 
> > > Would you like me to pass your details to gregkh for another one of his
> > > public humilation exercises over basic kernel programming stuff? :)
> > 
> > How about we pass yours for not reading the patch before flaming ? Note
> > that $SUBJECT is *not* touching at all that line which kzallocs a
> > platform_device. Wrong as it is, it's not part of $SUBJECT.
> 
> It's really simple.  You do not use k*alloc with platform devices.  And

agree, no discussions here

> you reject any patch which contains that, and point it out to the patch
> author.
> 
> It really doesn't matter if there's a kfree or not.  The fact is you do
> not allow it in any situation, because such bad practises get copied
> and then you end up with kfree's.
> 
> How about you gain an understanding of this stuff and why this stuff is
> soo "hot".

how about you look at the git log to figure out I had nothing to do with
that original patch which added k*alloc to the pdev ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/624e77bc/attachment.sig>
