From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 1 May 2014 12:44:08 +0100
Subject: [RFC PATCH V4 3/7] arm: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <20140501111120.GF22316@arm.com>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-4-git-send-email-steve.capper@linaro.org>
 <20140501111120.GF22316@arm.com>
Message-ID: <20140501114408.GA4501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 12:11:21PM +0100, Catalin Marinas wrote:
> On Fri, Mar 28, 2014 at 03:01:28PM +0000, Steve Capper wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 1594945..7d5340d 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -58,6 +58,7 @@ config ARM
> >  	select HAVE_PERF_EVENTS
> >  	select HAVE_PERF_REGS
> >  	select HAVE_PERF_USER_STACK_DUMP
> > +	select HAVE_RCU_TABLE_FREE if SMP
> 
> You select this if (SMP && CPU_V7). On ARMv6 SMP systems we use IPI for
> TLB maintenance already.

Thanks, I'll add that to the next series.
-- 
Steve
> 
> -- 
> Catalin
