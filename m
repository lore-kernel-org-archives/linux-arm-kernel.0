From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Nov 2012 21:14:49 +0000
Subject: Building for MMU-less vexpress targets
In-Reply-To: <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
References: <20121105173640.GR3351@mudshark.cambridge.arm.com>
 <201211061733.44781.arnd@arndb.de>
 <alpine.LFD.2.02.1211061533490.21033@xanadu.home>
Message-ID: <201211062114.49933.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 November 2012, Nicolas Pitre wrote:
> Maybe you are confused by CONFIG_ARCH_MTD_XIP where special support is 
> needed in order to make writable MTD devices compatible with a XIP 
> kernel located on them.  That is indeed only available for ARCH_PXA and 
> ARCH_SA1100.

Ok, I see.

> I really think that it makes no sense at all to support !MMU kernels in 
> a multi-platform kernel build, even if the set of included platforms 
> were all !MMU.  The kernel has to be linked for the physical address of 
> the target and not a common invariant virtual address.

There are two separate aspects here: One is to run a kernel on !MMU that is
built to support multiple platforms. I agree that this is rather pointless
and not interesting.

The other point is being able to build such a kernel, and this is what Will
seems to be interested in more. We have made VEXPRESS depend on
MULTIPLATFORM, which broke support for building a non-MMU vexpress kernel,
and I think we should fix that. The two options are either to make
vexpress be single-platform when building for !MMU, or to allow multiplatform
kernels to be built without MMU support in principle. I think the second
option is more logical and avoids complex Kconfig constructs.

	Arnd
