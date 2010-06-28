From: harishpresent@gmail.com (Harishkumar V)
Date: Mon, 28 Jun 2010 15:50:24 +0530
Subject: soft lockup - CPU#0 stuck for 61s! problem
In-Reply-To: <20100628090036.GA28510@n2100.arm.linux.org.uk>
References: <AANLkTimqNv37LkJDyKJp9PnJapXH4naINhx-T2ysQi4D@mail.gmail.com>
	<20100628090036.GA28510@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin_iY-7nUwtf1q7Fz4qdnkA0BUktEC6WwCiQdOX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

thanks,

Will capture the further messages and mail u. Why an IRQ got struck, is
their a way to handle this....

On Mon, Jun 28, 2010 at 2:30 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Mon, Jun 28, 2010 at 11:25:04AM +0530, Harishkumar V wrote:
> > BUG: soft lockup - CPU#0 stuck for 61s! [linphone-3:764]
> > Modules linked in:
> >
> > Pid: 764, comm:           linphone-3
> > CPU: 0    Not tainted  (2.6.28-rc9 #14)
> > PC is at handle_IRQ_event+0x28/0x74
> > LR is at handle_level_irq+0x94/0xec
>
> That suggests a stuck IRQ.
>
> > pc : [<c008cc30>]    lr : [<c008e18c>]    psr: 48000113
> > sp : c7eede90  ip : c7eedeb0  fp : c7eedeac
> > r10: 0000001d  r9 : c0638ba8  r8 : 00000000
> > r7 : 0000005c  r6 : 00000000  r5 : 0000005c  r4 : c7a1b360
> > r3 : 00000000  r2 : 0000006e  r1 : c7a1b360  r0 : 0000005c
>
> which might be irq 92.
>
> > Exception stack(0xc7eede48 to 0xc7eede90)
> > de40:                   0000005c c7a1b360 0000006e 00000000 c7a1b360
> > 0000005c
> > de60: 00000000 0000005c 00000000 c0638ba8 0000001d c7eedeac c7eedeb0
> > c7eede90
> > de80: c008e18c c008cc30 48000113 ffffffff
> >  r5:d8200000 r4:ffffffff
>
> These messages should continue - and contain some further useful
> information to confirm the stuck IRQ.
>



-- 
Thanks and Regards,
Harish Kumar. V
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100628/2ffcebbb/attachment-0001.html>
