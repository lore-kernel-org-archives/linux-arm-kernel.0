From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 17 Jan 2011 23:25:46 -0500 (EST)
Subject: [PATCH 10/14] ARM: v6k: select TLS register code according to V6
	variants
In-Reply-To: <20110117223635.GB25829@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peugh-0003St-DY@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101171717090.8580@xanadu.home>
	<20110117223635.GB25829@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101172302290.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jan 2011, Russell King - ARM Linux wrote:

> On Mon, Jan 17, 2011 at 05:23:43PM -0500, Nicolas Pitre wrote:
> > Note: this is becoming a bit confusing and prone to mistake when we have:
> 
> Agreed.
> 
> > 	CONFIG_CPU_V6
> > 	CONFIG_CPU_V6K
> > 	CONFIG_CPU_32v6
> > 	CONFIG_CPU_32v6K
> 
> It may be better at some point to get rid of the CPU_32v* and replace
> them with CPU_ARCH_V* instead, which makes it clear that these ones
> definitely refer to the architecture versions.

Agreed.

> The last point while we're here is I don't think it helps to have the
> conditionals spread between the Kconfig files and this file - I'd much
> rather see them all in Kconfig so we can see exactly how we end up with
> each option (TLS_EMUL, TLS_V6, TLS_V6K) in one place.

Yep, although I'd suggest a naming based on the implementation and not 
on the CPU level it happens to be used on.  Something like TLS_EMUL, 
TLS_HW_REG, TLS_HIVECT, where (TLS_HW_REG && TLS_HIVECT) would 
correspond to the current 'if defined(CONFIG_CPU_V6)' case.  That would 
allow for an eventual combination of CONFIG_CPU_32v5 and 
CONFIG_CPU_32v6 (that would be Kirkwood + Dove).


Nicolas
