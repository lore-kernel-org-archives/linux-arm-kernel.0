From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 May 2011 14:20:33 +0200
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <BANLkTim_0eRvDkQwAYjTNQsOVQiHV+DdBQ@mail.gmail.com>
References: <201105181047.17309.arnd@arndb.de>
	<BANLkTim_0eRvDkQwAYjTNQsOVQiHV+DdBQ@mail.gmail.com>
Message-ID: <201105191420.33269.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 May 2011, Barry Song wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8fce5e6..942d052 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -630,6 +630,17 @@ S: Maintained
> >  F:     drivers/amba/
> >  F:     include/linux/amba/bus.h
> >
> > +ARM SUBARCHITECTURES
> > +M:     Arnd Bergmann <arnd@arndb.de>
> > +M:     Nicolas Pitre <nico@fluxnic.net>
> > +M:     Thomas Gleixner <tglx@linutronix.de>
> > +M:     arm at kernel.org
> > +L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > +S:     MAINTAINEDftp.arm.linux.org.uk Git - linux-2.6-arm.git/summary
> > +F:     arch/arm/mach-*/
> > +F:     arch/arm/plat-*/
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-subarch.git
> > +
> 
> does it mean if we want to add a new SoC plat/mach, we will send
> patches againest this tree?

You should submit it for inclusion into this tree, but as a new branch
(or multiple branches) forked off from the mainline tree. We will make sure
it cleanly merges with the other subarchitectures.

> will this tree merge into rmk's tree? then rmk's tree will only manage
> arm common codes?

We'll see. My current idea is that we will push all subarchitecture branches
upstream to Linus directly, while Russell pushes the core branch(es) upstream
in parallel, but the master branch of the subarch tree could end up pulling
in the core tree as well, in order to make life easier for Stephen's
linux-next tree that needs both. This depends to some degree on whether
Russell wants to keep some subarchitectures in his own tree, or we put all
of them in the new subarch tree.

	Arnd
