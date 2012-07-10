From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 10 Jul 2012 16:10:31 +0200 (CEST)
Subject: Move designware timer OF glue into drivers/clocksource
In-Reply-To: <20120710111324.GA8701@elf.ucw.cz>
References: <20120710094249.GF10225@elf.ucw.cz>
 <alpine.LFD.2.02.1207101304160.32033@ionos>
 <20120710111324.GA8701@elf.ucw.cz>
Message-ID: <alpine.LFD.2.02.1207101609270.32033@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jul 2012, Pavel Machek wrote:

> Hi!
> 
> On Tue 2012-07-10 13:07:36, Thomas Gleixner wrote:
> > On Tue, 10 Jul 2012, Pavel Machek wrote:
> > >  		timer0: timer at ffc08000 {
> > > -				compatible = "socfpga,sp-timer";
> > > +				compatible = "snps,dw-apb-timer-sp";
> > 
> > apb timer. That rings a bell. Does that have anything to do with
> > 
> > arch/x86/kernel/apb_timer.c ? That's from one of the intel mobile
> > chips and might be the very same IP block.
> 
> As far as I can tell, drivers/clocksource/dw_apb_timer.c is already
> used on Intel MID platform... What I'm moving is device tree glue,
> that is unsuitable for x86 plaforms with classical BIOS. (And AFAICT,
> intel MID also uses something different).

Ah, ok. Did not look at the details. Just the "abp" popped up in my
mind :)
 
> > > -obj-y					:= common.o time.o
> > > +obj-y					:= common.o ../../../drivers/clocksource/dw_apb_timer_of.o
> > 
> > Urgh! Why can't we just compile it from drivers/clocksource/Makefile
> > ?
> 
> It will cost me a new config option, but I can do that, yes.

Please.

Thanks,

	tglx
