From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 30 Sep 2014 17:31:20 +0800
Subject: [PATCH v2 3/3] ARM: dts: hix5hd2: add i2c node
In-Reply-To: <2637538.ufF2KQPbi9@wuerfel>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org>
 <1411878129-19743-4-git-send-email-zhangfei.gao@linaro.org>
 <2637538.ufF2KQPbi9@wuerfel>
Message-ID: <542A7868.8080306@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/9/30 17:02, Arnd Bergmann wrote:
> On Sunday 28 September 2014 12:22:09 Zhangfei Gao wrote:
>> +
>> +               i2c0: i2c at b10000 {
>> +                       compatible = "hisilicon,hix5hd2-i2c";
>> +                       reg = <0xb10000 0x1000>;
>> +                       interrupts = <0 38 4>;
>> +                       clocks = <&clock HIX5HD2_I2C0_RST>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       status = "disabled";
>> +               };
>>

Hi Arnd,
 
> HIX5HD2_I2C0_RST is not defined anywhere, so this will result in the
> same build error that has required reverting a lot of patches for the
> 3.18 merge window.

Sorry again for bringing so much troubles to you, Olof and Stephen.
On 9/30, Mike Turquette has already accepted the clock pull request
which includes the HIX5HD2_I2C0_RST definition.

> How do you plan to deal with the dependency in the future? 

In the future, I will check the dependence firstly about the patches.
When creating pull request tag, I will test it and make sure it works.
And I will also make sure that the order of the pull request is sent correctly.

Best Regards,
Wei

> 	Arnd
> 
> .
> 
