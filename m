From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Mon, 07 Jul 2014 16:33:02 +0900
Subject: [PATCHv2 2/5] ARM: dts: exynos: unuse the slot-node and deprecated
 the supports-highspeed for dw-mmc
In-Reply-To: <000c01cf99b5$34ccc8c0$9e665a40$%jun@samsung.com>
References: <1404128960-27225-1-git-send-email-jh80.chung@samsung.com>
 <1404128960-27225-3-git-send-email-jh80.chung@samsung.com>
 <000c01cf99b5$34ccc8c0$9e665a40$%jun@samsung.com>
Message-ID: <53BA4D2E.40600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Seungwon.

I will fix it, and add  dt-file related with exynos3250. 

Best Regards,
Jaehoon Chung

On 07/07/2014 04:29 PM, Seungwon Jeon wrote:
> Hi Jaehoon,
> 
> Please check one thing below.
> 
> On Mon, June 30, 2014, Jaehoon Chung wrote:
>> dw-mmc controller can support multiple slots.
>> But, there are no use-cases anywhere. So we don't need to support the
>> slot-node for dw-mmc controller.
>> And "supports-highspeed" property in dw-mmc is deprecated.
>> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Reviewed-by: Tushar Behera <trblinux@gmail.com>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
> 
>> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-
>> octa.dts
>> index 434fd9d..5f37b81 100644
>> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
>> @@ -50,7 +50,6 @@
>>  	mmc at 12200000 {
>>  		status = "okay";
>>  		broken-cd;
>> -		supports-highspeed;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <0 4>;
>> @@ -58,16 +57,12 @@
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>>  		vmmc-supply = <&ldo10_reg>;
>> -
>> -		slot at 0 {
>> -			reg = <0>;
>> -			bus-width = <8>;
>> -		};
>> +		bus-width = <8>;
>> +		cap-mmc-highspeed;
>>  	};
>>
>>  	mmc at 12220000 {
>>  		status = "okay";
>> -		supports-highspeed;
>>  		card-detect-delay = <200>;
>>  		samsung,dw-mshc-ciu-div = <3>;
>>  		samsung,dw-mshc-sdr-timing = <2 3>;
>> @@ -75,11 +70,8 @@
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>>  		vmmc-supply = <&ldo10_reg>;
>> -
>> -		slot at 0 {
>> -			reg = <0>;
>> -			bus-width = <4>;
>> -		};
>> +		bus-width = <8>;
> <4> is correct?
> 
>> +		cap-mmc-highspeed;
> 
> Thanks,
> Seungwon Jeon
> 
> 
