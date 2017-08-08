From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Aug 2017 12:28:19 +0100
Subject: [PATCH] scripts/dtc: fix '%zx' warning
In-Reply-To: <20170726013004.GJ8978@umbus.fritz.box>
References: <E1da2Z7-0008GG-AV@rmk-PC.armlinux.org.uk>
 <20170726013004.GJ8978@umbus.fritz.box>
Message-ID: <20170808112818.GC20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 11:30:04AM +1000, David Gibson wrote:
> On Tue, Jul 25, 2017 at 05:20:09PM +0100, Russell King wrote:
> > dtc uses an incorrect format specifier for printing a uint64_t value.
> > uint64_t may be either 'unsigned long' or 'unsigned long long' depending
> > on the host architecture.
> > 
> > Fix this by using %llx and casting to unsigned long long, which ensures
> > that we always have a wide enough variable to print 64 bits of hex.
> > 
> >   HOSTCC  scripts/dtc/checks.o
> > scripts/dtc/checks.c: In function 'check_simple_bus_reg':
> > scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
> >   snprintf(unit_addr, sizeof(unit_addr), "%zx", reg);
> >   ^
> > scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
> > 
> > Fixes: 828d4cdd012c ("dtc: check.c fix compile error")
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> This (embarrassing) error is already fixed in upstream dtc.

It remains unfixed in 4.13-rc4.  How do we get this fixed in the
kernel's dtc?  From what I can see, sending a patch to fix stuff
doesn't work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
