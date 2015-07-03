From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 3 Jul 2015 14:27:49 +0530
Subject: [PATCH 39/41] clocksource: vf_pit: Migrate to new 'set-state'
 interface
In-Reply-To: <19859bd18fb69fa1f10c07de01b2259d@agner.ch>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <c9f030f57a10c1be00f8732ae2190fcc55248db5.1434622147.git.viresh.kumar@linaro.org>
 <19859bd18fb69fa1f10c07de01b2259d@agner.ch>
Message-ID: <20150703085749.GE23297@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-07-15, 10:10, Stefan Agner wrote:
> >  	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> > -	.set_mode	= pit_set_mode,
> > +	.set_state_shutdown = pit_shutdown,
> > +	.set_state_periodic = pit_set_periodic,
> 
> I'm not really familiar with the interface, but given that we announce
> the feature CLOCK_EVT_FEAT_ONESHOT shouldn't we add a set_state_oneshot
> callback here?

We weren't doing anything in pit_set_mode(ONESHOT) and so that
callback is not implemented. In case you need to do something in
set_state_oneshot(), we can add it back.

-- 
viresh
