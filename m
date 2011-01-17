From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jan 2011 22:52:33 +0000
Subject: [PATCH 10/14] ARM: v6k: select TLS register code according to
	V6 variants
In-Reply-To: <20110117223635.GB25829@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peugh-0003St-DY@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101171717090.8580@xanadu.home>
	<20110117223635.GB25829@n2100.arm.linux.org.uk>
Message-ID: <20110117225233.GC25829@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 10:36:35PM +0000, Russell King - ARM Linux wrote:
> It may be better at some point to get rid of the CPU_32v* and replace
> them with CPU_ARCH_V* instead, which makes it clear that these ones
> definitely refer to the architecture versions.

Last point on this is that I think we want to sanitize PJ4.

If we think about CPU_V7 as being the selection of ARM CPUs which are V7
architectures, CPU_PJ4 should be a separate config option selecting all
the same symbols which CPU_V7 does - and that should also select proc-v7.S
for building.

I'm not sure it makes sense to have (eg) the V7 perf events available on
PJ4 or the ARM errata for their V7 cores?

Does PJ4 have VFPv3?  Is Neon available on PJ4?  What about the DCC
debug registers?

etc.
