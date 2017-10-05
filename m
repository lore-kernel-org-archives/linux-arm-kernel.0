From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Oct 2017 16:05:17 +0100
Subject: [PATCH] arm64: mm: Clarify a printk in data_abort_decode()
In-Reply-To: <20171005130436.GB5235@leverpostej>
References: <20171005125914.34uc5qq5titpq6zi@mwanda>
 <20171005130436.GB5235@leverpostej>
Message-ID: <20171005150517.kshu2ftduw5rpg4d@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 02:04:36PM +0100, Mark Rutland wrote:
> On Thu, Oct 05, 2017 at 03:59:14PM +0300, Dan Carpenter wrote:
> > The 0x in front of a base 10 number is misleading so I removed it.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 89993c4be1be..a5382e90418c 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -97,7 +97,7 @@ static void data_abort_decode(unsigned int esr)
> >  			 (esr & ESR_ELx_SF) >> ESR_ELx_SF_SHIFT,
> >  			 (esr & ESR_ELx_AR) >> ESR_ELx_AR_SHIFT);
> >  	} else {
> > -		pr_alert("  ISV = 0, ISS = 0x%08lu\n", esr & ESR_ELx_ISS_MASK);
> > +		pr_alert("  ISV = 0, ISS = %08lu\n", esr & ESR_ELx_ISS_MASK);
> 
> A fix has already been queued [0,1], ensuring this is printed as hex.
> 
> Catalin, I see that hasn't been pushed out to the arm64 fixes/core
> branch. Is that deliberate?

No. Only that my tests took about a day to complete. I'll push the
patches out today.

-- 
Catalin
