From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 19 May 2011 11:33:25 +0200 (CEST)
Subject: [patch 5/7] clockevents: Provide interface to reconfigure an
	active clock event device
In-Reply-To: <20110519091024.GB6251@elte.hu>
References: <20110518205713.947614271@linutronix.de>
	<20110518210136.437459958@linutronix.de>
	<20110519091024.GB6251@elte.hu>
Message-ID: <alpine.LFD.2.02.1105191132260.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 May 2011, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> > + */
> > +int clockevents_reconfigure(struct clock_event_device *dev, u32 freq)
> 
> This too could use a struct clockevents_params perhaps - and would only use 
> params.freq for now but might be extended in the future.
> 
> But i'm fine with this API as well:

I agree for the config_register interface, but here we really just
want to update the frequency and not change any other parameter.
 
Thanks,

	tglx
