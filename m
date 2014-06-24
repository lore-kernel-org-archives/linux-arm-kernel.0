From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 10:04:14 -0400 (EDT)
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <20140624134249.GB4489@arm.com>
References: <7416978.W29blLsymn@wuerfel> <20140624134249.GB4489@arm.com>
Message-ID: <alpine.LFD.2.11.1406240956540.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Catalin Marinas wrote:

> On Tue, Jun 24, 2014 at 02:17:06PM +0100, Arnd Bergmann wrote:
> > Since 3.16, we have the ability to build a multiplatform kernel
> > that includes both kirkwood (feroceon) and some other ARMv5 CPU.
> > 
> > I accidentally stumbled over a bug in the VFP code that looks
> > like it will break at least ARM9 VFP support if CPU_FEROCEON
> > is also enabled, introduced by this (old) commit:
> 
> I would argue that the bug is in the CPU (feroceon). See the end of this
> email:
> 
> http://www.spinics.net/lists/arm-kernel/msg41460.html
> 
> and my follow-up. Basically you can't avoid the conditional compilation
> as Feroceon doesn't follow the VFP sub-architecture spec and doesn't
> present itself as a different CPU from an _ARM_ 9. Unless things have
> changed with Marvell's hardware implementation and they got a new id, I
> suggest you don't enable this for multi-platform.

Only the early revision did hijack the ARM9 ID but still. We certainly 
can determine at run time if the platform being booted is equiped with a 
Feroceon before user space is started.  In that case I'd suggest some 
runtime code patching to branch to some out-of-line assembly code for 
Feroceon.


Nicolas
