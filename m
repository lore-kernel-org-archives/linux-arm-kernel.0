From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 06 Dec 2017 12:51:07 +0100
Subject: [PATCH 1/6] dt-bindings: marvell: Add documentation for the North
 Bridge PM on Armada 37xx
In-Reply-To: <20171204214706.4sbjgxme3ftmf3l3@rob-hp-laptop> (Rob Herring's
 message of "Mon, 4 Dec 2017 15:47:06 -0600")
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
 <20171201112508.14121-2-gregory.clement@free-electrons.com>
 <20171204214706.4sbjgxme3ftmf3l3@rob-hp-laptop>
Message-ID: <87zi6wt6qc.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
 
 On lun., d?c. 04 2017, Rob Herring <robh@kernel.org> wrote:

> On Fri, Dec 01, 2017 at 12:25:03PM +0100, Gregory CLEMENT wrote:
>> Extend the documentation of the Armada 37xx SoC with the the North
>> Bridge Power Management component.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  .../devicetree/bindings/arm/marvell/armada-37xx.txt   | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> index 51336e5fc761..7ad9830d9177 100644
>> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>> @@ -14,3 +14,22 @@ following property before the previous one:
>>  Example:
>>  
>>  compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
>> +
>> +
>> +Power management
>> +----------------
>> +
>> +For power management (particularly DVFS and AVS), the North Bridge
>> +Power Management component is needed:
>> +
>> +Required properties:
>> +- compatible     : should contain "marvell,armada-3700-nb-pm", "syscon";
>> +- reg            : the register start and length for the North Bridge
>> +		    Power Management
>> +
>> +Example:
>> +
>> +nb_pm: nb_pm at 14000 {
>
> Don't use underscore in node or property names. "syscon" is a better 
> choice here.

OK I will change this.

Thanks,

Gregory

>
>> +	compatible = "marvell,armada-3700-nb-pm", "syscon";
>> +	reg = <0x14000 0x60>;
>> +}
>> -- 
>> 2.15.0
>> 

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
