From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Nov 2014 10:34:51 +0000
Subject: [PATCHv3 4/5] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <9hhk3372duw.fsf@e105922-lin.cambridge.arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-6-git-send-email-punit.agrawal@arm.com>
 <20141105130513.GH32700@e104818-lin.cambridge.arm.com>
 <9hhk3372duw.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20141113103450.GD20652@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 04:07:51PM +0000, Punit Agrawal wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Mon, Oct 27, 2014 at 06:40:06PM +0000, Punit Agrawal wrote:
> >> diff --git a/Documentation/arm64/legacy_instructions.txt b/Documentation/arm64/legacy_instructions.txt
> >> index 5ab5861..a3b3da2 100644
> >> --- a/Documentation/arm64/legacy_instructions.txt
> >> +++ b/Documentation/arm64/legacy_instructions.txt
> >> @@ -38,3 +38,8 @@ Supported legacy instructions
> >>  Node: /proc/sys/abi/swp
> >>  Status: Obsolete
> >>  Default: Undef (0)
> >> +
> >> +* CP15 Barriers
> >> +Node: /proc/sys/abi/cp15_barrier
> >> +Status: Deprecated
> >> +Default: Emulate (1)
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 6ae8079..2f7026e 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -199,6 +199,21 @@ config SWP_EMULATION
> >>  
> >>  	  If unsure, say N
> >>  
> >> +config CP15_BARRIER_EMULATION
> >> +	bool "Emulate CP15 Barrier instructions"
> >> +	help
> >> +	  The CP15 barrier instructions - CP15ISB, CP15DSB, and
> >> +	  CP15DMB - are deprecated in ARMv8 (and ARMv7). It is
> >> +	  strongly recommended to use the ISB, DSB, and DMB
> >> +	  instructions instead.
> >> +
> >> +	  Say Y here to enable software emulation of these
> >> +	  instructions for AArch32 userspace code. When this option is
> >> +	  enabled, CP15 barrier usage is traced which can help
> >> +	  identify software that needs updating.
> >> +
> >> +	  If unsure, say N
> >> +
> >>  endif
> >
> > default y (I think we had a discussion in private whether deprecated
> > should default to y and obsolete to y or n but I don't remember the
> > conclusion; it's worth adding it to the Documentation/ file).
> 
> Based on the outcome of the discussion, I've documented the runtime
> defaults ('undef' for obsolete and 'emulation' for deprecated instructions)
> in the previous patch (3/5).
> 
> As for Kconfig, the conclusion was to keep them off by default. The
> rationale was that they can be enabled quite easily and would form
> another way to communicate that certain features are deprecated and
> software might need updating.

Sounds fine.

-- 
Catalin
