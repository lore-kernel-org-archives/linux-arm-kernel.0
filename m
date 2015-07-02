From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 3 Jul 2015 00:08:27 +0200 (CEST)
Subject: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
In-Reply-To: <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507011756140.14440@localhost.localdomain>
 <alpine.LNX.2.00.1507021206410.13210@localhost.localdomain>
 <1861313.aMcV1xHCIq@wuerfel>
 <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
Message-ID: <alpine.DEB.2.11.1507030006280.3916@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jul 2015, Paul Osmialowski wrote:
> On Thu, 2 Jul 2015, Arnd Bergmann wrote:
> 
> > I wonder if you could move out the fixed rate clocks into their own
> > nodes. Are they actually controlled by the same block? If they are
> > just fixed, you can use the normal binding for fixed rate clocks
> > and only describe the clocks that are related to the driver.
> 
> In my view having these clocks grouped together looks more convincing. After
> all, they all share the same I/O regs in order to read configuration.

The fact that they share a register is not making them a group. That's
just a HW design decision and you need to deal with that by protecting
the register access, but not by trying to group them artificially at
the functional level.

Thanks,

	tglx
