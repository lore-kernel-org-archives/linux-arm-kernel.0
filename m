From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 19 Dec 2012 15:28:06 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <201212181759.45394.arnd@arndb.de>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <20121211163932.GC16071@arm.com> <20121218162944.GA594@arm.com>
 <201212181759.45394.arnd@arndb.de>
Message-ID: <1355930886.22260.53.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-18 at 17:59 +0000, Arnd Bergmann wrote:
> On Tuesday 18 December 2012, Catalin Marinas wrote:
> > After some more thinking, none of these would work for arch/arm since
> > vexpress_clk_of_init() is called very early via the time_init() ...
> > v2m_dt_timer_init(). On arm64 we rely on the architected timers to be
> > always present but this assumption is not valid on arm where clocks
> > would need to be initialised early.
> > 
> > While I'd really like to get rid of the SoC code in arch/arm64, the best
> > place I see for the vexpress_clk_of_init() call is still the arch code
> > (unless we add #ifdefs in the clk-vexpress.c code).
> 
> I think I'd prefer the #ifdef in this case. Ideally, we would get rid
> of most of the early init functions in ARM as well, but that is
> a different battle for now. Getting the arch/arm64 to look nice
> IMHO is more important in this case, and we can fix the 32 bit
> version later.

I'm sure we'll be able to make the vexpress_clk_* functions behave
correctly, either with a help of #ifdef or in some other way - don't
concern yourself with this detail.

The bigger fish to fry is the generic initialization of the clocks (as
in: when to call the of_clk_init() and how to gather all possible
of_match-es)...

Pawe?
