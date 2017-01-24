From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 24 Jan 2017 10:18:17 +0100
Subject: v4.9 to v4.10 regression: oops when USB cable is plugged in.
In-Reply-To: <20170123224454.GY7403@atomide.com>
References: <20170123222537.GA11543@amd>
 <20170123224454.GY7403@atomide.com>
Message-ID: <20170124091817.GA29246@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
On Mon 2017-01-23 14:44:54, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [170123 14:26]:
> > [25392.239837] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
> > [25392.239868] pgd = c0004000
> > [25392.239898] [fa0ab060] *pgd=48011452(bad)
> > [25392.239929] Internal error: : 1028 [#1] ARM
> > [25392.239929] Modules linked in:
> > [25392.239959] CPU: 0 PID: 24322 Comm: kworker/0:1 Not tainted 4.10.0-rc5-142127-g41f2839-dirty #222
> > [25392.239990] Hardware name: Nokia RX-51 board
> > [25392.240020] Workqueue: events musb_irq_work
> > [25392.240051] task: cd44d5c0 task.stack: cd308000
> > [25392.240051] PC is at musb_default_readb+0x0/0xc
> > [25392.240081] LR is at musb_irq_work+0x1c/0x1b0
> 
> OK I'm pretty sure the patch I posted few days ago fixes
> this. Can you please test patch "[PATCH] usb: musb: Fix
> external abort on non-linefetch for musb_irq_work()"?

Can I get the copy of the patch?

http://www.spinics.net/lists/linux-usb/msg152542.html

...but it is html mangled with no obvious way to unmangle it.

> I was able to hit that only once so far, do you hit it
> every time with your built-in g_ether .config?

I get it "way too often", like once a day. I don't yet know how to hit
it reliably :-(.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170124/e8e1c30e/attachment.sig>
