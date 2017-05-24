From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 24 May 2017 10:34:09 +0800
Subject: [PATCH 05/12] arm64: dts: Add I2C nodes for Hi3660
In-Reply-To: <CAL_JsqJUH-TOufw=dtpgDww_VEvyTW_LZuSQqRSU-cYbAqfJ6A@mail.gmail.com>
References: <20170517083745.24479-1-guodong.xu@linaro.org>
 <20170517083745.24479-6-guodong.xu@linaro.org>
 <20170523003908.ztuh4oohdk3g34pm@rob-hp-laptop>
 <94d06900-d871-7bc6-e1f3-d2b22ba20aaf@linaro.org>
 <CAL_JsqJUH-TOufw=dtpgDww_VEvyTW_LZuSQqRSU-cYbAqfJ6A@mail.gmail.com>
Message-ID: <10a19a02-21ac-364e-ab5c-de8aa16c3858@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Jarkko

Would you mind give some suggestion?

On 2017?05?23? 20:48, Rob Herring wrote:
>
>>>> +                       compatible = "snps,designware-i2c";
>>> These should have an SoC specific compatible.
>> We directly use drivers/i2c/busses/i2c-designware-platdrv.c,
>> do we still an soc specific compatible?
> It's fine if the driver uses the snps compatible, but the dts should
> still have an SoC specific one.
>
>> Checked arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi, and other examples,
>>
>> compatible = "snps,designware-i2c" is used.
> That was a mistake in the other platforms. We shouldn't continue repeating it.
>
> Rob

Rob suggest add something like "hisilicon,hi3660-dw-i2c" as well.
"The problem is dw-i2c does not give any clue as to what the 
configuration or version of the IP is.
Is that fully discoverable with version/capability registers? If not 
then you need a specific compatible.
Generally when we have not required them, it ends up being a problem 
later on."


While Documentation/devicetree/bindings/i2c/i2c-designware.txt
compatible : should be "snps,designware-i2c"

Besides, on Hikey960,
[    3.822353] dw_readl(dev, DW_IC_COMP_VERSION)=0x3132302a
[    3.827763] dw_readl(dev, DW_IC_COMP_TYPE)=0x44570140
Are these two registers enough to distinguish version etc?

Thanks
