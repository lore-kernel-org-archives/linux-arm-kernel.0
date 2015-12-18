From: majun258@huawei.com (majun (F))
Date: Fri, 18 Dec 2015 09:58:20 +0800
Subject: [PATCH v10 1/4] dt-binding:Documents of the mbigen bindings
In-Reply-To: <20151217135247.GD13389@leverpostej>
References: <1450353397-47668-1-git-send-email-majun258@huawei.com>
 <1450353397-47668-2-git-send-email-majun258@huawei.com>
 <20151217135247.GD13389@leverpostej>
Message-ID: <5673683C.2080304@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark:

? 2015/12/17 21:52, Mark Rutland ??:
> On Thu, Dec 17, 2015 at 07:56:34PM +0800, MaJun wrote:
>> From: Ma Jun <majun258@huawei.com>
[...]
>> +- compatible: Should be "hisilicon,mbigen-v2"
>> +
>> +- reg: Specifies the base physical address and size of the Mbigen
>> +  registers.
>> +
>> +- interrupt controller: Identifies the node as an interrupt controller
>> +
>> +- msi-parent: Specifies the MSI controller this mbigen use.
>> +  For more detail information,please refer to the generic msi-parent binding in
>> +  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
>> +
>> +- num-msis:Specifies the total number of interrupt this device has.
> 
> Is this the number of pins implemented? Or the number of pins that are
> in use?
> 
> The latter feels like something we can derive.

num-msis means the total number of pins implemented.

> 
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source. The value must be 2.
>> +
>> +  The 1st cell is hardware pin number of the interrupt.This number is local to
>> +  each mbigen chip and in the range from 0 to the maximum interrupts number
>> +  of the mbigen.
> 
> Just to check: 0 - 63 represent the "reserved" pins, yes?

Yes, you are right.

> 
> Other than those questions, this looks good to me.

Do i need to post a new patch to update these two questions?

Thanks!
MaJun

> 
> Thanks,
> Mark.
> 
>> +
>> +  The 2nd cell is the interrupt trigger type.
>> +	The value of this cell should be:
>> +	1: rising edge triggered
>> +	or
>> +	4: high level triggered
>> +
>> +Examples:
>> +
>> + 	mbigen_device_gmac:intc {
>> +			compatible = "hisilicon,mbigen-v2";
>> +			reg = <0x0 0xc0080000 0x0 0x10000>;
>> +			interrupt-controller;
>> +			msi-parent = <&its_dsa 0x40b1c>;
>> +			num-msis = <9>;
>> +			#interrupt-cells = <2>;
>> + 	};
>> +
>> +Devices connect to mbigen required properties:
>> +----------------------------------------------------
>> +-interrupt-parent: Specifies the mbigen device node which device connected.
>> +
>> +-interrupts:Specifies the interrupt source.
>> + For the specific information of each cell in this property,please refer to
>> + the "interrupt-cells" description mentioned above.
>> +
>> +Examples:
>> +	gmac0: ethernet at c2080000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <0 0xc2080000 0 0x20000>,
>> +		      <0 0xc0000000 0 0x1000>;
>> +		interrupt-parent  = <&mbigen_device_gmac>;
>> +		interrupts =	<656 1>,
>> +				<657 1>;
>> +	};
>> +
>> -- 
>> 1.7.1
>>
>>
> 
> .
> 
