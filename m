From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Mar 2014 12:04:49 +0000
Subject: PL310: Killing the platform specified L2 cache size
Message-ID: <20140319120449.GB7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is giving due warning that I will today kill all the code in arch/arm
which changes bits 19:16 of the L2 cache auxiliary control register.  Bits
19:17 set the way size, and bit 16 on PL310 sets the number of ways.

The bits in these registers should contain the correct value from power-up,
and should only be changed if they are wrong or there is a desire to
configure the cache size smaller than the hardware supports.

So far, all the platforms which I've had my patch set run on (which
includes Olof's build farm) indicate that these bits are always correctly
set, so it really doesn't make sense for there to be soo much code in
arch/arm which explicitly sets these flags.

I will (for the time being) leave code which manipulates the other bits
alone.

If this email is mostly ignored (like all the other emails I've sent over
the previous days) I'll just assume that no one is all that interested in
this subject: that's fine, just don't then whinge and moan if it all
breaks. :)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
