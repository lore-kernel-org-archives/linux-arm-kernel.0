From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 2 Jan 2017 23:48:30 +0100
Subject: 4.10-rc1 on Nokia N900: regression, WARN_ON() omap_l3_smx.c
In-Reply-To: <20170102181058.GF9325@atomide.com>
References: <20161229231411.GA6865@amd>
 <20170102181058.GF9325@atomide.com>
Message-ID: <20170102224830.GB6817@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I forgot I had v4.10-rc1 running, and now I got warning on all the
> > consoles (hand-copied).
> > 
> > 
> > Unhandled fault: external abort on non-linefetch (0x1028) at
> > 0xfa0ab060
> > ...
> > Comm: kworker/0:0 Not tainted.
> > Workqueue: events musb_irq_work
> > ...
> > PC is at musb_default_readb().
> > ...
> 
> This means the clocks are not enabled at that point.
> 
> > WARNING: CPU: 0 ... at drivers/bus/omap_l3_smx.c:166
> > omap3_l3_app_irq+0xcc/...
> > Tainted: GDW.
> 
> If you comment out postcore_initcall_sync(omap3_l3_init);
> in drivers/bus/omap_l3_smx.c you'll see the proper stack
> trace instead of the l3 interrupt trace. The system will
> hang at that point most likely.
> 
> > I do have patches to allow nfsroot over usb. But they worked ok in
> > v4.9... Does anyone see it, too?
> 
> Hmm not much has changed since v4.9. Are you sure you
> had v4.9 or some earlier v4.9-rc version?

I believe v4.9 works.

But... this may be tricky to reproduce. It happened once so
far... after I reconnected N900 to computer when it was running for a
while. I do have USB cable with power meter on it, thus "flakey". Lets
see if it reappears...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170102/09a252bc/attachment.sig>
