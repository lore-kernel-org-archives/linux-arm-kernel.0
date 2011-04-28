From: avictor.za@gmail.com (Andrew Victor)
Date: Thu, 28 Apr 2011 19:12:23 +0200
Subject: AT91: Convert to fasteoi IRQ handler, and remove ARM irq_finish
In-Reply-To: <20110428151819.GE13755@siel.b>
References: <1303909742.18407.12.camel@redbox> <20110428151819.GE13755@siel.b>
Message-ID: <BANLkTimUPfo0kMn3HPa5iZUO5g_b6rVKcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

>> - ? ? desc->irq_data.chip->irq_unmask(&desc->irq_data);
>> - ? ? /* now it may re-trigger */
>> + ? ? /* acknowledge interrupt - now it may re-trigger */
>> + ? ? desc->irq_data.chip->irq_eoi(&desc->irq_data);
>> ?}
>
> why does this handler mess with the parent irq chip ?
> this looks pretty wrong to me.

This is a chained-handler, and without that line the end-of-interrupt
doesn't seem to be signalled.


Regards,
  Andrew Victor
