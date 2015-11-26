From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Nov 2015 15:10:53 +0000
Subject: next-20151126 build: 3 failures 15 warnings (next-20151126)
In-Reply-To: <20151126113213.GC1929@sirena.org.uk>
References: <E1a1sVV-00079q-My@optimist> <20151126113213.GC1929@sirena.org.uk>
Message-ID: <20151126151053.GK3109@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 11:32:13AM +0000, Mark Brown wrote:
> Today's -next fails to build an arm64 allnoconfig due to:
> 
> > 	arm64-allnoconfig
> > ../arch/arm64/mm/mmap.c:55:49: error: 'mmap_rnd_compat_bits' undeclared (first use in this function)
> 
> which was introduced by a combination of 8f62c06c279a3 (mm: mmap: add
> new /proc tunable for mmap_base ASLR) and 9411708692954 (arm64: mm:
> support ARCH_MMAP_RND_BITS).  These add an unconditional use of
> mmap_rnd_compat_bits which is only defined in linux/mmap.h if
> HAVE_ARCH_MMAP_RND_COMPAT_BITS is selected but that is only enabled for
> arm64 if COMPAT is enabled.  Either the select needs to be unconditional
> or the use needs to be.

There are other problems with these patches for arm64, I already replied
here:

http://lkml.kernel.org/g/20151125120601.GC3109 at e104818-lin.cambridge.arm.com

So I don't think they should be in -next.

-- 
Catalin
