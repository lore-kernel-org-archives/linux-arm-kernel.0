From: majun258@huawei.com (majun)
Date: Wed, 16 Dec 2015 09:23:19 -0500
Subject: [PATCH v9 1/4] dt-binding:Documents of the mbigen bindings
In-Reply-To: <20151211152629.GE20666@leverpostej>
References: <1448248513-39760-1-git-send-email-majun258@huawei.com>
 <1448248513-39760-2-git-send-email-majun258@huawei.com>
 <20151211152629.GE20666@leverpostej>
Message-ID: <567173D7.6060303@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark:

On 2015/12/11 10:26, Mark Rutland wrote:
> Hi,
> 
> On Mon, Nov 23, 2015 at 11:15:10AM +0800, MaJun wrote:
>> From: Ma Jun <majun258@huawei.com>
>>
>> Add the mbigen msi interrupt controller bindings document.
>>
>> This patch based on Mark Rutland's patch
>> https://lkml.org/lkml/2015/7/23/558
>>
>> Signed-off-by: Ma Jun <majun258@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/arm/mbigen.txt |   69 ++++++++++++++++++++++
>>  1 files changed, 69 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/mbigen.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mbigen.txt b/Documentation/devicetree/bindings/arm/mbigen.txt
>> new file mode 100644
>> index 0000000..8ae59a9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/mbigen.txt
>> @@ -0,0 +1,69 @@
>> +Hisilicon mbigen device tree bindings.
>> +=======================================
>> +
[...]
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source. The value must be 2.
>> +
>> +  The 1st cell is global hardware pin number of the interrupt.
>> +	This value depends on the Soc design.
> 
> I think a little more information is required here. Presumably the
> "global hardware pin number" is actually a pin number within the
> particular mbigen instance? i.e. it is local to this instance?
> 

Maybe "global hardware pin number" is  not an accurate definition of pin number and
makes people confused.

I will change it to "hardware pin number" to present the real pin number of
wired interrupt(from 0 to maximum interrupt number).

So, there is no global pin number or local pin number.

Thanks!
Majun


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
>> +-interrupts:specifies the interrupt source.
>> +  The 1st cell is global hardware pin number of the interrupt.
>> +		This value depends on the Soc design.
>> +  The 2nd cell is the interrupt trigger type(rising edge triggered or high
>> +		level triggered)
> 
> You should be able to refer to the usual interrupt bindings given you
> defined the format previously when describing #interrupt-cells.
> 
> Thanks,
> Mark.
> 
> .
> 
