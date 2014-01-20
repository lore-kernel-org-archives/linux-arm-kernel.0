From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 20 Jan 2014 22:42:18 +0100
Subject: [PATCH] ARM: mvebu: fix compilation warning on Armada 370 (i.e.
 non-SMP)
In-Reply-To: <3644485.dCdZFrR2be@wuerfel> (Arnd Bergmann's message of "Mon, 20
 Jan 2014 21:18:11 +0100")
References: <87r48276ne.fsf@natisbad.org> <3644485.dCdZFrR2be@wuerfel>
Message-ID: <87zjmq8h51.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday 20 January 2014 21:14:13 Arnaud Ebalard wrote:
>> diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
>> index 433cc8568dec..499c5070f841 100644
>> --- a/drivers/irqchip/irq-armada-370-xp.c
>> +++ b/drivers/irqchip/irq-armada-370-xp.c
>> @@ -59,7 +59,9 @@
>>  #define PCI_MSI_DOORBELL_END                    (32)
>>  #define PCI_MSI_DOORBELL_MASK                   0xFFFF0000
>>  
>> +#ifdef CONFIG_SMP
>>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>> +#endif
>>  
>>  static void __iomem *per_cpu_
>
> How about moving it inside of the existing #ifdef?
>
> That also brings it closer to the one place it's used.

I also hesitated but decided to let the declaration of this global
at the beginning of the file. I will send a v2 with the declaration
moved inside the existing #ifdef.

Cheers,

a+
