From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 01 Dec 2009 18:35:04 +0000
Subject: [PATCH] ARM l2x0: check whether l2x0 already enabled
In-Reply-To: <1259176233.30221.4.camel@vinay-desktop>
References: <1259176233.30221.4.camel@vinay-desktop>
Message-ID: <1259692504.2121.237.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-11-25 at 19:10 +0000, srinidhi kasagar wrote:
> On Tue, 2009-11-24 at 14:55 +0100, Catalin Marinas wrote:
> > On Tue, 2009-11-24 at 13:35 +0000, Surinder P Singh wrote:
> > > On Tue, Nov 24, 2009 at 6:05 AM, srinidhi kasagar
> > > <srinidhi.kasagar@stericsson.com> wrote:
> > >
> > > >> 2 points:
> > > >>
> > > >> 1. Since this code is also valid for devices based on pre-ARMv6, maybe
> > > >> making this code conditional for >=ARMv6 would be cleaner ?
> > > > rather it depends on l2 controller being used. L210 controllers
> > > > do not have such restrictions whereas l220/pl310 have such kind
> > > > of secure/non-secure restrictions. So would it be better to keep
> > > > condition based on l2 controller being used?
> > > >
> > >
> > > Thats probably better. You can read the L2 cache ID register to figure
> > > out if its a L210/220 or PL310 and so on. You can couple this check
> > > with the cpu secure/non-secure state before deciding to write to the
> > > registers.
> >
> > I don't think it's worth the hassle. Just always check whether it is
> > already enabled without additional ifdefs. IIRC, L210 is used on
> > RealView PB1176 (not entirely sure).
> 
> So, does the patch which I have sent still valid which just checks
> whether l2x0 is already enabled?

OK with me as well, just minor issues with the coding style (the
multi-line comment).

-- 
Catalin
