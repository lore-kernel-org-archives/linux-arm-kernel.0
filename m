From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Sep 2016 13:48:07 +0100
Subject: [PATCH 4/7] arm64: tlbflush.h: add __tlbi() macro
In-Reply-To: <20160923160710.GF6397@arm.com>
References: <1473761769-30572-1-git-send-email-punit.agrawal@arm.com>
 <1473761769-30572-5-git-send-email-punit.agrawal@arm.com>
 <20160923160710.GF6397@arm.com>
Message-ID: <20160928124806.GI24658@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 05:07:10PM +0100, Will Deacon wrote:
> On Tue, Sep 13, 2016 at 11:16:06AM +0100, Punit Agrawal wrote:
> > From: Mark Rutland <mark.rutland@arm.com>
> > 
> > As with dsb() and isb(), add a __tlbi() helper so that we can avoid
> > distracting asm boilerplate every time we want a TLBI. As some TLBI
> > operations take an argument while others do not, some pre-processor is
> > used to handle these two cases with different assembly blocks.
> > 
> > The existing tlbflush.h code is moved over to use the helper.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > [ rename helper to __tlbi, update comment and commit log ]
> > Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/include/asm/tlbflush.h | 34 ++++++++++++++++++++++++++--------
> >  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> Given that this series seems to have stalled, I'm inclined to pick this
> patch (and only this patch) up in the arm64 tree. It's a standalone tidy
> up and means one fewer dependency next time round.

Ok, I've picked this one up. Please re-post the rest of the series after
the merge window.

Will
