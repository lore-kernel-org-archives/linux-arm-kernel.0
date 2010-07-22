From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 22 Jul 2010 12:06:44 +0200
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <20100722094643.GB31293@n2100.arm.linux.org.uk>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
	<AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
	<20100720100448.GB32702@n2100.arm.linux.org.uk>
	<1279621292.27276.19.camel@pororo.lan>
	<1279629158.27276.29.camel@pororo.lan>
	<20100721085024.GD6009@n2100.arm.linux.org.uk>
	<1279703355.27276.100.camel@pororo.lan>
	<20100722094643.GB31293@n2100.arm.linux.org.uk>
Message-ID: <1279793204.27276.129.camel@pororo.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> I think the last patch you posted is fine as-is.  Compiling out the
> setup code for the DEBUG_ICEDCC would be an optimization which could
> be done though...  If you think it's appropriate, please do so.

I think it might be cleaner in general - we might as well check for
DEBUG_ICEDCC at compile time.

> Meanwhile, I'm happy enough to merge this patch (or the optimized one)
> and the follow-on patch which kills off the initializers.

OK, I will send a tree inclusion request for linux-next.

> Out of interest, have the OMAP platforms been compile tested with this?

I've compiled all of the defconfigs with these changes (plus the earlier
fixups). I get these failures:

$ grep failed test-configs.log 
ap4evb_defconfig: failed
bcmring_defconfig: failed
g3evm_defconfig: failed
g4evm_defconfig: failed
mx1_defconfig: failed
n8x0_defconfig: failed
nuc910_defconfig: failed
nuc950_defconfig: failed
nuc960_defconfig: failed

All except mx1 fail due to there being no debug-macros.S, so these
wouldn't work with DEBUG_LL regardless. mx1 fails due to the IO_ADDRESS
macro issues.

Cheers,


Jeremy
