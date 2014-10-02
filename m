From: b.galvani@gmail.com (Beniamino Galvani)
Date: Thu, 2 Oct 2014 19:05:19 +0200
Subject: [PATCH 1/6] ARM: meson: add meson8 machine definition
In-Reply-To: <11073411.IcmTkIICYA@wuerfel>
References: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
 <1412198986-26534-2-git-send-email-b.galvani@gmail.com>
 <11073411.IcmTkIICYA@wuerfel>
Message-ID: <20141002170519.GA29052@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 02, 2014 at 11:24:54AM +0200, Arnd Bergmann wrote:
> On Wednesday 01 October 2014 23:29:41 Beniamino Galvani wrote:
> > 
> > +static const char * const m8_common_board_compat[] = {
> > +       "amlogic,meson8",
> > +       NULL,
> > +};
> > +
> >  DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
> >         .dt_compat      = m6_common_board_compat,
> >  MACHINE_END
> >  
> > +DT_MACHINE_START(MESON8, "Amlogic Meson8 platform")
> > +       .dt_compat      = m8_common_board_compat,
> > +MACHINE_END
> > 
> 
> I'd just add the meson8 string to the m6_common_board_compat list and
> rename it.

>From what I've seen so far the two families are very similar and share
most of the IP cores, so a unique DT machine is a good idea.

Does the MACH_MESON8 Kconfig symbol still make sense or can I drop it
and rename MACH_MESON6 to MACH_MESON?

Beniamino
