From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 25 Jun 2013 13:19:54 +0200
Subject: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
In-Reply-To: <20130625102646.GC21137@manwe>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <1405696.in3RSSDWnX@flatron> <20130625102646.GC21137@manwe>
Message-ID: <1688471.WOi6pAAcEq@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 of June 2013 12:26:47 Thierry Reding wrote:
> On Mon, Jun 24, 2013 at 11:17:03PM +0200, Tomasz Figa wrote:
> > On Monday 24 of June 2013 22:53:42 Thierry Reding wrote:
> > > On Mon, Jun 24, 2013 at 10:32:55PM +0200, Tomasz Figa wrote:
> [...]
> 
> > > > What about:
> > > > 
> > > > /*
> > > > 
> > > >  * PWM block is shared between pwm-samsung and samsung_pwm_timer
> > > >  drivers
> > > >  * and some registers need access synchronization. If both drivers
> > > >  are
> > > >  * compiled in, the spinlock is defined in the clocksource driver,
> > > >  * otherwise following definition is used.
> > > >  *
> > > >  * Currently we do not need any more complex synchronization method
> > > >  * because all the supported SoCs contain only one instance of the
> > > >  PWM
> > > >  * IP. Should this change, both drivers will need to be modified to
> > > >  * properly synchronize accesses to particular instances.
> > > >  */
> > > 
> > > I see that you can't be persuaded. And everybody else seems to be
> > > okay
> > > with it so... have it your way. I'm probably going to regret this.
> > 
> > This was just a proposal. Do you want anything else to be added to the
> > comment or anything to be changed?
> 
> For reference, I still don't like this but since I'm the only one
> complaining, go ahead. With that comment added to the driver:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

OK. Thank you.

Kukjin, can you amend the comment I mentioned to this patch above the line 
with DEFINE_SPINLOCK or I should send fixed version?

Best regards,
Tomasz
