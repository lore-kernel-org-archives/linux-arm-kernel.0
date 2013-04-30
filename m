From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 30 Apr 2013 12:58:40 +0100
Subject: linux-next build error (at91) - use of bool in mach/arch.h
In-Reply-To: <CAMuHMdXYaDHYq7CG8ftP+yyF18pMx8qZrvM3AUTAXk+tUruNcA@mail.gmail.com>
References: <517F8FF4.3050901@atmel.com>
 <CAMuHMdXYaDHYq7CG8ftP+yyF18pMx8qZrvM3AUTAXk+tUruNcA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1304301257200.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Apr 2013, Geert Uytterhoeven wrote:
> On Tue, Apr 30, 2013 at 11:33 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > So, I am wondering if the best correction is to add the types.h header file
> > in the asm/mach/arch.h file, like this:
> >
> > --- a/arch/arm/include/asm/mach/arch.h
> > +++ b/arch/arm/include/asm/mach/arch.h
> > @@ -8,6 +8,8 @@
> >   * published by the Free Software Foundation.
> >   */
> >
> > +#include <linux/types.h>
> > +
> >  #ifndef __ASSEMBLY__
> >
> >  struct tag;
> >
> > or if a better option would be to re-arrange the include directives in
> > various at91xxx_devices.c files?
> 
> Include files should be self-contained, so asm/mach/arch.h is the right place.

Nicolas,
are you happy to come up with a proper patch to fix the issue?
