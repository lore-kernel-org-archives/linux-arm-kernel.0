From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 May 2012 10:37:50 -0700
Subject: [PATCH 12/13] ARM: OMAP5: Add the build support
In-Reply-To: <CAJ7qFSeJc+F5xnW+P5r89yZEZXi8k-LqqnD8R1KEUONqravNBw@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-13-git-send-email-r.sricharan@ti.com>
 <20120504225857.GB5613@atomide.com>
 <CAJ7qFSeJc+F5xnW+P5r89yZEZXi8k-LqqnD8R1KEUONqravNBw@mail.gmail.com>
Message-ID: <20120507173749.GE5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* R, Sricharan <r.sricharan@ti.com> [120506 20:39]:
> >> +config MACH_OMAP5_SEVM
> >> + ? ? bool "OMAP5 sevm Board"
> >> + ? ? depends on ARCH_OMAP5
> >> +
> >> ?config OMAP3_EMU
> >> ? ? ? bool "OMAP3 debugging peripherals"
> >> ? ? ? depends on ARCH_OMAP3
> >
> > No need for it here either. Actually, I think this whole chunk
> > can be now left out since it's DT based?
> >he
>  ok, but the concern here was that without this macro
>  the print from compress and subsequently early
> prints appear broken.
> 
> machine_is_omap5_sevm becomes zero without this config and
> machine_is_xxxx is used by the macro _DEBUG_LL_ENTRY
> uncompress.h.

Ah I see.

Tony
