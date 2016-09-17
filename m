From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Sep 2016 17:10:21 -0700
Subject: [PATCH] ARM: dts: msm8974: Add definitions for QCE & cryptobam
In-Reply-To: <32148db3-74b8-c81f-9688-b286d9516b9d@mm-sol.com>
References: <20160830153740.13275-1-voker57@gmail.com>
 <32148db3-74b8-c81f-9688-b286d9516b9d@mm-sol.com>
Message-ID: <06427c6c-cfbc-60b6-2646-70134fdbef5a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2016 06:09 AM, Stanimir Varbanov wrote:
> Hi Iaroslav,
>
> On 08/30/2016 06:37 PM, Iaroslav Gridin wrote:
>> From: Voker57 <voker57@gmail.com>
>>
>> Add device tree definitions for Qualcomm Cryptography engine and its BAM
>> Signed-off-by: Iaroslav Gridin <voker57@gmail.com>
>> ---
>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 42 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index 561d4d1..c0da739 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -287,6 +287,48 @@
>>  			reg = <0xf9011000 0x1000>;
>>  		};
>>  
>> +		cryptobam: dma at fd444000 {
>> +			compatible = "qcom,bam-v1.4.0";
>> +			reg = <0xfd444000 0x15000>;
>> +			interrupts = <0 236 0>;
> should be
>
> interrupts = <GIC_SPI 236 IRQ_NONE>;

Please don't use IRQ_NONE. This one looks to be IRQ_TYPE_EDGE_RISING if
I'm not mistaken.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
