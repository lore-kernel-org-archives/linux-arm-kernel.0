From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 24 Sep 2014 16:55:32 +0100
Subject: [PATCH v2] clocksource: arm_arch_timer: discard unavailable timers
 correctly
In-Reply-To: <20140924154802.GK5729@leverpostej>
References: <1410911445-19067-1-git-send-email-sudeep.holla@arm.com>
 <1410982774-4724-1-git-send-email-sudeep.holla@arm.com>
 <5422E05F.4070405@arm.com> <20140924154802.GK5729@leverpostej>
Message-ID: <5422E974.3090506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/09/14 16:48, Mark Rutland wrote:
> On Wed, Sep 24, 2014 at 04:16:47PM +0100, Sudeep Holla wrote:
>> Hi Mark,
>>
>> On 17/09/14 20:39, Sudeep Holla wrote:
>>> Currently we wait until both cp15 and mem timers are probed if we
>>> have both timer device nodes present in the device tree without
>>> checking if the device is actually available. If one of the timer
>>> device node present is disabled, the system locks up on the boot
>>> as no timer gets registered.
>>>
>>> This patch adds the check for the availablity of the timer device
>>> so that we unavailable timers are discarded correctly. It also adds
>>> the missing of_node_put.
>>>
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>
>> If your are fine with this, can I ask Daniel you pick this up ?
>
> While I'd prefer to see the cp15 and mmio timer driver pulled apart,
> that's not going to happen at any point soon. For the moment, this is

Agreed :)

> far better than the current state of affairs. So:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks

Regards,
Sudeep
