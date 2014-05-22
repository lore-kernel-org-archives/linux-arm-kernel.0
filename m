From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 22 May 2014 17:32:39 +0300
Subject: [Patch v5 3/7] mfd: ti-keystone-devctrl: add bindings for device
 state control
In-Reply-To: <20140522141432.GA19747@lee--X1>
References: <1400766516-14537-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400766516-14537-4-git-send-email-ivan.khoronzhuk@ti.com>
 <20140522141432.GA19747@lee--X1>
Message-ID: <537E0A87.5010408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/22/2014 05:14 PM, Lee Jones wrote:
> Why do I only have this patch?  Where is the rest of the set?  Also,
> it's on v5 and I don't recall seeing the other 4 versions?

It's strange I've sent whole series on

linux-kernel at vger.kernel.org
linux-arm-kernel at lists.infradead.org
linux-doc at vger.kernel.org
devicetree at vger.kernel.org

v4 is also was sent to lists in question:
https://lkml.org/lkml/2014/5/21/359

>> The Keystone II devices have a set of registers that are used to control
>> the status of its peripherals. This node is intended to allow access to
>> this functionality.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
>> ---
>>   .../devicetree/bindings/mfd/ti-keystone-devctrl.txt   | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
>> new file mode 100644
>> index 0000000..35f7a66
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
>> @@ -0,0 +1,19 @@
>> +* Device tree bindings for Texas Instruments keystone device state control
>> +
>> +The Keystone II devices have a set of registers that are used to control
>> +the status of its peripherals. This node is intended to allow access to
>> +this functionality.
>> +
>> +Required properties:
>> +
>> +- compatible:		"ti,keystone-devctrl", "syscon"
>> +
>> +- reg:			contains offset/length value for pll controller
>> +			registers space.
> Why have you tabbed out all that way?

I'll correct

>
>> +Example:
>> +
>> +devctrl: device-state-control {
> This node needs an address:
>
> devctrl: device-state-control at 02620000 {

Thanks!
I will correct

>> +	compatible = "ti,keystone-devctrl", "syscon";
>> +	reg = <0x02620000 0x1000>;
>> +};

-- 
Regards,
Ivan Khoronzhuk
