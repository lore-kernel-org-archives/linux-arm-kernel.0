From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Dec 2012 17:59:45 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <20121218162944.GA594@arm.com>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <20121211163932.GC16071@arm.com> <20121218162944.GA594@arm.com>
Message-ID: <201212181759.45394.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 December 2012, Catalin Marinas wrote:
> After some more thinking, none of these would work for arch/arm since
> vexpress_clk_of_init() is called very early via the time_init() ...
> v2m_dt_timer_init(). On arm64 we rely on the architected timers to be
> always present but this assumption is not valid on arm where clocks
> would need to be initialised early.
> 
> While I'd really like to get rid of the SoC code in arch/arm64, the best
> place I see for the vexpress_clk_of_init() call is still the arch code
> (unless we add #ifdefs in the clk-vexpress.c code).

I think I'd prefer the #ifdef in this case. Ideally, we would get rid
of most of the early init functions in ARM as well, but that is
a different battle for now. Getting the arch/arm64 to look nice
IMHO is more important in this case, and we can fix the 32 bit
version later.

	Arnd
