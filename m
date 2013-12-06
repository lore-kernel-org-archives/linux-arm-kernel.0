From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 17:15:07 +0100
Subject: MCS8142
In-Reply-To: <OF8910DA33.769F3123-ON86257C39.000FEF6A-86257C39.0011CEEC@rockwellcollins.com>
References: <OF98E40A9C.2937821E-ON86257C35.0070EFA2-86257C35.0071D5A4@rockwellcollins.com>
 <CAGVrzcb9asBzXqJBatksAXGevtsdpuS+nTZK7SHMgqsnzPYbgQ@mail.gmail.com>
 <OF8910DA33.769F3123-ON86257C39.000FEF6A-86257C39.0011CEEC@rockwellcollins.com>
Message-ID: <201312061715.08203.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, mlweber1 at rockwellcollins.com wrote:
> Currently I'm at the point of having a 3.3 kernel image built for fa526, 
> but I never get console output beyond the uboot starting kernel message.
> 
> I think I have a couple items that I need to get past to make progress. 
> The first is get a toolchain I can trust. I've build a newer toolchain 
> (GCC4.7) that has fa526 support, but I think I need to back track and 
> switch to your 4.6 openWRT toolchain and just make sure I get a kernel 
> binary that "should" execute.  Do you happen to know if that toolchain
> would support the fa526 arch? 

Since fa526 implements standard ARMv4T, any of them should work really,
I'd be surprised if you actually needed fa526 support in the toolchain,
other than building with --march=armv4t. If a compiler supports the
fa526 pipeline optimizations, it will be able to produce code that runs
slightly faster than if you optimize for arm720 or arm920.

> To boot that kernel, I'm using an existing uboot (2010) that seems 
> adequate for now.  However I assume I'll have to build a uImage with 
> appended device tree to get it to boot correctly without uboot DT 
> support.

Watch out for a common pitfall that is having to specify the loadaddr
manually when building a multiplatform kernel to run on an old u-boot.

> The other item that I need to figure out is what the default console
> port name ended up as in the 3.3 or latest kernel.  One openWRT dts
> file bootargs defined it as /dev/ttyMCS, but another defined it as the 
> standard /dev/ttyS0.

IIRC the SoC actually has both a mcs proprietary UART and a standard
8250 compatible one, so this depends on which of the two your boards is
wired up to.

	Arnd
