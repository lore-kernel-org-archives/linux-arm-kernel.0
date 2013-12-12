From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 12 Dec 2013 16:04:17 +0100
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212144853.GO4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
Message-ID: <1386860657.25449.3.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2013-12-12 at 14:48 +0000, Russell King - ARM Linux wrote:

> Even so, the code _is_ buggy, because if the protocol value had bits
> 15-8 set, then this would go wrong for all the same reasons that
> you've found.  GCC is definitely ignoring the outter (uint16_t) cast
> in the above.

ok I'll file a gcc bug report to get their input on this.

-- 
Maxime
