From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 09:57:44 -0600
Subject: [RFC, PATCH] clocksource: provide timekeeping for efm32 SoCs
In-Reply-To: <20131001080829.GJ2548@pengutronix.de>
References: <1379324644-20934-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5242F434.7060702@linaro.org> <20131001080829.GJ2548@pengutronix.de>
Message-ID: <524AF0F8.3050008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 02:08 AM, Uwe Kleine-K?nig wrote:
> On Wed, Sep 25, 2013 at 04:33:24PM +0200, Daniel Lezcano wrote:
>> On 09/16/2013 11:44 AM, Uwe Kleine-K?nig wrote:
>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>> ---
>>> Hello,
>>>
>>> I'm not sure that the way I implemented if a given timer is used as
>>> clock_source or clock_event_device is robust. Does it need locking?
>>> The reason to create a timer device for each timer instead of a single
>>> device of all of them is that it makes it cleaner to specify irqs and
>>> clks which each timer has one of each respectively. I didn't find an
>>> example, but while looking I wondered if in zevio-timer.c a single timer
>>> can really support both clock_event and clocksource.
>>>
>>> I guess for inclusion I need to write a document describing the
>>> of-binding. I will include that in the next iteration.
>>
>> Right and a nice description of the timer would be valuable.
> Where is the location to put a device tree binding document for a
> clocksource/clock event device? I found
> 
> 	arm,armv7-timer-mem	| arm/arch_timer.txt
> 	fsl,timrot		| N/A
> 	nvidia,tegra20-rtc	| rtc/nvidia,tegra20-rtc.txt

The Tegra example isn't a good one here, since the Tegra HW block is
primarily an RTC (hence the location of the binding file), which also
happens to be able to act as the clocksource.

> Should I introduce a "clocksource" directory below
> Documentation/devicetree/bindings?

That seems reasonable for any HW block that is truly purely a
clocksource. However, you'd want to also check with all the other DT
bindings maintainers.
