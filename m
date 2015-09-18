From: rjui@broadcom.com (Ray Jui)
Date: Fri, 18 Sep 2015 14:57:15 -0700
Subject: [PATCH v2 4/9] ARM: dts: Put Cygnus core components under core bus
In-Reply-To: <1472876.fGCm1r9KFG@wuerfel>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
 <1442611454-16331-5-git-send-email-rjui@broadcom.com>
 <1472876.fGCm1r9KFG@wuerfel>
Message-ID: <55FC88BB.2000608@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/18/2015 2:30 PM, Arnd Bergmann wrote:
> On Friday 18 September 2015 14:24:09 Ray Jui wrote:
>>
>> +       core {
>> +               compatible = "simple-bus";
>> +               ranges;
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +
>> +               timer at 19020200 {
>> +                       compatible = "arm,cortex-a9-global-timer";
>> +                       reg = <0x19020200 0x100>;
>> +                       interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&periph_clk>;
>> +               };
>> +
>> +               gic: interrupt-controller at 19021000 {
>>
> 
> Could it be that all 'core' components are in the 0x19xxxxxx address range?
> If so, please set up an appropriate ranges property for the bus. Also
> add the address field for the bus according to which addresses are routed
> to it.
> 
> 	Arnd
> 

Yes all 'core' components are in the 0x19xxxxx address range for Cygnus.
It's fine and makes sense to set up proper ranges for this bus. But I
might have some issues with the 'soc' components and the 'soc' bus,
which I'll explain and discuss on the next email.

Ray
