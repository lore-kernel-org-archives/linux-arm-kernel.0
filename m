From: mikko.rapeli@iki.fi (Mikko Rapeli)
Date: Wed, 16 Nov 2016 16:11:59 +0200
Subject: [PATCH v05 60/72] arch/arm/include/uapi/asm/signal.h: use
 __kernel_size_t instead of size_t
In-Reply-To: <1898059.B1P75dnZ5Q@wuerfel>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
 <1471890809-4383-61-git-send-email-mikko.rapeli@iki.fi>
 <1898059.B1P75dnZ5Q@wuerfel>
Message-ID: <20161116141159.GK8342@lakka.kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 05:02:56PM +0200, Arnd Bergmann wrote:
> On Monday, August 22, 2016 8:33:17 PM CEST Mikko Rapeli wrote:
> > diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
> > index 33073bd..859f2de 100644
> > --- a/arch/arm/include/uapi/asm/signal.h
> > +++ b/arch/arm/include/uapi/asm/signal.h
> > @@ -113,7 +113,7 @@ struct sigaction {
> >  typedef struct sigaltstack {
> >         void __user *ss_sp;
> >         int ss_flags;
> > -       size_t ss_size;
> > +       __kernel_size_t ss_size;
> >  } stack_t;
> 
> I was going to reply with an Ack, but on further consideration,
> I'm not sure if we can't do this in general: size_t may be either
> 'unsigned int' or 'unsigned long' (depending on the architecture
> and toolchain), and if kernel and glibc disagree on this, we
> have a problem with any user space code that expects sigaltstack->ss_size
> to be the same type as size_t (as mandated by the man page).
> 
> I wonder if there is another way to address this.

I presume that kernel headers need to follow libc in this case and include
<stddef.h>?

-Mikko
