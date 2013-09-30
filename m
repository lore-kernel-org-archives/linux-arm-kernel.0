From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 10:22:03 -0400
Subject: [RFC PATCH 1/6] DRIVERS: IRQCHIP: IRQ-GIC: Add support for
 routable irqs
In-Reply-To: <524987A3.4090204@arm.com>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com>
 <1380549564-31045-2-git-send-email-r.sricharan@ti.com>
 <524987A3.4090204@arm.com>
Message-ID: <5249890B.7020906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 September 2013 10:16 AM, Marc Zyngier wrote:
> On 30/09/13 14:59, Sricharan R wrote:
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
> 
> Isn't this just another chained interrupt controller? How is it GIC
> specific?
> 
No it isn't a irq controller rather a event router. Patch is missing
reference to the previous discussion. Previous discussion is here [1]

Regards,
Santosh

[1] https://lkml.org/lkml/2013/9/13/413
