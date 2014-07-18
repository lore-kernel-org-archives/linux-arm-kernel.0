From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jul 2014 04:11:11 +0900
Subject: [PATCHv2] ARM: dts: Add I2S dt node for Exynos3250
In-Reply-To: <53C865E3.5030806@samsung.com>
References: <1404874819-8257-1-git-send-email-cw00.choi@samsung.com>
 <53C865E3.5030806@samsung.com>
Message-ID: <53C9714F.1090301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/14 09:10, Chanwoo Choi wrote:
> On 07/09/2014 12:00 PM, Chanwoo Choi wrote:
>> From: Tomasz Figa<t.figa@samsung.com>
>>
>> This patch add I2S (Inter-IC Sound) dt node which supports 1-port stereo
>> (1 channels) IIS-bus for audio interface with DMA-based operation.
>>
>> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
>> Signed-off-by: Inha Song<ideal.song@samsung.com>
>> Tested-by: Inha Song<ideal.song@samsung.com>
>> Signed-off-by: Chanwoo Choi<cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park<kyungmin.park@samsung.com>
>> ---
>> Changes from v1:
>> - Fix wrong name of property (pinctrl-names)
>> - Change phanle name (i2s->i2s2)
>>
>>   arch/arm/boot/dts/exynos3250.dtsi | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
>> index 3e678fa..77a06df 100644
>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>> @@ -425,6 +425,19 @@
>>   			status = "disabled";
>>   		};
>>
>> +		i2s2: i2s at 13970000 {
>> +			compatible = "samsung,s3c6410-i2s";
>> +			reg =<0x13970000 0x100>;
>> +			interrupts =<0 126 0>;
>> +			clocks =<&cmu CLK_I2S>,<&cmu CLK_SCLK_I2S>;
>> +			clock-names = "iis", "i2s_opclk0";
>> +			dmas =<&pdma0 14>,<&pdma0 13>;
>> +			dma-names = "tx", "rx";
>> +			pinctrl-0 =<&i2s2_bus>;
>> +			pinctrl-names = "default";
>> +			status = "disabled";
>> +		};
>> +
>>   		pwm: pwm at 139D0000 {
>>   			compatible = "samsung,exynos4210-pwm";
>>   			reg =<0x139D0000 0x1000>;
>>
>
> Ping.
>
Applied, thanks.

- Kukjin
