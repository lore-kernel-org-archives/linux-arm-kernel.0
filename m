From: mingo@elte.hu (Ingo Molnar)
Date: Thu, 19 May 2011 11:37:06 +0200
Subject: [patch 5/7] clockevents: Provide interface to reconfigure an
	active clock event device
In-Reply-To: <alpine.LFD.2.02.1105191132260.3078@ionos>
References: <20110518205713.947614271@linutronix.de>
	<20110518210136.437459958@linutronix.de>
	<20110519091024.GB6251@elte.hu>
	<alpine.LFD.2.02.1105191132260.3078@ionos>
Message-ID: <20110519093706.GE6251@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 19 May 2011, Ingo Molnar wrote:
> > * Thomas Gleixner <tglx@linutronix.de> wrote:
> > > + */
> > > +int clockevents_reconfigure(struct clock_event_device *dev, u32 freq)
> > 
> > This too could use a struct clockevents_params perhaps - and would only use 
> > params.freq for now but might be extended in the future.
> > 
> > But i'm fine with this API as well:
> 
> I agree for the config_register interface, but here we really just
> want to update the frequency and not change any other parameter.

ok, fair enough - in that case i'd suggest making that property explicitly 
visible in the API name, via something like:

	int clockevents_set_freq(struct clock_event_device *dev, u32 freq)

That way it's obvious at first sight what this does:

	clockevents_set_freq(dev, 1000000);

Versus:

	clockevents_reconfigure(dev, 1000000);

Thanks,

	Ingo
