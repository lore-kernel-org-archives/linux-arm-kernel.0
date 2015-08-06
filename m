From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Aug 2015 16:26:54 +0100
Subject: IRQ setup on multicore systems (routing, balancing, etc)
In-Reply-To: <55C37A72.2090507@free.fr>
References: <55C0C102.7050600@free.fr>
 <55C37A72.2090507@free.fr>
Message-ID: <20150806152654.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 05:17:06PM +0200, Mason wrote:
> On 04/08/2015 15:41, Mason wrote:
> 
> > I have a few very naive questions about [snip]
> 
> [META]
> 
> Are there perhaps more suitable mailing lists than this one
> for such beginner questions?

I thought your message yesterday indicated you'd found the answer.

You don't setup any kind of routing between CPU cores and devices.
At boot, initially CPU 0 will "own" all interrupts.

You then run a (fixed) version of irqbalanced (preferably the older
version which is not so x86-centric, eg, 0.56) which then distributes
the interrupts between the cores according to what the interrupt is
used for and the load it is imposing on the system.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
