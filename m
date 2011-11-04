From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Nov 2011 08:13:23 +0000
Subject: [PATCH] GPIO: spear: remove empty plat/gpio.h
In-Reply-To: <4EB35EE6.2050500@st.com>
References: <20111103233925.GV12913@n2100.arm.linux.org.uk>
	<4EB35EE6.2050500@st.com>
Message-ID: <20111104081323.GW12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 09:11:26AM +0530, Viresh Kumar wrote:
> On 11/4/2011 5:09 AM, Russell King - ARM Linux wrote:
> > Viresh - can you test and provide a tested-by for this please?
> > 
> > Grant,
> > 
> > You may wish to (eventually) take this through your gpio tree.
> > 
> > It's not something I've build-tested, but afaics nothing refers to
> > plat/gpio.h outside of arch/arm - and nothing spear-wise refers to
> > that include after this commit so it should be entirely safe.
> > Nevertheless, waiting for Viresh to confirm...
> > 
> > 8<---
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > GPIO: spear: remove empty plat/gpio.h
> > 
> > Spear now has an empty plat/gpio.h, and two mach/gpio.h which include
> > this file.  Simply this by emptying the mach/gpio.h headers, and
> > getting rid of plat/gpio.h entirely.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-spear3xx/include/mach/gpio.h |   20 +-------------------
> >  arch/arm/mach-spear6xx/include/mach/gpio.h |   20 +-------------------
> >  arch/arm/plat-spear/include/plat/gpio.h    |    1 -
> >  3 files changed, 2 insertions(+), 39 deletions(-)
> >  delete mode 100644 arch/arm/plat-spear/include/plat/gpio.h
> > 
> > diff --git a/arch/arm/mach-spear3xx/include/mach/gpio.h b/arch/arm/mach-spear3xx/include/mach/gpio.h
> > index 451b208..40a8c17 100644
> > --- a/arch/arm/mach-spear3xx/include/mach/gpio.h
> > +++ b/arch/arm/mach-spear3xx/include/mach/gpio.h
> > @@ -1,19 +1 @@
> > -/*
> > - * arch/arm/mach-spear3xx/include/mach/gpio.h
> > - *
> > - * GPIO macros for SPEAr3xx machine family
> > - *
> > - * Copyright (C) 2009 ST Microelectronics
> > - * Viresh Kumar<viresh.kumar@st.com>
> > - *
> > - * This file is licensed under the terms of the GNU General Public
> > - * License version 2. This program is licensed "as is" without any
> > - * warranty of any kind, whether express or implied.
> > - */
> > -
> > -#ifndef __MACH_GPIO_H
> > -#define __MACH_GPIO_H
> > -
> > -#include <plat/gpio.h>
> > -
> > -#endif /* __MACH_GPIO_H */
> > +/* empty */
> > diff --git a/arch/arm/mach-spear6xx/include/mach/gpio.h b/arch/arm/mach-spear6xx/include/mach/gpio.h
> > index 3a789db..40a8c17 100644
> > --- a/arch/arm/mach-spear6xx/include/mach/gpio.h
> > +++ b/arch/arm/mach-spear6xx/include/mach/gpio.h
> > @@ -1,19 +1 @@
> > -/*
> > - * arch/arm/mach-spear6xx/include/mach/gpio.h
> > - *
> > - * GPIO macros for SPEAr6xx machine family
> > - *
> > - * Copyright (C) 2009 ST Microelectronics
> > - * Viresh Kumar<viresh.kumar@st.com>
> > - *
> > - * This file is licensed under the terms of the GNU General Public
> > - * License version 2. This program is licensed "as is" without any
> > - * warranty of any kind, whether express or implied.
> > - */
> > -
> > -#ifndef __MACH_GPIO_H
> > -#define __MACH_GPIO_H
> > -
> > -#include <plat/gpio.h>
> > -
> > -#endif /* __MACH_GPIO_H */
> > +/* empty */
> > diff --git a/arch/arm/plat-spear/include/plat/gpio.h b/arch/arm/plat-spear/include/plat/gpio.h
> > deleted file mode 100644
> > index 40a8c17..0000000
> > --- a/arch/arm/plat-spear/include/plat/gpio.h
> > +++ /dev/null
> > @@ -1 +0,0 @@
> > -/* empty */
> > .
> > 
> 
> Hi Russell,
> 
> Due to some other priorities in ST we were not able to update our code
> to Mainline since sometime. We have now reserved time for doing Mainline activities.
> 
> We would be required to add this file again once we start pushing our code
> to mainline.
> 
> So i would request to keep this patch on hold till the time we present our
> patches once again.

With the move to gpiolib, and the cleanups which are happening - specifically
that the simple gpiolib implementation is now contained within asm/gpio.h,
and we're moving towards having ARCH_NR_GPIO defined outside of mach/gpio.h,
you should not require any plat/gpio.h.

Platform specific gpio definitions unrelated to gpiolib should be placed
into a separate header file.
