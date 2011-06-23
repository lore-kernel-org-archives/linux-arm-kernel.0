From: khilman@ti.com (Kevin Hilman)
Date: Thu, 23 Jun 2011 14:57:03 -0700
Subject: [PATCH 25/25] ARM: pm: omap34xx: convert to generic
	suspend/resume support
In-Reply-To: <874o3g9xmv.fsf@ti.com> (Kevin Hilman's message of "Thu, 23 Jun
	2011 12:05:28 -0700")
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk> <874o3g9xmv.fsf@ti.com>
Message-ID: <871uyk8b4g.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Hi Russell,
>
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>
>> Convert sa11x0 to use the generic CPU suspend/resume support, rather
>> than implementing its own version.  Tested on 3430 LDP.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> I tested this on 3430/n900 and 3530/Overo and it worked fine for
> retention, but not for off.
>
> Testing with off-mode, I found the MULTI_CPU path to be broken in
> cpu_suspend (jumping to zero.)  

Problem found, and patch sent to list:

[PATCH] ARM: pm: add v7 suspend/resume functions to v7_processor functions

With that patch, off-mode in both suspend and idle is working on
3430/n900 and 3530/Overo when built in MULTI_CPU mode also.

Kevin
