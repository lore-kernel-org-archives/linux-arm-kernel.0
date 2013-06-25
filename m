From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 25 Jun 2013 12:26:47 +0200
Subject: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
In-Reply-To: <1405696.in3RSSDWnX@flatron>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <3059286.XLVAQe4lge@flatron> <20130624205342.GE7163@mithrandir>
 <1405696.in3RSSDWnX@flatron>
Message-ID: <20130625102646.GC21137@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 11:17:03PM +0200, Tomasz Figa wrote:
> On Monday 24 of June 2013 22:53:42 Thierry Reding wrote:
> > On Mon, Jun 24, 2013 at 10:32:55PM +0200, Tomasz Figa wrote:
[...]
> > > What about:
> > > 
> > > /*
> > > 
> > >  * PWM block is shared between pwm-samsung and samsung_pwm_timer
> > >  drivers
> > >  * and some registers need access synchronization. If both drivers are
> > >  * compiled in, the spinlock is defined in the clocksource driver,
> > >  * otherwise following definition is used.
> > >  *
> > >  * Currently we do not need any more complex synchronization method
> > >  * because all the supported SoCs contain only one instance of the PWM
> > >  * IP. Should this change, both drivers will need to be modified to
> > >  * properly synchronize accesses to particular instances.
> > >  */
> > 
> > I see that you can't be persuaded. And everybody else seems to be okay
> > with it so... have it your way. I'm probably going to regret this.
> 
> This was just a proposal. Do you want anything else to be added to the 
> comment or anything to be changed?

For reference, I still don't like this but since I'm the only one
complaining, go ahead. With that comment added to the driver:

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/f20e3970/attachment.sig>
