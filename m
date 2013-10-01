From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Oct 2013 10:08:29 +0200
Subject: [RFC, PATCH] clocksource: provide timekeeping for efm32 SoCs
In-Reply-To: <5242F434.7060702@linaro.org>
References: <1379324644-20934-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5242F434.7060702@linaro.org>
Message-ID: <20131001080829.GJ2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 04:33:24PM +0200, Daniel Lezcano wrote:
> On 09/16/2013 11:44 AM, Uwe Kleine-K?nig wrote:
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > I'm not sure that the way I implemented if a given timer is used as
> > clock_source or clock_event_device is robust. Does it need locking?
> > The reason to create a timer device for each timer instead of a single
> > device of all of them is that it makes it cleaner to specify irqs and
> > clks which each timer has one of each respectively. I didn't find an
> > example, but while looking I wondered if in zevio-timer.c a single timer
> > can really support both clock_event and clocksource.
> > 
> > I guess for inclusion I need to write a document describing the
> > of-binding. I will include that in the next iteration.
> 
> Right and a nice description of the timer would be valuable.
Where is the location to put a device tree binding document for a
clocksource/clock event device? I found

	arm,armv7-timer-mem	| arm/arch_timer.txt
	fsl,timrot		| N/A
	nvidia,tegra20-rtc	| rtc/nvidia,tegra20-rtc.txt

Should I introduce a "clocksource" directory below
Documentation/devicetree/bindings?

Other than that if there are no further comments I'll sent a v2 soon.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
