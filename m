From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Aug 2014 10:42:14 +0100
Subject: [PATCH 6/6] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <9hhzjepc5z1.fsf@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-7-git-send-email-punit.agrawal@arm.com>
 <20140827174001.GI13850@arm.com> <9hhzjepc5z1.fsf@arm.com>
Message-ID: <20140828094214.GB31111@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 10:34:58AM +0100, Punit Agrawal wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
> > On Tue, Aug 26, 2014 at 11:28:50AM +0100, Punit Agrawal wrote:
> >> diff --git a/arch/arm64/kernel/v7_obsolete.c b/arch/arm64/kernel/v7_obsolete.c
> >> index e9427cb..ed77889 100644
> >> --- a/arch/arm64/kernel/v7_obsolete.c
> >> +++ b/arch/arm64/kernel/v7_obsolete.c
> >> @@ -227,6 +227,94 @@ static void __init swp_emulation_init(void)
> >>  		pr_notice("Registered SWP/SWPB emulation handler\n");
> >>  }
> >>  
> >> +static atomic_t cp15_barrier_count;
> >
> > Should we add counters for each barrier type? It may be more
> > informative.
> 
> Arnd proposed to use trace points instead of counters. I can emit
> different trace points for the different barrier types.

This would work as well.

-- 
Catalin
