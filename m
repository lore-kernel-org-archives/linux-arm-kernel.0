From: slash.tmp@free.fr (Mason)
Date: Sun, 16 Jul 2017 22:50:17 +0200
Subject: [PATCH] irqchip/gic: Use GIC_SPI symbolic constant
In-Reply-To: <86shhwywas.fsf@arm.com>
References: <e25e0ac5-abe2-6024-f669-c5352183114e@free.fr>
 <86shhwywas.fsf@arm.com>
Message-ID: <d0701807-74fb-f54e-ccff-378c15da076e@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/2017 22:13, Marc Zyngier wrote:

> Mason wrote:
> 
>> Use GIC_SPI explicitly instead of an implicit 0.
> 
> What bug is this fixing? What benefit does this bring?

The patch aims to replace an (implicit) literal constant
with the corresponding symbolic macro. IMO, it makes the
intent somewhat clearer, and, more importantly, grepping
for said symbol now returns the respective file/line.
(It took me a while to find the line.)

Are you saying that changing the code at this point is
not worth the trouble?

>> FWIW, 'make C=2' flagged a few lines:
>>
>> $ make C=2 drivers/irqchip/irq-gic.o
>>   CHECK   drivers/irqchip/irq-gic.c
>> drivers/irqchip/irq-gic.c:1079:44: warning: incorrect type in assignment (different address spaces)
>> drivers/irqchip/irq-gic.c:1079:44:    expected void [noderef] <asn:3>*[noderef] <asn:2>*percpu_base
>> drivers/irqchip/irq-gic.c:1079:44:    got void [noderef] <asn:2>*[noderef] <asn:3>*<noident>
> 
> How is that related to this patch?

I tested the patch with 'make C=2' and reported the
output FWIW. Are you saying I should have written
a separate message, or not bothered altogether?

Regards.
