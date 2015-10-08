From: w.f@huawei.com (wangfei)
Date: Thu, 8 Oct 2015 14:33:06 +0800
Subject: [PATCH 1/8] dt-bindings: pmic: Document Hi655x pmic driver
In-Reply-To: <20150930173921.GJ15635@sirena.org.uk>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
 <1443611111-3196-2-git-send-email-w.f@huawei.com>
 <20150930173921.GJ15635@sirena.org.uk>
Message-ID: <56160E22.3010703@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/1 1:39, Mark Brown wrote:
> On Wed, Sep 30, 2015 at 07:05:04PM +0800, Fei Wang wrote:
> 
>> +Hisilicon hi655x Power Management Integrated Circuit (PMIC)
>> +
>> +hi655x consists of a large and varied group of sub-devices:
>> +
>> +Device			 Supply Names	 Description
>> +------			 ------------	 -----------
>> +hi655x-powerkey		:		: Powerkey
>> +hi655x-regulator-pmic	:		: Regulators
>> +hi655x-usbvbus		:		: USB plug detection
>> +hi655x-pmu-rtc		:		: RTC
>> +hi655x-coul		:		: Coulomb
> 
> ...counter?
> 
> There's no documentation of the bindings for any of the above devices or
> how things are structured, you need to provide binding documentation
> which is understandable standalone.  None of the properties are
> documented, nor is the set of regulators supported or how this is
> structured.

OK,i will add them.
> 
>> +                coul: coul at 1 {
>> +                        compatible = "hisilicon,hi655x-coul";
>> +                        interrupt-parent = <&pmic>;
>> +                        interrupts = <24 0>, <25 0>, <26 0>, <27 0>;
>> +                        interrupt-names = "cl_int_i", "cl_out_i", "cl_in_i", "vbat_int_i";
>> +                        battery_product_index = <0>;
> 
> For example, the "battery_product_index" property here is undocumented.

now on hikey, we only enable hi655x-regulator-pmic function, and regulator is child node of pmic.do i need to document regulator dt-binding in this file or create a new regulator dt-binding file?
> 
