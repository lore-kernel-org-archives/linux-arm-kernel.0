From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Aug 2012 08:47:54 +0100
Subject: [PATCH 09/10] ARM: rpc: Fix building RiscPC
In-Reply-To: <1344461278-28245-10-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
 <1344461278-28245-10-git-send-email-arnd@arndb.de>
Message-ID: <20120809074754.GP18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 11:27:57PM +0200, Arnd Bergmann wrote:
> ARMv3 support was removed in 357c9c1f07 "ARM: Remove support for ARMv3
> ARM610 and ARM710 CPUs", which explicitly left parts of the CPU32v3
> support in place for building RiscPC. However, this does not actually
> build in my test setup.
> 
> This is probably not the right solution, but maybe someone has a better
> idea for how to deal with this.

This isn't the right solution.  The RiscPC bus does not support half-word
load/stores, so we must continue to build that target for the 32v3
architecture (which is why I carefully left that stuff behind.)

The mistake is in what I did with arch/arm/lib - the armv3 code in there
needs to be resurected instead.
