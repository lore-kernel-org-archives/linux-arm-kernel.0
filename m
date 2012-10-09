From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Oct 2012 17:06:47 +0100
Subject: [PATCH 4/9] ARM: export default read_current_timer
In-Reply-To: <50744586.6010806@arm.com>
References: <1349796183-30648-1-git-send-email-arnd@arndb.de>
 <1349796183-30648-5-git-send-email-arnd@arndb.de> <50744586.6010806@arm.com>
Message-ID: <20121009160647.GG4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 04:40:54PM +0100, Jonathan Austin wrote:
> Hi Arnd,
> 
> On 09/10/12 16:22, Arnd Bergmann wrote:
> > diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
> > index 9d0a300..0dc5385 100644
> > --- a/arch/arm/lib/delay.c
> > +++ b/arch/arm/lib/delay.c
> > @@ -45,6 +45,7 @@ int read_current_timer(unsigned long *timer_val)
> >  	*timer_val = delay_timer->read_current_timer();
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(read_current_timer);
> 
> 
> Perhaps this fits better in armksyms.c? That way it lives with
> arm_delay_ops and friends.

It's always much better to put things next to where they're defined
rather than spreading them around.

armksyms.c is a reminant of the 1.x days of doing things... but still
remains to allow what are mostly assembly symbols to be exported.
