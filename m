From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Aug 2011 19:10:33 +0100
Subject: [PATCH 1/5] ARM: hw_breakpoint: add initial Cortex-A15 (debug
	v7.1) support
In-Reply-To: <4E401F07.6060202@codeaurora.org>
References: <1312823572-9807-1-git-send-email-will.deacon@arm.com>
	<1312823572-9807-2-git-send-email-will.deacon@arm.com>
	<4E401F07.6060202@codeaurora.org>
Message-ID: <20110808181032.GA10072@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Aug 08, 2011 at 06:38:15PM +0100, Stephen Boyd wrote:
> On 08/08/2011 10:12 AM, Will Deacon wrote:
> > diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
> > index f389b27..0ac141a 100644
> > --- a/arch/arm/include/asm/hw_breakpoint.h
> > +++ b/arch/arm/include/asm/hw_breakpoint.h
> > @@ -50,6 +50,7 @@ static inline void decode_ctrl_reg(u32 reg,
> >  #define ARM_DEBUG_ARCH_V6_1	2
> >  #define ARM_DEBUG_ARCH_V7_ECP14	3
> >  #define ARM_DEBUG_ARCH_V7_MM	4
> > +#define ARM_DEBUG_ARCH_V7_1	5
> >  
> >  /* Breakpoint */
> >  #define ARM_BREAKPOINT_EXECUTE	0
> > diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> > index a927ca1..9848157 100644
> > --- a/arch/arm/kernel/hw_breakpoint.c
> > +++ b/arch/arm/kernel/hw_breakpoint.c
> > @@ -154,7 +154,7 @@ u8 arch_get_debug_arch(void)
> >  static int debug_arch_supported(void)
> >  {
> >  	u8 arch = get_debug_arch();
> > -	return arch >= ARM_DEBUG_ARCH_V6 && arch <= ARM_DEBUG_ARCH_V7_ECP14;
> > +	return arch >= ARM_DEBUG_ARCH_V6 && arch <= ARM_DEBUG_ARCH_V7_1;
> 
> Is ARM_DEBUG_ARCH_V7_MM supported now too?

Ah, well spotted. I'd better fix that check before somebody thinks I'm
committing to supporting the memory-mapped interface!

Thanks,

Will
