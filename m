From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Jul 2012 17:47:30 +0100
Subject: [Xen-devel] [PATCH 06/24] xen: missing includes
In-Reply-To: <501257F30200007800090D9E@nat28.tlf.novell.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-6-git-send-email-stefano.stabellini@eu.citrix.com>
 <501257F30200007800090D9E@nat28.tlf.novell.com>
Message-ID: <alpine.DEB.2.02.1207271739550.26163@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jul 2012, Jan Beulich wrote:
> >>> On 26.07.12 at 17:33, Stefano Stabellini <stefano.stabellini@eu.citrix.com> wrote:
> > --- a/include/xen/interface/xen.h
> > +++ b/include/xen/interface/xen.h
> > @@ -10,7 +10,10 @@
> >  #define __XEN_PUBLIC_XEN_H__
> >  
> >  #include <asm/xen/interface.h>
> > +#include <linux/types.h>
> > +#ifdef CONFIG_X86
> >  #include <asm/pvclock-abi.h>
> > +#endif
> 
> Rather than hacking around this, why not clean it up:
> asm/pvclock-abi.h clearly isn't intended to be included here
> (from the perspective of the origin of xen/interface/xen.h, at
> least), nor is linux/types.h.
> 
> Or if it is really needed to deviate from the original header in
> this respect, then clearly the inclusion ought to not be arch
> specific or be moved to an arch specific header.

I think you are right: linux/types.h is not actually needed and
pvclock-abi.h should probably be included by asm/xen/interface.h.
