From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 22:26:37 +0530
Subject: [PATCHv2 07/11] arm: arch_timer: divorce from local_timer api
In-Reply-To: <20130111164635.GA1794@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-8-git-send-email-mark.rutland@arm.com>
 <50F014DF.7090205@ti.com> <20130111164635.GA1794@arm.com>
Message-ID: <50F04445.70506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 January 2013 10:16 PM, Catalin Marinas wrote:
> On Fri, Jan 11, 2013 at 01:34:23PM +0000, Santosh Shilimkar wrote:
>> On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
>>> Currently, the arch_timer driver is tied to the arm port, as it relies
>>> on code in arch/arm/smp.c to setup and teardown timers as cores are
>>> hotplugged on and off. The timer is registered through an arm-specific
>>> registration mechanism, preventing sharing the driver with the arm64
>>> port.
>>>
>>> This patch moves the driver to using a cpu notifier instead, making it
>>> easier to port.
>>>
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>> This is really a nit idea. I think we should do the same
>> for ARM gic code.
>
> I plan to do the same once Rob's GIC patches get merged. In my
> soc-armv8-model branch I have a copy of gic.c into drivers/irqchip and
> the CPU interface is done automatically via a notifier. The only trick
> is to set the priority of the GIC notifier higher than the timer one.
>
Great. Thanks for the information.

Regards,
Santosh
