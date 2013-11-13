From: r.sricharan@ti.com (Sricharan R)
Date: Wed, 13 Nov 2013 21:02:04 +0530
Subject: [PATCH V3 1/7] DRIVERS: IRQCHIP: IRQ-GIC: Add support for routable
 irqs
In-Reply-To: <528399B2.8010308@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
 <1383657257-3458-2-git-send-email-r.sricharan@ti.com>
 <528399B2.8010308@ti.com>
Message-ID: <52839B74.4010600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Wednesday 13 November 2013 08:54 PM, Santosh Shilimkar wrote:
> On Tuesday 05 November 2013 08:14 AM, Sricharan R wrote:
>> In some socs the gic can be preceded by a crossbar IP which
>> routes the peripheral interrupts to the gic inputs. The peripheral
>> interrupts are associated with a fixed crossbar input line and the
>> crossbar routes that to one of the free gic input line.
>>
>> The DT entries for peripherals provides the fixed crossbar input line
>> as its interrupt number and the mapping code should associate this with
>> a free gic input line. This patch adds the support inside the gic irqchip
>> to handle such routable irqs. The routable irqs are registered in a linear
>> domain. The registered routable domain's callback should be implemented
>> to get a free irq and to configure the IP to route it.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Thanks Santosh. Will repost all with the minor changes suggested.

Regards,
 Sricharan
