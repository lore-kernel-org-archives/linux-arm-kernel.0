From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 11:21:40 +0100
Subject: [RFC,PATCH 3/3] arm: remove machine_desc.io_pg_offst and .phys_io
In-Reply-To: <1279793204.27276.129.camel@pororo.lan>
References: <1279073377.400469.233833413341.0.gpush@pororo>
	<1279073377.404006.432977736300.3.gpush@pororo>
	<AANLkTilsIR36GNlbpZHt3FB5Dp2msedtUMFRSlZ-N-w9@mail.gmail.com>
	<20100720100448.GB32702@n2100.arm.linux.org.uk>
	<1279621292.27276.19.camel@pororo.lan>
	<1279629158.27276.29.camel@pororo.lan>
	<20100721085024.GD6009@n2100.arm.linux.org.uk>
	<1279703355.27276.100.camel@pororo.lan>
	<20100722094643.GB31293@n2100.arm.linux.org.uk>
	<1279793204.27276.129.camel@pororo.lan>
Message-ID: <20100722102140.GD31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 12:06:44PM +0200, Jeremy Kerr wrote:
> > Out of interest, have the OMAP platforms been compile tested with this?
> 
> I've compiled all of the defconfigs with these changes (plus the earlier
> fixups). I get these failures:
> 
> $ grep failed test-configs.log 
> ap4evb_defconfig: failed
> bcmring_defconfig: failed
> g3evm_defconfig: failed
> g4evm_defconfig: failed
> mx1_defconfig: failed
> n8x0_defconfig: failed
> nuc910_defconfig: failed
> nuc950_defconfig: failed
> nuc960_defconfig: failed
> 
> All except mx1 fail due to there being no debug-macros.S, so these
> wouldn't work with DEBUG_LL regardless. mx1 fails due to the IO_ADDRESS
> macro issues.

n8x0 is the only one which looks suspicious, but I assume fails for a
reason unrelated to this change.  n8x0 is an OMAP2 platform which does
have a debug-macros.S file.
