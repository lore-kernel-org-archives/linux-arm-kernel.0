From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Feb 2010 18:19:20 -0000
Subject: [PATCH 4/5] arm: enable support for software perf events
In-Reply-To: <20100202174000.GB29701@n2100.arm.linux.org.uk>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>	<1263471256-3739-4-git-send-email-jamie.iles@picochip.com>	<1263471256-3739-5-git-send-email-jamie.iles@picochip.com>
	<20100202174000.GB29701@n2100.arm.linux.org.uk>
Message-ID: <008201caa434$3dbafe00$b930fa00$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Jamie,

* Russell King wrote:
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 293a879..72646b2 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -21,6 +21,8 @@ config ARM
> >  	select HAVE_KERNEL_GZIP
> >  	select HAVE_KERNEL_LZO
> >  	select GENERIC_ATOMIC64
> 
> This conflicts - this select is only if !CPU_32v6K in my kernel.
> 
> What's the implication?  Does this perf stuff require these atomic64
> stuff (in which case, those symbols should only be selected if
> GENERIC_ATOMIC64 is also selected.)

This conflicts because I submitted native atomic64 routines recently.
The native routines can only be used if CPU_32v6K is asserted, falling
back on the generic implementation otherwise.

Jamie has based his patches on a tree without the native routines,
so to resolve this the GENERIC_ATOMIC64 if !CPU_32v6K should be left
alone [then perf will use whatever it is given].

Cheers,

Will
