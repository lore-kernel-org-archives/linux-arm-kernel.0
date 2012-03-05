From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 5 Mar 2012 16:08:37 +0100
Subject: [PATCH v2 7/7] Document: devicetree: add OF documents for arch-mmp
In-Reply-To: <201203051446.14600.arnd@arndb.de>
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
 <1330950111-30797-8-git-send-email-haojian.zhuang@marvell.com>
 <201203051446.14600.arnd@arndb.de>
Message-ID: <4F54D6F5.8050805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/5/2012 3:46 PM, Arnd Bergmann wrote:
> On Monday 05 March 2012, Haojian Zhuang wrote:
>> Add OF support in Document/devicetree directory.
>>
>> Signed-off-by: Haojian Zhuang<haojian.zhuang@marvell.com>
>
> Acked-by: Arnd Bergmann<arnd@arndb.de>
>
> One question for Benoit, Grant or Rob:
>
>> +Required properties:
>> +- compatible: should be "mrvl,sa1100-rtc"
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +- interrupts: Should be two. The first interrupt number is the rtc alarm
>> +  interrupt and the second interrupt number is the rtc hz interrupt.
>> +- interrupt-names: Assign name of irq resource.
>> +
>> +Example:
>> +	rtc: rtc at d4010000 {
>> +		compatible = "mrvl,mmp-rtc";
>> +		reg =<0xd4010000 0x1000>;
>> +		interrupts =<5>,<6>;
>> +		interrupt-name = "rtc 1Hz", "rtc alarm";
>> +	};
>
> When the binding for a device lists the interrupt-names property, should it
> also list the specific values for it? This one says that which ones they are,
> but I think we should actually mandate the exact string in the binding if
> we want to allow drivers to get the resource by its name.

Yes, indeed. The names are not some random strings, the driver will use 
get_resource_by_name and expect the name to be aligned with HW 
documentation and thus should be well documented in the binding.

Regards,
Benoit
