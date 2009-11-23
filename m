From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 20:39:31 +0000
Subject: [PATCH 00/20] iPAQ h3100/h3600 work for 2.6.33
In-Reply-To: <20091115173048.GA19609@rainbow>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<20091024211026.GE16451@n2100.arm.linux.org.uk>
	<20091025153603.GA24490@rainbow> <20091115173048.GA19609@rainbow>
Message-ID: <20091123203931.GI18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 15, 2009 at 08:30:48PM +0300, Dmitry Artamonow wrote:
> On 18:36 Sun 25 Oct     , Dmitry Artamonow wrote:
> > On 22:10 Sat 24 Oct     , Russell King - ARM Linux wrote:
> > > 
> > > That's fine, and the patches to me at least look fine as well.  The only
> > > thing which gives me slight concern is the:
> > > 
> > > 	if (!gpio_request()) {
> > > 		gpio_direction_output();
> > > 		gpio_free();
> > > 	}
> > > 
> > > stuff, but I guess you can't get around that easily, especially if those
> > > GPIOs only become available at some time later.  It is something that
> > > eventually needs to be addressed though - consider that this can lead
> > > to unexpected (and silent) failures if the GPIOs aren't available when
> > > another driver initializes, and can't (eg) turn on the IrDA tranceiver.
> > 
> > Yes, you right here about silent failures. I think they could be made less
> > silent by inserting some pr_err()-s , though it would bloat code a
> > bit (I'd like to see request_gpio() itself emitting error message,
> > but currectly it does that only when CONFIG_DEBUG_GPIO is set).
> > Ok, here's incremental patch adding pr_err-s in attachment - if you're
> > OK with it I will roll it into [09/20] and rebase all following patches.
> > 
> > Also perhaps it's a good idea to always built-in htc-egpio driver
> > (by adding "select HTC_EGPIO" to h3100/h3600 Kconfig options) - that should
> > decrease probability of gpio_request failures a lot. Patch also
> > attached.
> 
> So, Russell, what's your opinion on these proposed additional changes?
> (btw, I found some minor flaws in "emit messages on failed gpio_request"
> patch, new version attached here).
> 
> I'm thinking about submitting full patchset into you patchsystem soon,
> but I'd like to know that everything is ok before doing that.

Well, I'm not sure what Thomas Kunze is doing, I've not heard from him in
a while.

How do your patches affect his?  Are your patches a superset of Thomas's
patches?  If not, should Thomas's be merged first?
