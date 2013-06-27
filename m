From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Jun 2013 21:16:47 +0200
Subject: [PATCH 2/8] clocksource: sun4i: Add clocksource and sched clock
 drivers
In-Reply-To: <20130627173643.GQ4824@tarshish>
References: <1372281421-2099-1-git-send-email-maxime.ripard@free-electrons.com>
 <1372281421-2099-3-git-send-email-maxime.ripard@free-electrons.com>
 <20130627060234.GD4824@tarshish> <20130627093558.GB8437@lukather>
 <20130627094649.GM4824@tarshish> <20130627172144.GD4319@lukather>
 <20130627173643.GQ4824@tarshish>
Message-ID: <20130627191647.GE4319@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 08:36:43PM +0300, Baruch Siach wrote:
> Hi Maxime,
> 
> On Thu, Jun 27, 2013 at 07:21:44PM +0200, Maxime Ripard wrote:
> > On Thu, Jun 27, 2013 at 12:46:49PM +0300, Baruch Siach wrote:
> > > On Thu, Jun 27, 2013 at 11:35:58AM +0200, Maxime Ripard wrote:
> > > > On Thu, Jun 27, 2013 at 09:02:34AM +0300, Baruch Siach wrote:
> > > > > On Wed, Jun 26, 2013 at 11:16:55PM +0200, Maxime Ripard wrote:
> > > > > > +static u32 sun4i_timer_sched_read(void)
> > > > > 
> > > > > You commit message mentions "64 bits free running counter", but this one only 
> > > > > returns 32 bit.
> > > > 
> > > > Yeah, the callback setup by setup_sched_clock is supposed to be
> > > > returning a u32, and clocksource_mmio_init only accepts up to 32 bits as
> > > > well, so I'm only using the lower 32bits of this 64 bits counter.
> > > > 
> > > > I'll amend the commit log to state this.
> > > 
> > > But using 64 bit counter for sched_clock is much easier that using 32 bit one. 
> > 
> > Easier in what aspect? Both API looks similar.
> 
> You can just implement your own simple sched_clock() that just returns the 
> current value of this 64 bit counter, and do away with all the tricky code in 
> kernel/time/sched_clock.c (in tip.git) that is needed to make the 32 -> 64 
> extension safe. This is not compatible with multi-platform kernel, though.

Which is a deal-breaker for us.

I'll use the setup_sched_clock_64 introduced by Stephen then :)

Thanks for the time you took to review these patches!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/4b45de4e/attachment.sig>
