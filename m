From: msalter@redhat.com (Mark Salter)
Date: Tue, 20 Aug 2013 11:25:30 -0400
Subject: [PATCH] arm64: wire in generic parport.h
In-Reply-To: <CAMuHMdXfXAaNeCAhmxTQb007Um7AjqRdF2=85t1Po_63T7XT5w@mail.gmail.com>
References: <1376841688.11104.8.camel@t520.redhat.com>
 <CAMuHMdXfXAaNeCAhmxTQb007Um7AjqRdF2=85t1Po_63T7XT5w@mail.gmail.com>
Message-ID: <1377012330.2039.5.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-08-18 at 22:25 +0200, Geert Uytterhoeven wrote:
> On Sun, Aug 18, 2013 at 6:01 PM, Mark Salter <msalter@redhat.com> wrote:
> > The arm64 port doesn't provide a parport.h which causes a build failure
> > with some configurations:
> >
> >   drivers/parport/parport_pc.c:67:25: fatal error: asm/parport.h: No such file or directory
> >    #include <asm/parport.h>
> >
> > This patch wires in the generic parport.h for arm64.
> 
> Can arm64 have a PC-style parport?
> 
> If not, you're better off disabling it in drivers/parport/Kconfig.
> 
> You will receive bonus points for introducing ARCH_MAY_HAVE_PC_PARPORT,
> cfr. ARCH_MAY_HAVE_PC_FDC.

Okay, I have two versions of the patch. One which follows the PC_FDC
patch and adds something like this to arch/<somearch>/Kconfig:

config ARCH_MAY_HAVE_PC_PARPORT
	def_bool y


The other version adds:

config ARCH_MAY_HAVE_PC_PARPORT
	bool

to arch/Kconfig (or maybe that should be in drivers/parport/Kconfig) so
that the various arches just need to select it.

Is there any preference for one over the other?

--Mark
