From: slash.tmp@free.fr (Mason)
Date: Tue, 25 Oct 2016 10:36:34 +0200
Subject: Disabling an interrupt in the handler locks the system up
In-Reply-To: <580F17E7.5060603@laposte.net>
References: <580A4460.2090306@free.fr>
 <a79e2d2c-8ec8-744f-50fb-8c39216aa23e@arm.com> <580A60ED.3030307@free.fr>
 <20161021201448.3f4a0a7a@arm.com> <580A70B9.8060507@free.fr>
 <alpine.DEB.2.20.1610212147420.4855@nanos> <580A7A2B.5000702@free.fr>
 <20161022123713.6dc788b3@arm.com> <580BF1D4.2030509@free.fr>
 <580E3308.4050507@free.fr> <alpine.DEB.2.20.1610241847580.5002@nanos>
 <580F17E7.5060603@laposte.net>
Message-ID: <580F1992.2070602@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/2016 10:29, Sebastian Frias wrote:

> On 10/24/2016 06:55 PM, Thomas Gleixner wrote:
>
>> On Mon, 24 Oct 2016, Mason wrote:
>>
>>> For the record, setting the IRQ_DISABLE_UNLAZY flag for this device
>>> makes the system lock-up disappear.
>>
>> The way how lazy irq disabling works is:
>>
>> 1) Interrupt is marked disabled in software, but the hardware is not masked
>>
>> 2) If the interrupt fires befor the interrupt is reenabled, then it's
>>    masked at the hardware level in the low level interrupt flow handler.
> 
> Would you mind explaining what is the intention behind?
> Because it does not seem obvious why there isn't a direct map between
> "disable_irq*()" and "mask_irq()"

I had a similar, but slightly different question:

What is the difference between struct irq_chip's

 * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
 * @irq_disable:	disable the interrupt
 * @irq_mask:		mask an interrupt source

(enable seems to default to unmask, but disable does not default to mask)

Regards.
