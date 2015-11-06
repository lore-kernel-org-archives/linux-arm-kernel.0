From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Nov 2015 16:19:00 +0000
Subject: [PATCH] arm64: remove redundant FRAME_POINTER kconfig option
In-Reply-To: <20151106161214.GY7637@e104818-lin.cambridge.arm.com>
References: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
 <20151106123008.GK6087@arm.com>
 <20151106161214.GY7637@e104818-lin.cambridge.arm.com>
Message-ID: <20151106161859.GS6087@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 04:12:14PM +0000, Catalin Marinas wrote:
> On Fri, Nov 06, 2015 at 12:30:09PM +0000, Will Deacon wrote:
> > On Wed, Nov 04, 2015 at 09:37:51AM -0800, Yang Shi wrote:
> > > FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
> > > it in arch/arm64/Kconfig.debug.
> > 
> > It might be worth noting that this adds a dependency on DEBUG_KERNEL
> > for building with frame pointers. I'm ok with that (it appears to be
> > enabled in defconfig and follows the vast majority of other archs) but
> > it is a change in behaviour.
> 
> We shouldn't have the dependency on DEBUG_KERNEL since we select
> ARCH_WANT_FRAME_POINTERS on arm64. However, the patch would allow one to
> disable FRAME_POINTERS (not sure it has any effect on the aarch64 gcc
> though).

Ah yes, you're right about DEBUG_KERNEL. I completely misread the brackets
and the left-associativity of &&/|| works out.

I still think Rutland has a valid point wrt junk frame pointers, though.

Will
