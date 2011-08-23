From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Aug 2011 14:09:30 +0100
Subject: [PATCH v7 03/16] ARM: LPAE: Use PMD_(SHIFT|SIZE|MASK) instead
	of PGDIR_*
In-Reply-To: <20110823111533.GH19622@n2100.arm.linux.org.uk>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-4-git-send-email-catalin.marinas@arm.com>
	<20110823111533.GH19622@n2100.arm.linux.org.uk>
Message-ID: <20110823130930.GA17397@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 12:15:33PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 10, 2011 at 04:03:26PM +0100, Catalin Marinas wrote:
> > @@ -183,7 +183,7 @@ static int __init consistent_init(void)
> >  		}
> >  
> >  		consistent_pte[i++] = pte;
> > -		base += (1 << PGDIR_SHIFT);
> > +		base += (1 << PMD_SHIFT);
> 
> Please replace with PMD_SIZE.
> 
> Once combined with the "fixup! ARM: LPAE: Use PMD_(SHIFT|SIZE|MASK) instead of PGDIR_*"
> patch (and once whatever "fixup!" is done) this can be submitted to the
> patch system.

I send this one (with the folded fix-ups) and the other type casting to
your patch system (the "fixup!" is generated with git commit --fixup and
git rebase -i --autosquash does the folding automatically).

-- 
Catalin
