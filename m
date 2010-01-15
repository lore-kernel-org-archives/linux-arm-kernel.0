From: jpihet@mvista.com (Jean Pihet)
Date: Fri, 15 Jan 2010 16:34:51 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203A8571C75@dlee02.ent.ti.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<200912221751.39662.jpihet@mvista.com>
	<13B9B4C6EF24D648824FF11BE896716203A8571C75@dlee02.ent.ti.com>
Message-ID: <201001151634.52122.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard,

On Friday 08 January 2010 23:17:10 Woodruff, Richard wrote:
> > From: linux-arm-kernel-bounces at lists.infradead.org
> > [mailto:linux-arm-kernel- bounces at lists.infradead.org] On Behalf Of Jean
> > Pihet
> > Sent: Tuesday, December 22, 2009 10:52 AM
> >
> > 2) Please note that the Cortex-A9 events do not easily map to the
> > predefined events. Cf. armv7_a9_perf_map and armv7_a9_perf_cache_map in
> > the code. - the PERF_COUNT_HW_INSTRUCTIONS event is not found. It looks
> > like the number of instructions is calculated by adding events numbers
> > (events from 0x70 till 0x74: MAIN_UNIT_EXECUTED_INST,
> > SECOND_UNIT_EXECUTED_INST,
> > LD_ST_UNIT_EXECUTED_INST, FP_EXECUTED_INST and NEON_EXECUTED_INST),
> > - the HW_BRANCH events are not found
> > - the global cache events 0x50 and 0x51 define the COHERENT_LINE_HIT and
> > COHERENT_LINE_MISS events, is that correct?
> > - L1 and L2 cache events are not found. Those could be available in
> > separate PL310 registers, TBC
>
> Recently I had done a side by side diff of A8 and A9 events for OMAP4.
>
> It is notable that L2 cache events for CortexA8 come up through same PMNC
> register interface as ARMv7 core events.  For CortexA9 + PL310 the L2
> events all come up through a _different_ register interface.  The interface
> is still simple but different.
Ok that could be done after the first ARMv7 support is merged in. Where can I 
find more info about the PL310 interface?

> - Several of the registers needed to enable PL310 event bus are Trustzone
> protected.  This will lead to some messiness in getting at them through
> monitor mode proxies.
Mmh security related code might be missing here. More investigation is needed.

> - A9 is missing a few events at core level and all l2 events which come up
> through pl310 regs.
Ok.

> - A9 has a few more event counter instances over A8. This grows some
> registers in expected way.
The latest code supports up to 1+31 events as defined in the A8 and A9 specs. 
The number of counters is dynamically read at Perf Events init.

> One bit I didn't get clear on was if any entity was trying to account for
> per-core stats at the shared PL310 level.  Each core can give stats in
> familiar manner but association of both cores with common pl310 is not
> clear.
Ok it wouls be nice to have all the details.

> Regards,
> Richard W.

Thanks & regards,
Jean
