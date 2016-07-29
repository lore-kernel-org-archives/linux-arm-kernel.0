From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 29 Jul 2016 11:31:44 +0100
Subject: [PATCH] clocksource: arm_arch_timer: Support reading clock rate
 from a driver
In-Reply-To: <20160729101811.GB21580@leverpostej>
References: <1469784191-3998-1-git-send-email-zajec5@gmail.com>
 <20160729101811.GB21580@leverpostej>
Message-ID: <579B3090.1070709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/16 11:18, Mark Rutland wrote:
> [adding Marc to Cc]
> 
> On Fri, Jul 29, 2016 at 11:23:11AM +0200, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> On some devices using arch code for reading clock rate doesn't work. So
>> far the only option was to specify clock-frequency in a DT. This works
>> only if a clock frequency doesn't have to be calculated on runtime.
>>
>> On BCM53573 SoC (with Cortex-A7) there is ILP clock that needs its own
>> driver. With this change we can query such clocks by using a standard:
>> clocks = <&foo>;
> 
> The clock for the architected timer(s) are supposed to be configured
> before entering Linux. The clock-frequency property is at best a dodgy
> workaround, and this is even worse.
> 
> Please fix your firmware to configure and enabled this clock before
> entering Linux, and to program CNTFRQ appropriately.

I'll add that failure to do so breaks other subsystems which do rely on
CNTFRQ to be correctly programmed *on each CPU* (like KVM and Xen).

Please follow the requirements of the architecture and don't just paper
over such a bug.

> As this path stands, NAK.

Seconded.

	M.
-- 
Jazz is not dead. It just smells funny...
