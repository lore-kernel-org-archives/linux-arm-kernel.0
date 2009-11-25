From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Thu, 26 Nov 2009 00:40:33 +0530
Subject: [PATCH] ARM l2x0: check whether l2x0 already enabled
In-Reply-To: <1259070933.16239.7.camel@pc1117.cambridge.arm.com>
References: <1259014663.2742.3.camel@vinay-desktop>
	<f2235a630911240411x67ad7e05k218b32e8d732dd0c@mail.gmail.com>
	<1259022908.2742.9.camel@vinay-desktop>
	<f2235a630911240535u4c75914buad3cb1239d5bb598@mail.gmail.com>
	<1259070933.16239.7.camel@pc1117.cambridge.arm.com>
Message-ID: <1259176233.30221.4.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-11-24 at 14:55 +0100, Catalin Marinas wrote:
> On Tue, 2009-11-24 at 13:35 +0000, Surinder P Singh wrote:
> > On Tue, Nov 24, 2009 at 6:05 AM, srinidhi kasagar
> > <srinidhi.kasagar@stericsson.com> wrote:
> > 
> > >> 2 points:
> > >>
> > >> 1. Since this code is also valid for devices based on pre-ARMv6, maybe
> > >> making this code conditional for >=ARMv6 would be cleaner ?
> > > rather it depends on l2 controller being used. L210 controllers
> > > do not have such restrictions whereas l220/pl310 have such kind
> > > of secure/non-secure restrictions. So would it be better to keep
> > > condition based on l2 controller being used?
> > >
> > 
> > Thats probably better. You can read the L2 cache ID register to figure
> > out if its a L210/220 or PL310 and so on. You can couple this check
> > with the cpu secure/non-secure state before deciding to write to the
> > registers.
> 
> I don't think it's worth the hassle. Just always check whether it is
> already enabled without additional ifdefs. IIRC, L210 is used on
> RealView PB1176 (not entirely sure).

So, does the patch which I have sent still valid which just checks
whether l2x0 is already enabled?

Srinidhi
