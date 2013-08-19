From: msalter@redhat.com (Mark Salter)
Date: Sun, 18 Aug 2013 22:36:01 -0400
Subject: [PATCH] arm64: wire in generic parport.h
In-Reply-To: <CAMuHMdXfXAaNeCAhmxTQb007Um7AjqRdF2=85t1Po_63T7XT5w@mail.gmail.com>
References: <1376841688.11104.8.camel@t520.redhat.com>
 <CAMuHMdXfXAaNeCAhmxTQb007Um7AjqRdF2=85t1Po_63T7XT5w@mail.gmail.com>
Message-ID: <1376879761.11104.23.camel@t520.redhat.com>
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

Good question. I'm not sure, but really doubt it.

> 
> If not, you're better off disabling it in drivers/parport/Kconfig.
> 
> You will receive bonus points for introducing ARCH_MAY_HAVE_PC_PARPORT,
> cfr. ARCH_MAY_HAVE_PC_FDC.
> 

Yes, good point. I'll work up a new patch. I can use some bonus points.

--Mark
