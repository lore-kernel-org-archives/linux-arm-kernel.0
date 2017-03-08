From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 8 Mar 2017 12:20:16 +0000
Subject: [PATCH] arm64/sve: Reserve HWCAP and ELF note numbers for SVE
In-Reply-To: <20170306152447.GD22810@e104818-lin.cambridge.arm.com>
References: <1488550406-11204-1-git-send-email-Dave.Martin@arm.com>
 <20170306152447.GD22810@e104818-lin.cambridge.arm.com>
Message-ID: <20170308121948.GA3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 03:24:47PM +0000, Catalin Marinas wrote:
> On Fri, Mar 03, 2017 at 02:13:26PM +0000, Dave P Martin wrote:
> > --- a/include/uapi/linux/elf.h
> > +++ b/include/uapi/linux/elf.h
> > @@ -414,6 +414,7 @@ typedef struct elf64_shdr {
> >  #define NT_ARM_HW_BREAK	0x402		/* ARM hardware breakpoint registers */
> >  #define NT_ARM_HW_WATCH	0x403		/* ARM hardware watchpoint registers */
> >  #define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
> > +					/* 0x405 reserved for SVE */
> 
> Just a nitpick: given that this is generic file, even if it's in the
> ARM-specific section, it might be worth adding "ARM" to the comment:
> "reserved for ARM SVE" (not needed for hwcap).

Will do.

> Depending on the SVE merging timescales, this patch may go in together
> with the rest ;).

I need to respin this, because HWCAP_CPUID and HWCAP_ASIMDRDM went in
first (my bad, should have seen those in flight) -- since we are only
at -rc1 those could be renumbered, but it's probably not worth the
associated risks.

In any case, NT_ARM_SVE was the more important reservation.

Yao, Alan, does gdb make any use of HWCAP_SVE?

Cheers
---Dave 
