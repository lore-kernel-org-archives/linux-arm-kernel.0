From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Apr 2014 09:38:08 +0100
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <001501cf4ee2$8b639b50$a22ad1f0$%chung@samsung.com>
References: <00cb01cf4c94$725a6030$570f2090$@samsung.com>
 <9531814.OxBzcO1V3J@wuerfel> <20140331152719.GH29871@arm.com>
 <7050133.LRSn2ENgQ4@wuerfel> <20140401132316.GD20061@arm.com>
 <004b01cf4e27$d47da990$7d78fcb0$@samsung.com>
 <20140402090136.GA31892@arm.com> <20140402152455.GB24018@arm.com>
 <001501cf4ee2$8b639b50$a22ad1f0$%chung@samsung.com>
Message-ID: <20140403083806.GA17022@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 03:15:09AM +0100, Sungjinn Chung wrote:
> On Thursday, April 03, 2014 12:25 AM, Catalin Marinas wrote:
> > Another reason to decouple the page size is that we have 16K pages
> > specified in the ARM ARM (and we'll get hardware implementations at some
> > point). As a simple formula for the max VA space we can cover (capped at
> > 48-bit):
> > 
> > VA_BITS = (PAGE_SHIFT - 3) * levels + PAGE_SHIFT
> > 
> > With 16K pages and 3 levels we can cover 47 bits. So we'll eventually
> > have the following VA bits options:
> > 
> > 39 if 4K (3 levels)
> > 42 if 64K (2 levels)
> > 47 if 16K (3 levels)
> > 48 if 4K || 16K || 64K (4/4/3 levels depending on page size)
> 
> Separation for page size and VA bits looks great to me.
> 
> I think we can focus on only 4K and 64K at this point.

Yes.

> I'm worried about validation issue for 64K.

Why? The CPUs I'm aware of implement this feature.

> After we secure code for 4K and 64K with refactoring,
> 16K might not big thing.

Indeed, let's do the refactoring first.

> Jungseok or somebody else can do it. How about your opinion?

If you have time, please go ahead. I could do this as well but probably
early May.

-- 
Catalin
