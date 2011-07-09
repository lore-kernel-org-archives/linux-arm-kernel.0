From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 11:14:45 +0100
Subject: [PATCH 01/17] ARM: proc: add definition of cpu_reset for ARMv6
	and ARMv7 cores
In-Reply-To: <1310053830-23779-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20110709101445.GH4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 04:50:14PM +0100, Lorenzo Pieralisi wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> This patch adds simple definitions of cpu_reset for ARMv6 and ARMv7
> cores, which disable the MMU via the SCTLR.

This really needs fixing properly, so that we have this well defined
across all supported ARM cores.  Requiring ARMv6 and ARMv7 to have this
code called with a flat mapping (which may overlap a section boundary)
vs ARMv5 and lower code which doesn't is just silly.

With any API, we need consistency.  So if ARMv6 and v7 require a flat
mapping, we need to ensure that ARMv5 and lower is happy to deal with
that code being also called with a flat mapping.
