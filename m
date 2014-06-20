From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 21 Jun 2014 01:00:21 +0400
Subject: [PATCH v4 1/2] ARM: shmobile: r8a7790: add internal PCI bridge
 nodes
In-Reply-To: <4637423.jWRbL1GbCK@wuerfel>
References: <201406210034.57784.sergei.shtylyov@cogentembedded.com>
 <201406210036.59693.sergei.shtylyov@cogentembedded.com>
 <4637423.jWRbL1GbCK@wuerfel>
Message-ID: <53A4A0E5.50904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/21/2014 12:51 AM, Arnd Bergmann wrote:

>> +       pci0: pci at ee090000 {
>> +               compatible = "renesas,pci-r8a7790";
>> +               clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
>> +               reg = <0x0 0xee090000 0x0 0xc00>,
>> +                     <0x0 0xee080000 0x0 0x1100>;
>> +               interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
>> +               status = "disabled";
>> +
>> +               bus-range = <0 0>;
>> +               #address-cells = >;
>> +               #size-cells = <2>;
>> +               #interrupt-cells = <1>;
>> +               interrupt-map-mask = <0xff00 0 0 0x7>;
>> +               interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>> +                                0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
>> +                                0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
>> +       };

> Hmm, this device node is not actually compliant to the PCI binding,
> it needs a "ranges" property that can be used to look up the memory
> and I/O space windows.

    The PCI driver doesn't support I/O space.

> It also needs a device_type property.

    Hm, are you sure about that? I thought only PCI devices should have it...

> I realize that the driver doesn't currently use them, but you should
> adhere to the binding anyway, so we can fix the driver at some point.

    Sigh, agreed about the need to fix the driver. Too bad you've spoken up 
only now though. And you've ACKed the DT bindings without those properties 
documented or even present in an example... :-(

> 	Arnd

WBR, Sergei
