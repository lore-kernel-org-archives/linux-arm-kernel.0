From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Sat, 15 Mar 2014 15:00:43 +0000
Subject: Possible mistake in defining TTBR cache-able attributes for
 v7-2 level ?
In-Reply-To: <CAPub14-48TVcLYHznCcYm+CaXZD_BBOz4Ah1WWuBujFRUM_sqw@mail.gmail.com>
References: <CAPub149amJ0Aa7Y8DLkHbkQzcKFfr--d8oiuFsw7MMokAia4xw@mail.gmail.com>
 <20140314155359.GH18126@arm.com>
 <CAPub14-48TVcLYHznCcYm+CaXZD_BBOz4Ah1WWuBujFRUM_sqw@mail.gmail.com>
Message-ID: <c33dee291988487c985169d155122110@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shiraz,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Shiraz Hashim
> Sent: Saturday, March 15, 2014 6:37 PM
> To: Catalin Marinas
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: Possible mistake in defining TTBR cache-able attributes for
> v7-2 level ?
> 
> On Fri, Mar 14, 2014 at 9:23 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > On Fri, Mar 14, 2014 at 01:46:27PM +0000, Shiraz Hashim wrote:
> > > TTB_IRGN_WBWA macro defined in arch/arm/mm/proc-v7-2level.S, seems
> > > incorrect
> > >
> > > #define TTB_IRGN_WBWA   ((0 << 0) | (1 << 6))
> > >
> > > Its intention seems to program as write back and write allocate
> > > whereas it actually programs it  write-through,
> > >
> > > From ARM TRM
> > >
> > > The possible values of IRGN[1:0] are:
> > >   0b00 Normal memory, Inner Non-cacheable.
> > >   0b01 Normal memory, Inner Write-Back Write-Allocate Cacheable.
> > >   0b10 Normal memory, Inner Write-Through Cacheable.
> > >   0b11 Normal memory, Inner Write-Back no Write-Allocate Cacheable.
> > >
> > > --IRGN[0] is b'0 and IRGN[1] is b'6
> >
> > In the ARMv7 ARM, IRGN[0] is bit 6 and IRGN[1] is bit 0. Which TRM is
> > this?
> >
> 
> I am referring to Cortex A53 TRM, here
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0500d/CIHI
> DJFJ.html

Cortex A53 is ARMv8 architecture. You should probably look here for ARMv8 architecture:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/arch/arm64/mm/proc.S?id=refs/tags/next-20140110#n2

Regards,
Bhupesh

> 
> --
> regards
> Shiraz Hashim
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
