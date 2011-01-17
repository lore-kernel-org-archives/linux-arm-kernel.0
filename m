From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jan 2011 15:24:11 -0800
Subject: [PATCH 12/14] ARM: v6k: do not disable CPU_32v6K based on
	platform selection
In-Reply-To: <E1PeuhM-0003T1-Js@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeuhM-0003T1-Js@rmk-PC.arm.linux.org.uk>
Message-ID: <20110117232410.GK4957@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:24]:
> CPU_32v6K controls whether we use the ARMv6K extension instructions in
> the kernel, and in some places whether we use SMP-safe code sequences
> (eg, bitops.)
> 
> MX3 prevents the selection of this option to ensure that it is not
> enabled for their CPU, which is ARMv6 only.  Now that we've split the
> CPU_V6 option, V6K support won't be offered for MX3 anymore.
> 
> OMAP prevents the selection of this option in an attempt to produce a
> kernel which runs on architectures from ARMv6 to ARMv7 MPCore.  We now
> achieve this in a different way (see the previous patches).
> 
> As such, we no longer need to offer this as a configuration option to
> the user.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Tony Lindgren <tony@atomide.com>
