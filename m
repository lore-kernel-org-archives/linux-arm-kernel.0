From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Sep 2011 10:21:03 +0100
Subject: [PATCHv2 2/2] ARM: debug: Move DEBUG_ICEDCC into the DEBUG_LL
	choice
In-Reply-To: <4E83D25C.6020306@codeaurora.org>
References: <1316568208-4518-1-git-send-email-sboyd@codeaurora.org>
	<1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
	<4E83D25C.6020306@codeaurora.org>
Message-ID: <20110929092102.GB25061@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 03:05:16AM +0100, Stephen Boyd wrote:
> On 09/20/11 18:23, Stephen Boyd wrote:
> > DEBUG_ICEDCC support is just another DEBUG_LL choice and
> > selecting it along with other DEBUG_LL options doesn't make
> > much sense. Put it into the DEBUG_LL choice to avoid confusion.
> >
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > ---
> >
> 
> Chatting with David Brown made me realize that this patch now forces
> ICEDCC for anybody who selects DEBUG_LL and hasn't moved to adding a
> Kconfig in the choice menu. I'm not sure if that actually matters since
> it may be incentive to put your machine of choice into this menu.
> 
> Otherwise, we may want to drop this until a later point, or just leave
> it out of the choice menu altogether.

Given that the ICEDCC stuff shouldn't cause any other problems by having it
enabled (that is, your kernel should still boot) then we should be alright
leaving this as-is while platforms move over to the new scheme.

However, if we get attacked by the United Army of Enraged Platform Maintainers
wanting to use earlyprintk, then I'm hiding behind you :)

Will
