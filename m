From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Apr 2015 17:10:49 +0100
Subject: [PATCH] ARM: VDSO: depend on CPU_V7
In-Reply-To: <3179253.8VITBr4Esl@wuerfel>
References: <1428529265-26772-1-git-send-email-nathan_lynch@mentor.com>
 <552FD47E.7030107@mentor.com> <3179253.8VITBr4Esl@wuerfel>
Message-ID: <20150416161049.GB12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 05:42:18PM +0200, Arnd Bergmann wrote:
> On Thursday 16 April 2015 10:25:50 Nathan Lynch wrote:
> > > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > > index b7644310236b..b4f92b9a13ac 100644
> > > --- a/arch/arm/mm/Kconfig
> > > +++ b/arch/arm/mm/Kconfig
> > > @@ -827,7 +827,7 @@ config KUSER_HELPERS
> > >  
> > >  config VDSO
> > >       bool "Enable VDSO for acceleration of some system calls"
> > > -     depends on AEABI && MMU
> > > +     depends on AEABI && MMU && CPU_V7
> > >       default y if ARM_ARCH_TIMER
> > >       select GENERIC_TIME_VSYSCALL
> > >       help
> > 
> > Before I put this in RMK's patch queue I'd prefer to get an ack or more
> > details (kernel config, toolchain) on the build failure, since I've been
> > unable to recreate it.  Arnd?
> > 
> 
> Good idea. I checked the patch against the failed randconfig, and must
> unfortunately report that it does not fix the problem.
> 
> I'm attaching the .config to this email. Two things to note:
> 
> - this is building for mach-rpc, so CONFIG_CPU_32v3 is enabled, and
>   presumably this is required for reproducing the problem, while
>   building for ARMv4 as I previously said in error does not cause
>   the problem.

Why doesn't it solve the problem?

In your config file, CPU_V7 is not set, so VDSO won't be set either.
Are you absolutely sure you tested with the above patch applied?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
