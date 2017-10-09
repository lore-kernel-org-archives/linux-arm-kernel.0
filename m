From: kevin.wangtao@hisilicon.com (Wangtao (Kevin, Kirin))
Date: Mon, 9 Oct 2017 10:38:18 +0800
Subject: [PATCH 9/9] arm64: dts: register Hi3660's thermal sensor
In-Reply-To: <f83a0936-23cc-0f5e-b6a3-c3adf1a0d7a0@linaro.org>
References: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1506073332-92438-10-git-send-email-kevin.wangtao@hisilicon.com>
 <f83a0936-23cc-0f5e-b6a3-c3adf1a0d7a0@linaro.org>
Message-ID: <87bf0cfb-d465-03a3-004c-6c7957e33006@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



on 2017/10/3 3:06, Daniel Lezcano wrote:
> On 22/09/2017 11:42, Tao Wang wrote:
>> From: Kevin Wangtao <kevin.wangtao@linaro.org>
>>
>> add binding for tsensor on H3660, this tsensor is used for
>> SoC thermal control, it supports alarm interrupt.
>>
>> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
> 
> I'm not able to apply this patch. Does it rely on another patch?
No, This patch is based on linux-next
> 
>> ---
>>   arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index b7a90d6..ae90991 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -978,5 +978,13 @@
>>   			clocks = <&crg_ctrl HI3660_OSC32K>;
>>   			clock-names = "apb_pclk";
>>   		};
>> +
>> +		tsensor: tsensor at fff30000 {
>> +			compatible = "hisilicon,hi3660-tsensor";
>> +			reg = <0x0 0xfff30000 0x0 0x1000>;
>> +			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>> +			#thermal-sensor-cells = <1>;
>> +		};
>> +
>>   	};
>>   };
>>
> 
> 
