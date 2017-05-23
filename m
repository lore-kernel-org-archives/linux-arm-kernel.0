From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 07:48:10 -0500
Subject: [PATCH 05/12] arm64: dts: Add I2C nodes for Hi3660
In-Reply-To: <94d06900-d871-7bc6-e1f3-d2b22ba20aaf@linaro.org>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
 <20170517083745.24479-6-guodong.xu@linaro.org>
 <20170523003908.ztuh4oohdk3g34pm@rob-hp-laptop>
 <94d06900-d871-7bc6-e1f3-d2b22ba20aaf@linaro.org>
Message-ID: <CAL_JsqJUH-TOufw=dtpgDww_VEvyTW_LZuSQqRSU-cYbAqfJ6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 12:55 AM, zhangfei <zhangfei.gao@linaro.org> wrote:
> Hi, Rob
>
>
> Thanks for the review.
>
>
> On 2017?05?23? 08:39, Rob Herring wrote:
>>
>> On Wed, May 17, 2017 at 04:37:38PM +0800, Guodong Xu wrote:
>>>
>>> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>
>>> Add I2C nodes for Hi3660-hikey960.
>>>
>>> On HiKey960,
>>> I2C0, I2C7 is connected to Low Speed Expansion Connector.
>>> I2C1 is connected to ADV7535.
>>> I2C3 is connected to USB5734.

[...]

>>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>> b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>> index f55710a..f217c9d 100644
>>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>>> @@ -186,6 +186,62 @@
>>>                         #reset-cells = <2>;
>>>                 };
>>>   +             i2c0: i2c at FFD71000 {
>>
>> lowercase hex please.
>
> Yes, will change
>>
>>
>>> +                       compatible = "snps,designware-i2c";
>>
>> These should have an SoC specific compatible.
>
> We directly use drivers/i2c/busses/i2c-designware-platdrv.c,
> do we still an soc specific compatible?

It's fine if the driver uses the snps compatible, but the dts should
still have an SoC specific one.

> Checked arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi, and other examples,
>
> compatible = "snps,designware-i2c" is used.

That was a mistake in the other platforms. We shouldn't continue repeating it.

Rob
