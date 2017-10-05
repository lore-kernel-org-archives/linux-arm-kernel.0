From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Oct 2017 14:29:20 +0100
Subject: [PATCH] arm64: mm: Clarify a printk in data_abort_decode()
In-Reply-To: <20171005132242.u3c2gy6edpkkt2sr@mwanda>
References: <20171005125914.34uc5qq5titpq6zi@mwanda>
 <20171005130436.GB5235@leverpostej>
 <20171005132242.u3c2gy6edpkkt2sr@mwanda>
Message-ID: <20171005132920.GC5235@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 04:22:42PM +0300, Dan Carpenter wrote:
> On Thu, Oct 05, 2017 at 02:04:36PM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > On Thu, Oct 05, 2017 at 03:59:14PM +0300, Dan Carpenter wrote:
> > > The 0x in front of a base 10 number is misleading so I removed it.
> > > 
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index 89993c4be1be..a5382e90418c 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -97,7 +97,7 @@ static void data_abort_decode(unsigned int esr)
> > >  			 (esr & ESR_ELx_SF) >> ESR_ELx_SF_SHIFT,
> > >  			 (esr & ESR_ELx_AR) >> ESR_ELx_AR_SHIFT);
> > >  	} else {
> > > -		pr_alert("  ISV = 0, ISS = 0x%08lu\n", esr & ESR_ELx_ISS_MASK);
> > > +		pr_alert("  ISV = 0, ISS = %08lu\n", esr & ESR_ELx_ISS_MASK);
> > 
> > A fix has already been queued [0,1], ensuring this is printed as hex.
> > 
> > Catalin, I see that hasn't been pushed out to the arm64 fixes/core
> > branch. Is that deliberate?
> 
> Stephen is on vacation so there is no linux-next and I'm on ancient code
> anyway.  :/

Sure; it's just easier to peek at fixes/core than to trawl the list when
it's up-to-date. ;)

Thanks,
Mark.
