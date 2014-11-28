From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Nov 2014 17:24:31 +0000
Subject: [PATCH v3 3/5] arm64: dts: Add support for Spreadtrum SC9836 SoC
 in dts and Makefile
In-Reply-To: <20141128164047.GL25883@leverpostej>
References: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-4-git-send-email-chunyan.zhang@spreadtrum.com>
 <20141127115042.GE857@leverpostej>
 <20141127121214.GF11511@e104818-lin.cambridge.arm.com>
 <20141127134309.GJ857@leverpostej>
 <20141128142913.GB5393@localhost>
 <20141128143532.GI25883@leverpostej>
 <20141128144412.GG7144@arm.com>
 <20141128150325.GC24370@e104818-lin.cambridge.arm.com>
 <20141128164047.GL25883@leverpostej>
Message-ID: <20141128172431.GA32393@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 04:40:47PM +0000, Mark Rutland wrote:
> [...]
> 
> > In the meantime I think we can be more tolerant:
> > 
> > diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> > index 2133f9d59d06..87f67a93fcc7 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -376,6 +376,8 @@ arch_timer_detect_rate(void __iomem *cntbase, struct device_node *np)
> >  			arch_timer_rate = readl_relaxed(cntbase + CNTFRQ);
> >  		else
> >  			arch_timer_rate = arch_timer_get_cntfrq();
> > +	} else if (IS_ENABLED(CONFIG_ARM64)) {
> > +		pr_warn("Architected timer frequency overridden by DT (broken firmware?)\n");
> >  	}
> 
> That looks good to me. On a related note, it looks like my documentation
> patch [1] from a while back fell by the wayside. Does anyone fancy
> picking that up to go with this?

I can put the two together (keeping you as author). Do we still need the
IS_ENABLED(CONFIG_ARM64) part here or we extend the warning to to arm32
as well?

-- 
Catalin
