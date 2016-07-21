From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Jul 2016 14:53:46 +0100
Subject: [PATCH v2] arm64: KVM: VHE: Context switch MDSCR_EL1
In-Reply-To: <20160721134937.GA4603@potion>
References: <1468933014-26966-1-git-send-email-marc.zyngier@arm.com>
 <20160721131720.GA32739@potion> <20160721142451.2ee990ce@arm.com>
 <20160721134937.GA4603@potion>
Message-ID: <20160721145346.470fea00@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jul 2016 15:49:38 +0200
Radim Kr?m?? <rkrcmar@redhat.com> wrote:

> 2016-07-21 14:24+0100, Marc Zyngier:
> > On Thu, 21 Jul 2016 15:17:20 +0200
> > Radim Kr?m?? <rkrcmar@redhat.com> wrote:
> > 
> > Hi Radim,
> >   
> >> 2016-07-19 13:56+0100, Marc Zyngier:  
> >> > The kprobe enablement work has uncovered that changes made by
> >> > a guest to MDSCR_EL1 were propagated to the host when VHE was
> >> > enabled, leading to unexpected exception being delivered.
> >> > 
> >> > Moving this register to the list of registers that are always
> >> > context-switched fixes the issue.
> >> > 
> >> > Fixes: 9c6c35683286 ("arm64: KVM: VHE: Split save/restore of registers shared between guest and host")
> >> > Cc: stable at vger.kernel.org #4.6
> >> > Reported-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
> >> > Tested-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
> >> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> > ---    
> >> 
> >> I would take this patch to 4.7 directly through the main tree.
> >> Are your plans different?  
> > 
> > If you're happy to take it now, that works for me.  
> 
> The fix is clear, tested, and would go to 4.7.stable.  Better to have it
> in 4.7, IMO.

Agreed.

> >                                                    I can either send a
> > PR right away, or you can apply it directly, whichever works best for
> > you.  
> 
> It is just one patch so I'll apply it and send a pull request to Linus
> on Saturday;  less cummulative work that way. :)

Brilliant. Thanks Radim.

	M.
-- 
Jazz is not dead. It just smells funny.
