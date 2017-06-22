From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 22 Jun 2017 16:06:08 +0800
Subject: [PATCH v2 7/7] ARM: dts: rockchip: add efuse device node for
 rk3228
In-Reply-To: <37478525.gTCCky7JDB@phil>
References: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
 <1498116278-3791-1-git-send-email-frank.wang@rock-chips.com>
 <37478525.gTCCky7JDB@phil>
Message-ID: <af1c004a-1031-25ae-4d8f-9945520b3ed1@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2017/6/22 15:27, Heiko Stuebner wrote:
> Hi Frank,
>
> Am Donnerstag, 22. Juni 2017, 15:24:38 CEST schrieb Frank Wang:
>> From: Finley Xiao <finley.xiao@rock-chips.com>
>>
>> Add a efuse node in the device tree for the rk3228 SoC.
>>
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rk322x.dtsi | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
>> index bd7ef53..a8697fe 100644
>> --- a/arch/arm/boot/dts/rk322x.dtsi
>> +++ b/arch/arm/boot/dts/rk322x.dtsi
>> @@ -336,6 +336,23 @@
>>   		status = "disabled";
>>   	};
>>   
>> +	efuse: efuse at 11040000 {
>> +		compatible = "rockchip,rk322x-efuse";
> you wanted to update the compatible in the efuse driver + binding txt
> and then here as well (aka rk3228-efuse).

Sorry, I will fix it and resend these series soon.

BR.
Frank

>
> Heiko
>
>> +		reg = <0x11040000 0x20>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		clocks = <&cru PCLK_EFUSE_256>;
>> +		clock-names = "pclk_efuse";
>> +
>> +		/* Data cells */
>> +		efuse_id: id at 7 {
>> +			reg = <0x7 0x10>;
>> +		};
>> +		cpu_leakage: cpu_leakage at 17 {
>> +			reg = <0x17 0x1>;
>> +		};
>> +	};
>> +
>>   	i2c0: i2c at 11050000 {
>>   		compatible = "rockchip,rk3228-i2c";
>>   		reg = <0x11050000 0x1000>;
>>
>
>
>
>
