From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 25 Jun 2013 09:11:37 +0200
Subject: [PATCH 0/7] genirq: add irq_get_trigger_type() to get IRQ flags
In-Reply-To: <CACxGe6smNZofiGdO=nBM88MiWyoDvCTiPGFG5enEUwP_zCn17A@mail.gmail.com>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
 <CACxGe6smNZofiGdO=nBM88MiWyoDvCTiPGFG5enEUwP_zCn17A@mail.gmail.com>
Message-ID: <51C942A9.9070904@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2013 12:29 AM, Grant Likely wrote:
> On Fri, Jun 14, 2013 at 5:40 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> Drivers that want to get the trigger edge/level type flags for a
>> given interrupt have to first call irq_get_irq_data(irq) to get
>> the struct irq_data and then irqd_get_trigger_type(irq_data) to
>> obtain the IRQ flags.
>>
>> This is not only error prone but also unnecessary exposes the
>> struct irq_data to callers. This patch-set adds a new function
>> irq_get_trigger_type() to obtain the edge/level flags for an IRQ
>> and updates the places where irq_get_irq_data(irq) was called
>> just to obtain the flags from the struct irq_data.
>>
>> The patch-set is composed of the following patches:
>>
>> [PATCH 1/7] genirq: add irq_get_trigger_type() to get IRQ flags
>> [PATCH 2/7] gpio: mvebu: use irq_get_trigger_type() to get IRQ flags
>> [PATCH 3/7] mfd: twl4030-irq: use irq_get_trigger_type() to get IRQ flags
>> [PATCH 4/7] mfd: stmpe: use irq_get_trigger_type() to get IRQ flags
>> [PATCH 5/7] arm: orion: use irq_get_trigger_type() to get IRQ flags
>> [PATCH 6/7] MIPS: octeon: use irq_get_trigger_type() to get IRQ flags
>> [PATCH 7/7] irqdomain: use irq_get_trigger_type() to get IRQ flags
> 
> For the whole series:
> Acked-by: Grant Likely <grant.likely@linaro.org>
> 

Hello Thomas,

Do you have any comments on this patch-set?

It has been ack'ed by a lot of people so I wonder if you could take it.

Thanks a lot and best regards,
Javier
