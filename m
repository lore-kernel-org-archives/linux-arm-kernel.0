From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Oct 2014 23:23:40 +0200
Subject: [PATCH v4 4/6] ARM: rockchip: add basic smp support for rk3288
In-Reply-To: <CAD=FV=WGnE3fBfzLGN_x8dFqq4RV=OnVAyUgRQheMiyG4U7TkQ@mail.gmail.com>
References: <1413231122-1770-1-git-send-email-kever.yang@rock-chips.com>
 <1413231122-1770-5-git-send-email-kever.yang@rock-chips.com>
 <CAD=FV=WGnE3fBfzLGN_x8dFqq4RV=OnVAyUgRQheMiyG4U7TkQ@mail.gmail.com>
Message-ID: <1453932.GC4UXrUPRz@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 14. Oktober 2014, 13:24:03 schrieb Doug Anderson:
> Kever,
> 
> On Mon, Oct 13, 2014 at 1:12 PM, Kever Yang <kever.yang@rock-chips.com> 
wrote:
> > +       /*
> > +        * We need to soft reset the cpu when we turn off the cpu power
> > domain, +        * or else the active processors might be stalled when
> > the individual +        * processor is powered down.
> > +        */
> > +       if (read_cpuid_part_number() != ARM_CPU_PART_CORTEX_A9) {
> 
> I haven't done a full review of this patch, but it seems unlikely that
> your uses of read_cpuid_part_number() and read_cpuid_part() in this
> patch are correct.  You use both functions and in both cases compare
> the results to ARM_CPU_PART_CORTEX_A9.

I think read_cpuid_part() would be the correct one, as it does

	read_cpuid_id() & ARM_CPU_PART_MASK

which in turn should mask the correct parts of the cpuid to match against 
ARM_CPU_PART_CORTEX_A9 [0].



[0] http://lxr.free-electrons.com/source/arch/arm/include/asm/cputype.h#L77
