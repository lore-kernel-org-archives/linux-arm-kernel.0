From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Aug 2017 11:41:49 +0100
Subject: [PATCH v2 0/5] Rework the pte handling for hardware AF/DBM
In-Reply-To: <20170818172936.GA10043@arm.com>
References: <20170818172602.7624-1-catalin.marinas@arm.com>
 <20170818172936.GA10043@arm.com>
Message-ID: <20170821104148.25zlf2unja7xonbf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 06:29:36PM +0100, Will Deacon wrote:
> On Fri, Aug 18, 2017 at 06:25:57PM +0100, Catalin Marinas wrote:
> > That's the second version of the pte accessors reworking series (first
> > version at [1]).
> > 
> > Changes since v1:
> > 
> > - READ_ONCE moved out of the cmpxchg loops since cmpxchg already returns
> >   the old value (probably more efficient with LSE atomics)
> > 
> > - The first patch from the first series has been merged upstream (cc
> >   stable)
> > 
> > - Kconfig entry kept just to disable the hardware feature but the code
> >   paths all assume hardware AF/DBM
> > 
> > - PAGE_COPY(_EXEC) removed as they just duplicate PAGE_READONLY(_EXEC)
> > 
> > I kept the review-by tags in place as the logic is unchanged but feel
> > free to look at the patches again.
> 
> Thanks, this looks good to me now:
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks. I merged them into for-next/core.

-- 
Catalin
