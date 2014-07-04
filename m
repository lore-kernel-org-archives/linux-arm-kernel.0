From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Jul 2014 22:58:04 +0200
Subject: [PATCH 4/4] ARM: hwcap: disable HWCAP_SWP if the CPU advertises
 it has exclusives
In-Reply-To: <20140704205144.GK21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
 <4606711.7KmFAGVNmG@wuerfel> <20140704205144.GK21766@n2100.arm.linux.org.uk>
Message-ID: <5774249.oWoI3gS2oa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 July 2014 21:51:44 Russell King - ARM Linux wrote:
> Hmm, we need guidance from ARM people on that.
> 
> There may well be a better way to detect between ARMv6 and ARMv6K, which
> is given by the architecture spec.  G7.3 of an early DDI0406 says that
> the MPIDR (mp affinity register) aliases to MIDR for ARMv6, but is of
> course implemented for ARMv6K.
> 
> This seems to be carried through to the latest ARM ARM.  So it seems
> this would be a more correct way to tell ARMv6 from ARMv6K.
> 
> If so, we can certainly expand cpu_architecture() to detect between the
> two and add a CPU_ARCH_ARMv6K in there.
> 
> Let's see what Will has to say about that when he's next around...
> though I think it'll require another trawl through lots of
> documentation.

I was thinking of a simpler check in __get_cpu_architecture, just
checking if the CPUID is ARM1136r0 since that is the only ARMv6
CPU core we support. Anything else that we currently report as
ARMv6 is actually ARMv6K.

	Arnd
