From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 22 Jun 2013 01:13:46 +0200 (CEST)
Subject: [PATCHv3/RESEND 4/4] clocksource: arch_timer: Add support for
 memory mapped timers
In-Reply-To: <51C4DB44.7030909@codeaurora.org>
References: <1371836361-20574-1-git-send-email-sboyd@codeaurora.org>
 <1371836361-20574-5-git-send-email-sboyd@codeaurora.org>
 <alpine.DEB.2.02.1306212304480.4013@ionos.tec.linutronix.de>
 <51C4DB44.7030909@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1306220110110.4013@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jun 2013, Stephen Boyd wrote:
> On 06/21/13 14:18, Thomas Gleixner wrote:
> > Something in my little brain yells: function pointer
> >
> > You can't be serious about hacking nested if/else/switch constructs
> > into a hot path.
> >
> > Why not making your cpu data:
> >
> > struct arch_timer {
> >        struct clock_event_device evt;
> >        ....
> >        void (*write_ctrl)(val, timer);
> >        void (*write_tval)(val, timer);
> >        ....
> > }
> >
> > and get rid of all that conditionals?
> 
> It sounds like that's undesirable according to the comment above
> arch_timer_reg_write(). It seems that all this code was written under
> the assumption that the compiler is good enough to optimize all the code
> paths and only generate the code that is necessary. So far this seems to
> be working and the hotpath is optimized for each type of access.

That might be true for kernels which are optimized for a specific
target, but this will fall flat for any multi-platform kernel.

Thanks,
	
	tglx
