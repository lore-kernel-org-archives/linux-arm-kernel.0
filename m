From: anurupvasu@gmail.com (Anurup M)
Date: Thu, 5 Jan 2017 10:28:54 +0530
Subject: [PATCH v3 02/10] dt-bindings: hisi: Add Hisilicon HiP05/06/07
 Djtag dts bindings
In-Reply-To: <20170103225623.ynhc7n267jpzu44z@rob-hp-laptop>
References: <1483339743-23881-1-git-send-email-anurup.m@huawei.com>
 <20170103225623.ynhc7n267jpzu44z@rob-hp-laptop>
Message-ID: <586DD28E.5050500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 04 January 2017 04:26 AM, Rob Herring wrote:
> On Mon, Jan 02, 2017 at 01:49:03AM -0500, Anurup M wrote:
>> From: Tan Xiaojun <tanxiaojun@huawei.com>
>>
>> Add Hisilicon HiP05/06/07 Djtag dts bindings for CPU and IO Die
>>
>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>> ---
>>   .../devicetree/bindings/arm/hisilicon/djtag.txt    | 41 ++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>> new file mode 100644
>> index 0000000..bbe8b45
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>> @@ -0,0 +1,41 @@
>> +The Hisilicon Djtag is an independent component which connects with some other
>> +components in the SoC by Debug Bus. The djtag is available in CPU and IO dies
>> +in the chip. The djtag controls access to connecting modules of CPU and IO
>> +dies.
>> +The various connecting components in CPU die (like L3 cache, L3 cache PMU etc.)
>> +are accessed by djtag during real time debugging. In IO die there are connecting
>> +components like RSA. These components appear as devices attached to djtag bus.
>> +
>> +Hisilicon HiP05/06/07 djtag for CPU and IO die
>> +Required properties:
>> +  - compatible : The value should be as follows
>> +	(a) "hisilicon,hip05-djtag-v1" for CPU and IO die which use v1 hw in
>> +	    HiP05 chipset.
> You don't need to distinguish the CPU and IO blocks?

The CPU and IO djtag nodes will have different base address(in reg 
property).
There is no difference in handling of CPU and IO dies in the djtag driver.
So there is currently no need to distinguish them.

>> +	(b) "hisilicon,hip06-djtag-v1" for CPU die which use v1 hw in HiP06 chipset.
>> +	(c) "hisilicon,hip06-djtag-v2" for IO die which use v2 hw in HiP06 chipset.
>> +	(d) "hisilicon,hip07-djtag-v2" for CPU and IO die which use v2 hw in
>> +	    HiP07 chipset.
>> +  - reg : Register address and size
>> +  - hisi-scl-id : The Super Cluster ID for CPU or IO die
> Still needs a vendor prefix. i.e. hisilicon,scl-id
>

Ok. I shall modify it.

Thanks,
Anurup

>> +
>> +Example 1: Djtag for CPU die
>> +
>> +	/* for Hisilicon HiP05 djtag for CPU Die */
>> +	djtag0: djtag at 80010000 {
>> +		compatible = "hisilicon,hip05-djtag-v1";
>> +		reg = <0x0 0x80010000 0x0 0x10000>;
>> +		hisi-scl-id = <0x02>;
>> +
>> +		/* All connecting components will appear as child nodes */
>> +	};
>> +
>> +Example 2: Djtag for IO die
>> +
>> +	/* for Hisilicon HiP05 djtag for IO Die */
>> +	djtag1: djtag at d0000000 {
>> +		compatible = "hisilicon,hip05-djtag-v1";
>> +		reg = <0x0 0xd0000000 0x0 0x10000>;
>> +		hisi-scl-id = <0x01>;
>> +
>> +		/* All connecting components will appear as child nodes */
>> +	};
>> -- 
>> 2.1.4
>>
