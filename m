From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Dec 2014 17:38:01 +0100
Subject: [PATCH] ARM: dove: fix legacy dove IRQ numbers for 3.18
In-Reply-To: <20141221155925.GM11285@n2100.arm.linux.org.uk>
References: <E1XyOJv-0003kd-2y@rmk-PC.arm.linux.org.uk>
 <20141221135118.GA30212@lunn.ch>
 <20141221155925.GM11285@n2100.arm.linux.org.uk>
Message-ID: <20141221163801.GA31423@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 21, 2014 at 03:59:25PM +0000, Russell King - ARM Linux wrote:
> On Sun, Dec 21, 2014 at 02:51:18PM +0100, Andrew Lunn wrote:
> > On Tue, Dec 09, 2014 at 05:11:31PM +0000, Russell King wrote:
> > > v3.18 changed handle_IRQ() to call __handle_domain_irq(), which now
> > > rejects attempts to deliver IRQ0.  Since IRQ 0 is used as the timer
> > > interrupt (just like the PIT on x86), this causes boot to fail as the
> > > bogomips calibration never completes.
> > > 
> > > Fix this by shuffling all interrupts up by one.
> > > 
> > > Fixes: a71b092a9c68 ("ARM: Convert handle_IRQ to use __handle_domain_irq")
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Hi Russell
> > 
> > Do you want to take this though your tree? Or should we take it
> > through mvebu?
> 
> I think it makes sense for you to take it, and push it through arm-soc.

Hi Russell

O.K, i will take it, but:

andrew at shuttle:~/mvebu/linux-mvebu$ patch --dry -l -p1 < ../../rmk
checking file arch/arm/mach-dove/include/mach/irqs.h
Hunk #1 FAILED at 14.
1 out of 1 hunk FAILED
checking file arch/arm/mach-dove/irq.c
Hunk #1 succeeded at 126 (offset 71 lines).
Hunk #2 FAILED@71.
1 out of 2 hunks FAILED

Please could you rebase onto v3.19-rc1.

Thanks
	Andrew
