From: x0148406@ti.com (Afzal Mohammed)
Date: Tue, 9 Oct 2012 18:29:44 +0530
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <20121009030126.GB12552@atomide.com>
References: <cover.1349450723.git.afzal@ti.com>
 <20121009030126.GB12552@atomide.com>
Message-ID: <50741FC0.4010502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tuesday 09 October 2012 08:31 AM, Tony Lindgren wrote:
> * Afzal Mohammed<afzal@ti.com>  [121005 09:02]:

>> Proposed generic routine has been tested on OneNAND (async) on
>> OMAP3EVM rev C (as mainline does not have the OneNAND support for this,
>> local patch were used to test). For other cases of custom timing
>> calculation (tusb6010, smc91x non-muxed, OneNAND sync), generic timing
>> calculation routine was verified by simulating on OMAP3EVM.
> Have you tested to make sure this works if you change the
> L3 frequency?

With changed L3 frequency it was not tested.

I do not have a single board that is supported in mainline that
calculates on the run gpmc timing from device timing. What has
been tested here is OneNAND working in asynchronous mode
on omap3evm, but it's support is not available in mainline, so
private patch had to be used to test it. All other peripherals
were tested by simulation, i.e. by comparing output from existing
custom timing routine & generic routine for particular frequencies.

> That should probably be tested as a sanity check. Maybe you
> can force the L3 for some test boots for this, I don't think
> we scale it by default.

On omap3evm, don't know whether L3 frequency can be
changed & still have a working Kernel. I am not sure whether
it is worth attempting as OneNAND on omap3evm is not
supported in mainline.

Regards
Afzal
