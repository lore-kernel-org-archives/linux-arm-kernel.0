From: slash.tmp@free.fr (Mason)
Date: Fri, 04 Sep 2015 19:46:04 +0200
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <yw1x8u8mxht2.fsf@unicorn.mansr.com>
References: <55E5CED8.7000408@free.fr>
 <55E5D945.3040504@gmail.com>	<55E722F2.50905@free.fr>
 <yw1xy4goyc3z.fsf@unicorn.mansr.com>	<55E73971.8030406@free.fr>
 <55E9C33A.2080801@free.fr> <yw1x8u8mxht2.fsf@unicorn.mansr.com>
Message-ID: <55E9D8DC.6090201@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2015 18:36, M?ns Rullg?rd wrote:

> Mason wrote:
> 
>> There's just too much DT syntax that flies light-years over my head.
>> #address-cells, #size-cells, #interrupt-cells, ranges, aliases, etc.
>> Basically, all I understand is /dts-v1/;
>> (Anyone have links to good tutorials?)
>>
>> I've attached the current version I'm playing with (I tried to make it
>> as small as possible). If some charitable soul spots an obvious problem...
>> (Commented blocks have been tested uncommented, of course.)
> 
> What happens when you try to boot with this device tree?

It panics in tangox_irq_init IIRC.

> Are you sure these addresses are correct?  Those are the values from
> tango3.

AFAIU, that HW block hasn't changed in a long time, but I'll
double-check to be sure.

>> 			interrupt-parent = <&gic>;
>> 			interrupt-controller;
>> 			#address-cells = <1>;
>> 			#size-cells = <1>;
>>
>> 			irqintc: irq at 000 {
>> 				reg = <0x000 0x100>;
>> 				interrupt-controller;
>> 				#interrupt-cells = <2>;
>> 				interrupts = <2>;
> 
> This "interrupts" specification is wrong for a source wired into the
> GIC.  For the correct format, see the binding spec in
> Documentation/devicetree/bindings/arm/gic.txt:

Doooh! I'd read that document (about 12 times) but for some
reason, it never occurred to me that I had to follow the
syntax for the intc (although that seems obvious now that
you mention it).

I suspect you've nailed my problem. Wish I could test right
away, but it'll have to wait after the weekend.

Thanks (again).

Regards.
