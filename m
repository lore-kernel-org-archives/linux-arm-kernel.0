From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 20 May 2014 19:24:16 -0700
Subject: [PATCH RESEND 2/2] Documentation: add Broadcom STB Level-2
 interrupt controller binding
In-Reply-To: <20140521013027.GD8664@titan.lakedaemon.net>
References: <1400613229-19049-1-git-send-email-f.fainelli@gmail.com>
 <1400613229-19049-3-git-send-email-f.fainelli@gmail.com>
 <20140521013027.GD8664@titan.lakedaemon.net>
Message-ID: <537C0E50.4050409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/05/2014 18:30, Jason Cooper a ?crit :
> On Tue, May 20, 2014 at 12:13:49PM -0700, Florian Fainelli wrote:
>> This patch adds the Device Tree binding document for the Broadcom
>> Set-top-box Level 2 interrupt controller hardware.
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   .../bindings/interrupt-controller/brcm,l2-intc.txt | 29 ++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
>> new file mode 100644
>> index 000000000000..448273a30a11
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
>> @@ -0,0 +1,29 @@
>> +Broadcom Generic Level 2 Interrupt Controller
>> +
>> +Required properties:
>> +
>> +- compatible: should be "brcm,l2-intc"
>> +- reg: specifies the base physical address and size of the registers
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +- #interrupt-cells: specifies the number of cells needed to encode an
>> +  interrupt source. Should be 1.
>> +- interrupt-parent: specifies the phandle to the parent interrupt controller
>> +  this controller is cacaded from
>> +- interrupts: specifies the interrupt line in the interrupt-parent irq space
>> +  to be used for cascading
>> +
>> +Optional properties:
>> +
>> +- brcm,irq-can-wake: If present, this means the L2 controller can be used as a
>> +  wakeup source for system suspend/resume.
>
> Do we need a vendor-specific property here?  I'd much prefer to see a
> generic implementation.

Is there an usable generic property? We came up with a custom one 
because there is not a generic one AFAICT.
