From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 6 Jul 2017 21:39:23 +0200
Subject: v4.13-rc0 on nokia n900: spinlock bad magic
In-Reply-To: <201707062015.54343@pali>
References: <20170706180337.GA26875@amd>
 <201707062015.54343@pali>
Message-ID: <20170706193922.GA31830@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Thursday 06 July 2017 20:03:37 Pavel Machek wrote:
> > Hi!
> > 
> > I don't think this is new in v4.13, but perhaps someone knows how to
> > debug it?
> > 
> > [ 5611.801147] g_ether gadget: packet filter 0e
> > [ 5611.801177] g_ether gadget: ecm req21.43 v000e i0000 l0
> > [ 5668.771453] BUG: spinlock bad magic on CPU#0, kworker/u2:3/9745
> > [ 5668.771850]  lock: 0xce63ef20, .magic: 00000000, .owner:
> > <none>/-1, .owner_cpu: 0
> > [ 5668.772277] CPU: 0 PID: 9745 Comm: kworker/u2:3 Tainted: G       
> > W 4.12.0-03002-gec979a4-dirty #40
> > [ 5668.772796] Hardware name: Nokia RX-51 board
> > [ 5668.773071] Workqueue: phy1 wl1251_irq_work
> 
> I do not remember that I saw this problem.

I guess I have some debug options enabled... do you want a .config to
play with?
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/3f79ea61/attachment.sig>
