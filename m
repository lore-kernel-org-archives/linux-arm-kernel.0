From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Jul 2012 13:59:29 +0100
Subject: [PATCH v2 1/2] ARM: arch timer: implement read_current_timer and
 get_cycles
In-Reply-To: <4FF58A27.7030309@renesas.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-2-git-send-email-will.deacon@arm.com>
 <4FF58A27.7030309@renesas.com>
Message-ID: <20120705125929.GG3399@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 01:35:51PM +0100, Shinya Kuribayashi wrote:
> On 6/30/2012 2:33 AM, Will Deacon wrote:
> > +#ifdef ARCH_HAS_READ_CURRENT_TIMER
> > +#define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
> > +#else
> > +#define get_cycles()	(0)
> > +#endif
> >  
> >  #endif
> 
> Except <asm/arch_timer.h> inclusion, this change is not arch_timer-
> dependent, but general parts for ARM, connecting read_current_timer()
> and get_cycles().  Should be folded into patch 2/2.

I'm not so sure. Before this patch, nobody implements read_current_timer for
ARM as far as I can tell, so with the first user it makes sense to add this
definition. It's also used on its own outside of the new delay implementation
as an entropy source.

Will
