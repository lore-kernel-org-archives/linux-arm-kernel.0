From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 1 Apr 2014 10:46:48 +0100
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <000501cf4d43$90e618a0$b2b249e0$%chung@samsung.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <76240593.SAyloCy7nR@wuerfel> <20140331113113.GE29871@arm.com>
 <9531814.OxBzcO1V3J@wuerfel> <20140331152719.GH29871@arm.com>
 <000501cf4d43$90e618a0$b2b249e0$%chung@samsung.com>
Message-ID: <20140401094648.GB20061@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 01:44:36AM +0100, ??? wrote:
> On Tuesday, April 01, 2014 12:27 AM Catalin Marinas wrote:
> > I don't mind 4-level tables by default but I would still keep a
> > configuration option (or at least doing some benchmarks to assess the
> > impact before switching permanently to 4-levels). There are mobile
> > platforms that don't really need as much VA space (and people are even
> > talking about ILP32).
> 
> How about keep 3-level table by default and enable 4-level table with 
> config option?

We want single image, so the default should cover all platforms. If
someone wants to deploy a more specific kernel (e.g. for a mobile
platform), they could change the configuration to more suitable ones.

> Asymmetry level for kernel and user land would make code complicated.
> And usually more memory means that user application tends to use more memory.
> So I suggest same virtual space for both.

I don't really get the "more memory means ..." above ;). It's more
virtual space, the user application would not extend to use all of it
(most likely won't even notice).

Asymmetry wouldn't make things much more complicated. You can even
pretend you have 4 levels configured but used pgd_offset tricks to
effectively use 3 hardware levels.

-- 
Catalin
