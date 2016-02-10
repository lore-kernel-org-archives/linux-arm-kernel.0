From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Feb 2016 10:12:39 +0000
Subject: next-20160210 build: 2 failures 4 warnings (next-20160210)
In-Reply-To: <20160210100837.GT13270@sirena.org.uk>
References: <E1aTQoy-0005cH-Tr@optimist> <20160210100837.GT13270@sirena.org.uk>
Message-ID: <20160210101238.GC1052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 10:08:37AM +0000, Mark Brown wrote:
> On Wed, Feb 10, 2016 at 09:12:25AM +0000, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm64 allmodconfig due to:
> 
> > 	arm64-allmodconfig
> > ../arch/arm64/include/asm/processor.h:183:15: error: expected string literal before 'ARM64_LSE_ATOMIC_INSN'
> 
> due to 52e662326e1e915 (arm64: prefetch: don't provide
> spin_lock_prefetch with LSE) which adds use of ARM64_LSE_ATOMIC_INSN but
> does not add an inclusion of asm/lse.h which defines it.  Most files
> have an implicit include so build fine but a few don't which causes the
> failure.  It does add an inclusion of asm/alternative.h which may be the
> best place to add the inclusion.

I just sent a fix to the list.

Will
