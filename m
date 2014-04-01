From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 1 Apr 2014 12:22:34 +0100
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <000c01cf4d93$0863e750$192bb5f0$%chung@samsung.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <76240593.SAyloCy7nR@wuerfel> <20140331113113.GE29871@arm.com>
 <9531814.OxBzcO1V3J@wuerfel> <20140331152719.GH29871@arm.com>
 <000501cf4d43$90e618a0$b2b249e0$%chung@samsung.com>
 <20140401094648.GB20061@arm.com>
 <000c01cf4d93$0863e750$192bb5f0$%chung@samsung.com>
Message-ID: <20140401112234.GC20061@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 11:13:27AM +0100, ??? wrote:
> On Tuesday, April 01, 2014 6:47 PM, Catalin Marinas wrote:
> > On Tue, Apr 01, 2014 at 01:44:36AM +0100, ??? wrote:
> > > On Tuesday, April 01, 2014 12:27 AM Catalin Marinas wrote:
> > > > I don't mind 4-level tables by default but I would still keep a
> > > > configuration option (or at least doing some benchmarks to assess the
> > > > impact before switching permanently to 4-levels). There are mobile
> > > > platforms that don't really need as much VA space (and people are even
> > > > talking about ILP32).
> > >
> > > How about keep 3-level table by default and enable 4-level table with
> > > config option?
> > 
> > We want single image, so the default should cover all platforms. If
> > someone wants to deploy a more specific kernel (e.g. for a mobile
> > platform), they could change the configuration to more suitable ones.
> Single image would have merit but I think one way should be default 
> Configuration and another should be specific kernel for smaller or lager 
> memory platform.
> Which one do you want as default configuration among 3 level and 4 level?

The default should be 4 levels to cover all cases. You can tweak the
config for your platform if you want to deploy a specific kernel image.

> > > Asymmetry level for kernel and user land would make code complicated.
> > > And usually more memory means that user application tends to use more memory.
> > > So I suggest same virtual space for both.
> > 
> > I don't really get the "more memory means ..." above ;). It's more
> > virtual space, the user application would not extend to use all of it
> > (most likely won't even notice).
> The reason why we need 4 level page table is originally is that we need
> bigger physical memory and kernel does not have enough virtual space.

So, you need more virtual space in the kernel to be able to linearly map
the physical address space. That's fine.

> Please consider this is not only for making virtual bigger.
> It's to make system use large physical memory for user application.

Do you want to use more than 512GB of physical memory for a user
application?

-- 
Catalin
