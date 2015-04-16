From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 17:42:18 +0200
Subject: [PATCH] ARM: VDSO: depend on CPU_V7
In-Reply-To: <552FD47E.7030107@mentor.com>
References: <1428529265-26772-1-git-send-email-nathan_lynch@mentor.com>
 <552FD47E.7030107@mentor.com>
Message-ID: <3179253.8VITBr4Esl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 10:25:50 Nathan Lynch wrote:
> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index b7644310236b..b4f92b9a13ac 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -827,7 +827,7 @@ config KUSER_HELPERS
> >  
> >  config VDSO
> >       bool "Enable VDSO for acceleration of some system calls"
> > -     depends on AEABI && MMU
> > +     depends on AEABI && MMU && CPU_V7
> >       default y if ARM_ARCH_TIMER
> >       select GENERIC_TIME_VSYSCALL
> >       help
> 
> Before I put this in RMK's patch queue I'd prefer to get an ack or more
> details (kernel config, toolchain) on the build failure, since I've been
> unable to recreate it.  Arnd?
> 

Good idea. I checked the patch against the failed randconfig, and must
unfortunately report that it does not fix the problem.

I'm attaching the .config to this email. Two things to note:

- this is building for mach-rpc, so CONFIG_CPU_32v3 is enabled, and
  presumably this is required for reproducing the problem, while
  building for ARMv4 as I previously said in error does not cause
  the problem.

- I have verified that CONFIG_VDSO is disabled here, but the file is
  still getting compiled.

	Arnd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: randconfig-vds-bug.gz
Type: application/gzip
Size: 16868 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150416/29cd4fb7/attachment-0001.gz>
