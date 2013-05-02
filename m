From: holt@sgi.com (Robin Holt)
Date: Thu, 2 May 2013 07:49:06 -0500
Subject: [PATCH -v7 10/11] arm, change reboot_mode to use enum reboot_mode
In-Reply-To: <20130502073020.GC26361@gmail.com>
References: <1367428011-17123-1-git-send-email-holt@sgi.com>
 <1367428011-17123-11-git-send-email-holt@sgi.com>
 <20130502073020.GC26361@gmail.com>
Message-ID: <20130502124906.GW3658@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 09:30:20AM +0200, Ingo Molnar wrote:
> 
> * Robin Holt <holt@sgi.com> wrote:
> 
> >  #ifndef __ASSEMBLY__
> >  
> >  #include <linux/types.h>
> > +#include <linux/reboot.h>
> >  
> >  void iop3xx_map_io(void);
> >  void iop_init_cp6_handler(void);
> >  void iop_init_time(unsigned long tickrate);
> > -void iop3xx_restart(char, const char *);
> > +void iop3xx_restart(enum reboot_mode, const char *);
> 
> IMO the introduction of the enum is making things cleaner here all around.
> 
> As long as it's an equivalent transformation for ARM with no reduction in 
> functionality (i.e. please fix any bugs Russell found), this all looks 
> like a nice series.
> 
> Is there no parameter namespace clash between reboot modifier strings on 
> various architectures? I.e. 's' meaning something on x86 and meaning a 
> different thing on ARM or some other architecture.

There is.  I used an #ifdef in kernel/reboot.c.  Also w[arm] | c[old]
on x86 becomes s[oft] | h[ard] | g[pio] on arm/unicore32. (Well, I just
added gpio that to the patch set after noticing I missed it earlier).

Robin
