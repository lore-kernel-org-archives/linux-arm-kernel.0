From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 1 Aug 2016 13:55:27 +0100
Subject: [PATCH 2/2] soc: nxp: Add a RCPM driver
In-Reply-To: <2024386.Ra8uvttlE9@wuerfel>
References: <1470044943-3814-1-git-send-email-chenhui.zhao@nxp.com>
 <1470044943-3814-2-git-send-email-chenhui.zhao@nxp.com>
 <2024386.Ra8uvttlE9@wuerfel>
Message-ID: <579F46BF.4080604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/16 13:25, Arnd Bergmann wrote:
> On Monday, August 1, 2016 5:49:03 PM CEST Chenhui Zhao wrote:
>> The NXP's QorIQ Processors based on ARM Core have a RCPM module
>> (Run Control and Power Management), which performs all device-level
>> tasks associated with power management.
>>
>> This patch mainly implements the wakeup sources configuration before
>> entering LPM20, a low power state of device-level. The devices can be
>> waked up by specified sources, such as Flextimer, GPIO and so on.
>>
>> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> 
> Adding irqchip maintainers to cc, as this wakeup handling is normally
> part of the irq controller.

Thanks for looping me in. This very much look like it should be a
stacked irqchip, just like we handle everything else. I'll go and review
the actual patch.

	M.
-- 
Jazz is not dead. It just smells funny...
