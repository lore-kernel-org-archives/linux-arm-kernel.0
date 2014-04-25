From: pavel@denx.de (Pavel Machek)
Date: Fri, 25 Apr 2014 21:53:19 +0200
Subject: can problems on socfpga [was Re: [PATCH v2 4/6] ARM: socfpga: dts:
 add can0+1]
In-Reply-To: <20140404102815.GA9242@amd.pavel.ucw.cz>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
Message-ID: <20140425195319.GA3677@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> I have had similar patch here, except that it only listed 2 interrupts
> for each d_can controller.
> 
> Otherwise it looks identical.
> 
> Reviewed-by: Pavel Machek <pavel@denx.de>

Actually, does it work for you? Here it produces warnings during boot

c_can_platform ffc00000.d_can: invalid resource
c_can_platform ffc00000.d_can: control memory is not used for raminit
c_can_platform ffc00000.d_can: c_can_platform device registered
(regs=9085c000, irq=163)
...
can: controller area network core (rev 20120528 abi 9)
NET: Registered protocol family 29
can: raw protocol (rev 20120528)
can: broadcast manager protocol (rev 20120528 t)
can: netlink gateway (rev 20130117) max_hops=1

. Then can0 is correctly registered, and seems to even receive
packets, but only when enter is pressed on serial console... which is
kind of weird. I suspected irq problems, but same symptomps with
"irqpoll" -- it leads to generate 2000 irqs/second, but still waits
for enter.

[Aha, and we have just two interrupts listed, but I don't think that
explains all the problems. Unfortunately, that particular target uses
human for remote power switch...].

Any ideas?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
