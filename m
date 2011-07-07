From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 13:37:07 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107071343.03591.arnd@arndb.de>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107062231.51117.arnd@arndb.de>
	<CAGsJ_4wi3My=7M2sTwDNTAPxr+JFFAMrDDfBMy08ztjD3soWrQ@mail.gmail.com>
	<201107071343.03591.arnd@arndb.de>
Message-ID: <20110707123707.GN8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 01:43:03PM +0200, Arnd Bergmann wrote:
> On Thursday 07 July 2011, Barry Song wrote:
> > > FWIW, I've double-checked the Xilinx zynq platform that I've already queued
> > > up for 3.1: this one defines IO_SPACE_LIMIT to 0xffff because PCI support
> > > will get merged later, so that's fine.
> > 
> > as far as i know, zynq still has some static mapping tables and board
> > file board_dt.c. as you have reviewed csr platform very carefully, i
> > guess those can get fixed in zynq later too :-)
> > xilinx zynq and csr prima2 should be the pioneering two new SoCs to
> > move to DT in arm for the moment. at least, these two things can try
> > to get same.
> 
> Good point. I'm not planning to change the initial xilinx code, since
> it's already in the tree, but I'd like to apply the patch below
> to make it do the same as prima2 in this regard.
> John, can you ack this patch?

How similar are prima2 and zynq after this patch and a diff between
their two subdirectories?  Are there any differences which can be
eliminated?  Is there any commonality which can be factored out from
the two?  Should the two be occupying separate mach directories?

I think this is something we need to pay attention to now.
