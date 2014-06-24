From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Jun 2014 10:45:59 -0400 (EDT)
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <5647865.08hn2WHr6u@wuerfel>
References: <7416978.W29blLsymn@wuerfel>
 <20140624141423.GP32514@n2100.arm.linux.org.uk>
 <20140624142505.GF4489@arm.com> <5647865.08hn2WHr6u@wuerfel>
Message-ID: <alpine.LFD.2.11.1406241038570.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Arnd Bergmann wrote:

> On Tuesday 24 June 2014 15:25:05 Catalin Marinas wrote:
> > On Tue, Jun 24, 2014 at 03:14:23PM +0100, Russell King - ARM Linux wrote:
> > > On Tue, Jun 24, 2014 at 03:10:56PM +0100, Catalin Marinas wrote:
> > > > On Tue, Jun 24, 2014 at 03:04:14PM +0100, Nicolas Pitre wrote:
> > > > > On Tue, 24 Jun 2014, Catalin Marinas wrote:
> > > > > Only the early revision did hijack the ARM9 ID but still. We certainly 
> > > > > can determine at run time if the platform being booted is equiped with a 
> > > > > Feroceon before user space is started.  In that case I'd suggest some 
> > > > > runtime code patching to branch to some out-of-line assembly code for 
> > > > > Feroceon.
> > > > 
> > > > You don't even need to branch to out of line assembly, just branch over
> > > > the imprecise VFP abort handling in arch/arm/vfp/vfphw.S.
> > > 
> > > This is not just about VFP - it's much bigger than that.  Feroceon can't
> > > use proc-arm926.S (it has errata in the cache maintanence instructions)
> > > which also need handing.  That's why we have a separate implementation
> > > (proc-feroceon.S) so that ARM926 is not hurt by this stupidity.
> > 
> > As Arnd suggested, we could enable multi-platform only for newer
> > Feroceon chips which presumably have different id, keeping
> > CONFIG_CPU_FEROCEON_OLD_ID disabled.
> 
> Note that we do disable CONFIG_CPU_FEROCEON_OLD_ID for both
> kirkwood_defconfig and mvebu_v5_defconfig, and we don't even
> support multiplatform on orion5x (yet), which is the platform
> that needs CONFIG_CPU_FEROCEON_OLD_ID. It would be good to know
> if all Orion5x suffer from this problem, or just the older ones.

Only the early revisions did suffer from this.


Nicolas
