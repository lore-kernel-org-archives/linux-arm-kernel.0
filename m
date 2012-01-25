From: khilman@ti.com (Kevin Hilman)
Date: Tue, 24 Jan 2012 16:41:11 -0800
Subject: [PATCH v3 0/7] Add common cpuidle code for consolidation.
In-Reply-To: <20120124201749.GC1135@opensource.wolfsonmicro.com> (Mark Brown's
 message of "Tue, 24 Jan 2012 20:17:49 +0000")
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <871uqoj23b.fsf@ti.com>
 <20120124201749.GC1135@opensource.wolfsonmicro.com>
Message-ID: <87ehuohavs.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Tue, Jan 24, 2012 at 12:08:08PM -0800, Kevin Hilman wrote:
>> Robert Lee <rob.lee@linaro.org> writes:
>
>> > Besides just code consolidation, a
>> > default "WFI" state is now used with default parameters that different from your
>> > original paramenters. The assumption is that if you have a WFI only idle state,
>> > the parameters in the new default WFI are more realistic as a true WFI only
>> > hardware state incurs minimal latency(<1us) or power penalty to enter and exit.
>
>> > If your platform actually performs other platform specific functionality upon
>> > entering WFI and the default parameters do not accurately reflect the 
>> > exit_latency and target_residency given in the common default state, please
>> > say so.  
>
>> I'm not sure what you mean by "WFI only".  On OMAP, WFI is the entry
>> point for all the idle states, with varying latencies.  The latencies
>> are then dependent on how the states are programmed for the various
>> power domains.  Upon WFI, the hardware then takes over puts the
>> powerdomains to their programmed states.   
>
> The default state in the patches is set up with parameters for a state
> that literally only does the WFI and has no other hardware actions taken
> adding latencies.  I asked for this because the existing drivers for
> most of the SoCs out there currently only support that basic idle state
> and when doing something more complex (which most of the SoCs actually
> can do in hardware) it's still likely to get used during bringup of the
> feature.
>
> If there's varying levels of idle state then the SoC specific code would
> need to enumerate them and their varying latencies so that the core can
> figure out which one to enter.  This isn't a problem, it's a good thing,
> but most SoCs haven't got so far as to need it yet.

OK, makes sense now.

I see now that that default is easily overridden by platform-specific
drivers, so I don't have any problem with it.

Kevin
