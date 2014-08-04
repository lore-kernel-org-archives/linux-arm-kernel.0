From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Aug 2014 17:05:43 +0100
Subject: [PATCH v8 05/10] ARM: arch_timer: remove unused functions
In-Reply-To: <53DF8A9F.20203@mentor.com>
References: <1407003407-31219-1-git-send-email-nathan_lynch@mentor.com>
 <1407003407-31219-6-git-send-email-nathan_lynch@mentor.com>
 <20140804124924.GH15117@arm.com> <53DF8A9F.20203@mentor.com>
Message-ID: <20140804160543.GJ15117@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 02:29:03PM +0100, Nathan Lynch wrote:
> On 08/04/2014 07:49 AM, Will Deacon wrote:
> > On Sat, Aug 02, 2014 at 07:16:42PM +0100, Nathan Lynch wrote:
> >> -static inline void arch_counter_set_user_access(void)
> >> -{
> >> -	u32 cntkctl = arch_timer_get_cntkctl();
> >> -
> >> -	/* Disable user access to both physical/virtual counters/timers */
> >> -	/* Also disable virtual event stream */
> >> -	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
> >> -			| ARCH_TIMER_USR_VT_ACCESS_EN
> >> -			| ARCH_TIMER_VIRT_EVT_EN
> >> -			| ARCH_TIMER_USR_VCT_ACCESS_EN
> >> -			| ARCH_TIMER_USR_PCT_ACCESS_EN);
> >> -	arch_timer_set_cntkctl(cntkctl);
> >> -}
> >> -
> >> -static inline void arch_timer_evtstrm_enable(int divider)
> >> -{
> >> -	u32 cntkctl = arch_timer_get_cntkctl();
> >> -	cntkctl &= ~ARCH_TIMER_EVT_TRIGGER_MASK;
> >> -	/* Set the divider and enable virtual event stream */
> >> -	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
> >> -			| ARCH_TIMER_VIRT_EVT_EN;
> >> -	arch_timer_set_cntkctl(cntkctl);
> >> -	elf_hwcap |= HWCAP_EVTSTRM;
> >> -}
> >> -
> >>  #endif
> > 
> > Does these play nicely with the previous patch wrt bisection?
> 
> It should.  All call sites of these are fixed up in the previous patch.
>  Anything in particular you're concerned about?

Aha, I didn't realise you'd renamed the functions. In which case, this looks
find annd sorry for the noise.

Will
