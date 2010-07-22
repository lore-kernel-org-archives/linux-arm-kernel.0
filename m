From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 11:38:34 +0100
Subject: [PATCH 5/6] arm/ns9xxx: fix debug macro compilation failure
In-Reply-To: <1279074759.519643.866429356172.5.gpush@pororo>
References: <1279074759.517724.734812272398.0.gpush@pororo>
	<1279074759.519643.866429356172.5.gpush@pororo>
Message-ID: <20100722103834.GH31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 10:32:39AM +0800, Jeremy Kerr wrote:
> We need mach/memory.h for NS9XXX_CSxSTAT_PHYS, and mach/memory.h needs
> asm/memory.h for UL().

NAK.  Definitely NAK.  You haven't checked what includes whatelse.

asm/memory.h includes mach/memory.h to pick up the platform specific
parts, and provides mach/memory.h with its pre-requisits.  Use asm/memory.h
_everywhere_ rather than mach/memory.h.

Doing otherwise will create include loops, which leads to unreliability
in defined symbols.
